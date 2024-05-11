import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/general_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/internet_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/status.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import 'package:mdms_iosand/src/features/core/screens/os/os_controller.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/controller_os.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/screen_os.dart';

class OsHomeScreen extends StatefulWidget {
  const OsHomeScreen({super.key});

  @override
  OsHomeScreenState createState() => OsHomeScreenState();
}

class OsHomeScreenState extends State<OsHomeScreen> {
  bool showsrc = false;
  final osController = Get.put(OsController());
  final prtController = Get.put(PartyOsController());

  Future<void> _handleRefresh() async {
    osController.applyfilters('');
    osController.refreshListApi();
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    osController.ListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(() => const Dashboard());
                },
                icon: const Icon(
                  LineAwesomeIcons.angle_left,
                  size: 24,
                )),
            backgroundColor: tCardBgColor,
            title: const Text("O/S Listing"),
            actions: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          showsrc = !showsrc;
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 28,
                      )),
                ],
              ),
            ],
          )),
      body: Container(
        height: MediaQuery.of(context).size.height - 5,
        width: double.infinity,
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            if (showsrc) _searchBar(),
            Obx(() {
              switch (osController.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (osController.error.value == 'No Internet') {
                    return InternetExceptionWidget(
                        onPress: () => osController.refreshListApi());
                  } else {
                    return GeneralExceptionWidget(
                        onPress: () => osController.refreshListApi());
                  }
                case Status.COMPLETED:
                  return _showList();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: TextFormField(
                  controller: osController.searchtxt,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    osController.applyfilters(value);
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Obx(
              () => Text(
                osController.lislen.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
                onPressed: () {
                  osController.searchtxt.text = "";
                  osController.refreshListApi();
                },
                icon: const Icon(
                  Icons.refresh,
                  size: 24,
                )),
            /*
            IconButton(
              icon: const Icon(
                Icons.picture_as_pdf_outlined,
                size: 24.0,
              ),
              onPressed: () {
                //_generateStockPdf(context);
              },
            )
            */
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20.0, right: 10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Bills'),
            Text('Days'),
            Text('Rcvd. Amt'),
            Text('Ledger Bal.'),
          ]),
        ),
      ],
    );
  }

  Widget _showList() {
    return Expanded(
        child: SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: LiquidPullRefresh(
        onRefresh: _handleRefresh,
        height: 200,
        color: tAccentColor.withOpacity(0.3),
        backgroundColor: tCardLightColor,
        animSpeedFactor: 1,
        showChildOpacityTransition: true,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: osController.reslist.length,
          itemBuilder: (context, index) {
            return _listItem(index);
          },
        ),
      ),
    ));
  }

  Widget _listItem(index) {
    return GestureDetector(
      onDoubleTap: () {
        prtController.setosacid(osController.reslist[index].acid!);
        prtController.prtOsApi();
        Get.to(() => const PartyOSScreen());
      },
      child: Card(
          elevation: 1.0,
          color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
          child: ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 9,
                    child: Text(
                      osController.reslist[index].acnm!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontSize: 18),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Text(
                      osController.reslist[index].posamt!.toStringAsFixed(2),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ]),
            trailing: null,
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Text(
                    osController.reslist[index].posbil!.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    osController.reslist[index].posday!.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    osController.reslist[index].rcvamt!.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    osController.reslist[index].lgrbal!.toStringAsFixed(2),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

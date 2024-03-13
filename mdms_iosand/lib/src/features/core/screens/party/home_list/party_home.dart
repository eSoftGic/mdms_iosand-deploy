// ignore_for_file: invalid_use_of_protected_member, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
import 'package:mdms_iosand/src/features/core/models/dashboard/categories_model.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import 'package:mdms_iosand/src/features/core/screens/party/newaccount/account.dart';
import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_filter.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/screen_party_details.dart';
import '../../../../../../singletons/AppData.dart';
import '../../../network/exceptions/general_exception_widget.dart';
import '../../../network/exceptions/internet_exception_widget.dart';
import '../../../network/status.dart';
import 'party_controller.dart';

class PartyHomeScreen extends StatefulWidget {
  const PartyHomeScreen({super.key});
  @override
  State<PartyHomeScreen> createState() => _PartyHomeScreenState();
}

class _PartyHomeScreenState extends State<PartyHomeScreen> {
  final partyController = Get.put(PartyController());
  final prtmenulist = DashboardCategoriesModel.prtmenulist.toList();
  bool showsrc = true;

  Future<void> _handleRefresh() async {
    partyController.applyfilters('');
    partyController.partyListApi();
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    partyController.partyListApi();
  }

  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    debugPrint(ht.toString());

    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(55.0), // here the desired height
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
                title: const Text(
                  "Party List",
                  textAlign: TextAlign.center,
                )
                /*actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        showsrc = !showsrc;
                      });
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 24,
                    )),
                //
              ],*/
                )),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 60,
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  _searchBar(),
                  const Divider(
                    height: 2,
                    color: tPrimaryColor,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Obx(() {
                            switch (partyController.RxRequestStatus.value) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.ERROR:
                                if (partyController.error.value ==
                                    'No Internet') {
                                  return InternetExceptionWidget(
                                      onPress: () => partyController
                                          .refreshpartyListApi());
                                } else {
                                  return GeneralExceptionWidget(
                                      onPress: () => partyController
                                          .refreshpartyListApi());
                                }
                              case Status.COMPLETED:
                                return _showList(context); //Text('Completed');
                            }
                          }),
                        ],
                      )),
                ],
              )),
        ));
  }

  Widget _showList(BuildContext context) {
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
          itemCount: partyController.prtlist.value.length,
          itemBuilder: (context, index) {
            return _listItem(index);
          },
        ),
      ),
    ));
  }

  Widget _listItem(index) {
    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        trailing: IconButton(
            onPressed: () {
              setState(() {
                appData.prtid = partyController.prtlist[index].ac_id!;
                appData.prtnm = partyController.prtlist[index].ac_nm!.trim();
              });
              if (partyController.prtlist[index].ac_id! > 0) {
                Get.to(() => PartyDetails(
                      acid: partyController.prtlist[index].ac_id!,
                      acnm: partyController.prtlist[index].ac_nm!,
                    ));
              }
            },
            icon: const Icon(
              LineAwesomeIcons.angle_double_right,
              size: 28,
              color: tAccentColor,
            )),
        title: Text(
          partyController.prtlist[index].ac_nm.toString(),
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20),
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Flexible(
                flex: 5,
                child: PartyImageWidget(),
              ),
              Flexible(
                flex: 7,
                child: Text(
                    '${partyController.prtlist[index].mobile}\n${partyController.prtlist[index].beatnm.toString().trim()}\n${partyController.prtlist[index].sale_type.toString()}',
                    //overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontSize: 14)),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 12,
                  child: Text(partyController.prtlist[index].addr.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 14)),
                )
              ]),
        ]),
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 35.0,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: TextFormField(
              controller: partyController.searchtxt,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineSmall,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                partyController
                    .applyfilters(value.toLowerCase().toString().trim());
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            partyController.prtlen.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: () {
              Get.to(() => const AccountMst());
            },
            icon: const Icon(
              LineAwesomeIcons.plus,
              size: 24,
            )),
        IconButton(
            onPressed: () {
              partyController.searchtxt.text = "";
              partyController.refreshpartyListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),
        /*Center(child: _filter()),*/
      ],
    );
  }

  Widget _filter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 30.0,
        width: 30.0,
        child: GestureDetector(
          onTap: () {
            Get.to(() => const PartyFilter());
          },
          child: Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    color: tPrimaryColor,
                    size: 24,
                  ),
                  onPressed: () {}),
              Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1,
                        size: 20.0, color: Colors.deepOrangeAccent.shade100),
                    Positioned(
                      top: 2.0,
                      right: 5.5,
                      child: Center(
                        child: Text(
                          (appData.filtbeat.length +
                                  appData.filttype.length +
                                  appData.filtclass.length)
                              .toString(),
                          style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PartyImageWidget extends StatelessWidget {
  const PartyImageWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: tCardBgColor.withOpacity(0.5),
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Image(
          image: AssetImage(tNoImage),
        ),
      ),
    );
  }
}

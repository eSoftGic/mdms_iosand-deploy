// ignore_for_file: invalid_use_of_protected_member, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/constants/constants.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';
import 'package:mdms_iosand/src/features/core/screens/party/newaccount/account.dart';
import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_filter.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/history/screen_history.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/controller_ledger.dart';
import '../../../../../../singletons/AppData.dart';
import '../../../network/exceptions/general_exception_widget.dart';
import '../../../network/exceptions/internet_exception_widget.dart';
import '../../../network/status.dart';
import '../../allocation/controller_allocation.dart';
import '../../allocation/screen_allocation.dart';
import '../../order/controller_order.dart';
import '../../order/screen_orderhome.dart';
import '../option/details/screen_party_details.dart';
import '../option/history/controller_history.dart';
import '../option/ledger/screen_party_ledger.dart';
import '../option/os/controller_os.dart';
import '../option/os/screen_os.dart';
import '../option/rcp/controller_rcp.dart';
import '../option/rcp/screen_rcp.dart';
import '../option/uncrn/controller_uncrn.dart';
import '../option/uncrn/screen_uncrn.dart';
import 'party_controller.dart';
import 'package:intl/intl.dart';

class PartyHomeScreen extends StatefulWidget {
  const PartyHomeScreen({super.key});
  @override
  State<PartyHomeScreen> createState() => _PartyHomeScreenState();
}

class _PartyHomeScreenState extends State<PartyHomeScreen> {
  final partyController = Get.put(PartyController());
  final ordController = Get.put(OrderController());
  final grlController = Get.put(PartyLedgerController());
  final osController = Get.put(PartyOsController());
  final rcpController = Get.put(PartyRcpController());
  final ucrnController = Get.put(PartyUnCrnController());
  final hisController = Get.put(OrderHistoryController());
  final aController = Get.put(AllocationController());

  bool showsrc = false;

  @override
  void initState() {
    super.initState();
    partyController.partyListApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0), // here the desired height
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.to(() => const Dashboard());
                },
                icon: const Icon(
                  LineAwesomeIcons.angle_left,
                  size: 24,
                )),
            title: Text("Party List",
                style: Theme.of(context).textTheme.headlineMedium),
            actions: [
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
              switch (partyController.RxRequestStatus.value) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  if (partyController.error.value == 'No Internet') {
                    return InternetExceptionWidget(
                        onPress: () => partyController.refreshpartyListApi());
                  } else {
                    return GeneralExceptionWidget(
                        onPress: () => partyController.refreshpartyListApi());
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

  Widget _showList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: partyController.prtlist.value.length,
        itemBuilder: (context, index) {
          return _listItem(index);
        },
      ),
    );
  }

  Widget _listItem(index) {
    return Card(
      color: Get.isDarkMode ? tCardBgColor.withOpacity(0.9) : tCardLightColor,
      elevation: 1,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 10,
                    child: Text(
                      partyController.prtlist[index].ac_nm!,
                      style: Theme.of(context).textTheme.headlineMedium,
                      softWrap: true,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: partypopupMenuButton(
                      partyController.prtlist[index].ac_id!,
                      partyController.prtlist[index].ac_nm!,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ExpansionTile(
                leading: const PartyImageWidget(),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 6,
                      child: Text(
                        partyController.prtlist[index].mobile.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Text(
                        partyController.prtlist[index].beatnm.toString(),
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: tDarkColor),
                      ),
                    ),
                  ],
                ),
                initiallyExpanded: false,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "${partyController.prtlist[index].classnm!}/${partyController.prtlist[index].typenm!}",
                              ),
                            ),
                            Text(
                              partyController.prtlist[index].sale_type
                                  .toString(),
                            ),
                            Text(
                              partyController.prtlist[index].routeSr ??
                                  '-'.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                partyController.prtlist[index].addr.toString(),
                                softWrap: true,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
    );
  }

  PopupMenuButton<String> partypopupMenuButton(int acid, String acnm) {
    return PopupMenuButton(
        icon: const Icon(
          Icons.more_vert,
          color: tPrimaryColor,
          size: 30,
        ), // add this line
        itemBuilder: (_) => <PopupMenuItem<String>>[
              const PopupMenuItem<String>(
                  value: 'detail',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Details",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'order',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Orders",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'ledger',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Ledger",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'os',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Outstanding",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'rcp',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Receipts",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'uncrn',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "UnAdjsuted CRN",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'history',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Order History",
                        style: TextStyle(color: tAccentColor),
                      ))),
              const PopupMenuItem<String>(
                  value: 'allocate',
                  child: SizedBox(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Stock Allocation",
                        style: TextStyle(color: tAccentColor),
                      ))),
              /*PopupMenuItem<String>(
                  child: Container(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Edit Party",
                        style: TextStyle(color: tAccentColor),
                      )),
                  value: 'edit'),*/
              /*PopupMenuItem<String>(
                  child: Container(
                      width: 100,
                      // height: 30,
                      child: Text(
                        "Target",
                        style: TextStyle(color: tAccentColor),
                      )),
                  value: 'target'),*/
            ],
        onSelected: (index) async {
          gotoselected(index, acid, acnm);
        });
  }

  void gotoselected(String opt, int acid, String acnm) async {
    setState(() {
      appData.prtid = acid;
      appData.prtnm = acnm;
    });

    if (opt == 'detail') {
      Get.to(() => PartyDetails(acid: acid));
    }
    if (opt == 'order') {
      ordController.setPartyOrderList(acid);
      Get.to(() => const OrderHomeScreen());
    }
    if (opt == 'ledger') {
      final dfmdy = DateFormat('MM/dd/yyyy');
      DateTime tdate = DateTime.now();
      DateTime fdate = DateTime.now().subtract(const Duration(days: 30));
      grlController.setcleargrl();
      grlController.setgrlacid(acid);
      grlController.setfdt(dfmdy.format(fdate));
      grlController.settdt(dfmdy.format(tdate));
      grlController.setsordad(true);
      grlController.prtGrlApi();
      Get.to(() => const PartyLedger());
    }
    if (opt == 'os') {
      osController.setclearos();
      osController.setosacid(acid);
      osController.prtOsApi();
      Get.to(() => const PartyOSScreen());
    }
    if (opt == 'rcp') {
      rcpController.setclearrcp();
      rcpController.setrcpacid(acid);
      rcpController.prtRcpApi();
      if (rcpController.rcplen.value > 0) {
        Get.to(() => const PartyRcpScreen());
      } else {
        Get.snackbar('Receipts', 'No Record');
      }
    }
    if (opt == 'uncrn') {
      ucrnController.setclearos();
      ucrnController.setosacid(acid);
      ucrnController.prtUnCrnApi();
      if (ucrnController.oslen.value > 0) {
        Get.to(() => const PartyUnCrnScreen());
      } else {
        Get.snackbar('UnAdjusted Credit Note', 'No Record');
      }
    }
    if (opt == 'history') {
      final dfmdy = DateFormat('MM/dd/yyyy');
      DateTime fdate = DateTime.now().subtract(const Duration(days: 15));
      hisController.setclearhis();
      hisController.sethisacid(acid);
      hisController.setfdt(dfmdy.format(fdate));
      hisController.setTop10(10);
      hisController.prtOrdHisApi();
      Get.to(() => const OrdHistoryScreen());
    }
    if (opt == 'allocate') {
      aController.onChangeGroup('Partywise');
      aController.setItmIdstr('');
      aController.setprtIdstr(acid.toString().trim());
      Get.to(() => const AllocateScreen());
    }
  }

  Widget _searchBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            height: 50.0,
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
      margin: const EdgeInsets.only(right: 20, top: 7),
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

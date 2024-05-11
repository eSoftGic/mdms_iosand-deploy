// ignore_for_file: invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/models/dashboard/categories_model.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
import 'package:mdms_iosand/src/features/core/orderdb/orderhome.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/controller_allocation.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/screen_allocation.dart';

import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_home.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/controller_option.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/details/screen_party_route.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/history/controller_history.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/history/screen_history.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/controller_ledger.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/screen_party_ledger.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/controller_os.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/screen_os.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/rcp/controller_rcp.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/rcp/screen_rcp.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/uncrn/controller_uncrn.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/uncrn/screen_uncrn.dart';

import '../../../../../../../singletons/AppData.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';

class PartyDetails extends StatelessWidget {
  final int acid;
  final String acnm;
  const PartyDetails({super.key, required this.acid, required this.acnm});

  @override
  Widget build(BuildContext context) {
    final optionController = Get.put(PartyOptionController());
    optionController.acmstdetailApi(acid);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0), // here the desired height
          child: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.to(() => const PartyHomeScreen());
                  },
                  icon: const Icon(
                    LineAwesomeIcons.angle_left,
                    size: 24,
                  )),
              backgroundColor: tCardBgColor,
              title: const Text(
                "Party Details",
                textAlign: TextAlign.center,
              ))),
      body: Obx(() {
        switch (optionController.RxRequestStatus.value) {
          case Status.LOADING:
            return const Center(child: CircularProgressIndicator());
          case Status.ERROR:
            if (optionController.error.value == 'No Internet') {
              return InternetExceptionWidget(
                  onPress: () => optionController.acmstdetailApi(acid));
            } else {
              return GeneralExceptionWidget(
                  onPress: () => optionController.acmstdetailApi(acid));
            }
          case Status.COMPLETED:
            return _showpartydetail(context, optionController);
        }
      }),
    );
  }

  Widget buildprtopt(BuildContext context, int acid, String acnm) {
    final prtmenulist = DashboardCategoriesModel.prtmenulist.toList();

    final ordController = Get.put(OrderController());
    final grlController = Get.put(PartyLedgerController());
    final osController = Get.put(PartyOsController());
    final rcpController = Get.put(PartyRcpController());
    final ucrnController = Get.put(PartyUnCrnController());
    final hisController = Get.put(OrderHistoryController());
    final aController = Get.put(AllocationController());

    return SizedBox(
      height: 80,
      width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
          scrollDirection: Axis.horizontal,
          itemCount: prtmenulist.length,
          itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                switch (prtmenulist[index].menuname) {
                  //case 'PDET':
                  //  gotoselected('detail', acid, acnm);
                  //  break;
                  case 'PORD':
                    ordController.setOrdforacid(acid);
                    ordController.setPartyOrderList(acid);
                    Get.to(() => const OrderHomeView());
                    //gotoselected('order', acid, acnm);
                    break;
                  case 'PHIS':
                    final dfmdy = DateFormat('MM/dd/yyyy');
                    DateTime fdate =
                        DateTime.now().subtract(const Duration(days: 15));
                    hisController.setclearhis();
                    hisController.sethisacid(acid);
                    hisController.setfdt(dfmdy.format(fdate));
                    hisController.setTop10(10);
                    hisController.prtOrdHisApi();
                    Get.to(() => const OrdHistoryScreen());
                    //gotoselected('history', acid, acnm);
                    break;
                  case 'POS':
                    osController.setosacid(acid);
                    osController.prtOsApi();
                    Get.to(() => const PartyOSScreen());
                    //gotoselected('os', acid, acnm);
                    break;
                  case 'PGRL':
                    final dfmdy = DateFormat('MM/dd/yyyy');
                    DateTime tdate = DateTime.now();
                    DateTime fdate =
                        DateTime.now().subtract(const Duration(days: 30));
                    grlController.setcleargrl();
                    grlController.setgrlacid(acid);
                    grlController.setfdt(dfmdy.format(fdate));
                    grlController.settdt(dfmdy.format(tdate));
                    grlController.setsordad(true);
                    grlController.prtGrlApi();
                    Get.to(() => const PartyLedger());
                    //gotoselected('ledger', acid, acnm);
                    break;
                  case 'PALO':
                    aController.onChangeGroup('Partywise');
                    aController.setItmIdstr('');
                    aController.setprtIdstr(acid.toString().trim());
                    Get.to(() => const AllocateScreen());
                    //gotoselected('allocate', acid, acnm);
                    break;
                  case 'PRCP':
                    rcpController.setclearrcp();
                    rcpController.setrcpacid(acid);
                    rcpController.prtRcpApi();
                    if (rcpController.rcplen.value > 0) {
                      Get.to(() => const PartyRcpScreen());
                    } else {
                      Get.snackbar('Receipts', 'No Record');
                    }
                    //gotoselected('rcp', acid, acnm);
                    break;
                  case 'PUNCRN':
                    ucrnController.setclearos();
                    ucrnController.setosacid(acid);
                    ucrnController.prtUnCrnApi();
                    if (ucrnController.oslen.value > 0) {
                      Get.to(() => const PartyUnCrnScreen());
                    } else {
                      Get.snackbar('UnAdjusted Credit Note', 'No Record');
                    }
                    //gotoselected('uncrn', acid, acnm);
                    break;
                }
              },
              child: Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: SizedBox(
                      height: 70,
                      width: 75,
                      child: Card(
                        elevation: 2,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                        width: 1, color: tAccentColor),
                                    color: Get.isDarkMode
                                        ? tCardLightColor.withOpacity(0.5)
                                        : tCardBgColor.withOpacity(0.5),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      prtmenulist[index].icon,
                                      size: 20.0,
                                      color: Color(prtmenulist[index].color),
                                    ),
                                  ),
                                ),
                              ),
                              Text(prtmenulist[index].heading,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ]),
                      ))))),
    );
  }

  Widget _showpartydetail(
      BuildContext context, PartyOptionController controller) {
    var acmst = controller.prtrecord.value[0];
    String opncaption = acmst.open_bal! < 0 ? " Debit " : " Credit ";
    String clscaption = acmst.clos_bal! < 0 ? " Debit " : " Credit ";
    return ListView(children: [
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Divider(
                height: 2,
              ),
              buildprtopt(context, acid, acnm),
              const Divider(
                height: 2,
              ),
              Card(
                  elevation: 2.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          acmst.ac_nm ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                  fontSize: 20,
                                  color: tPrimaryColor,
                                  fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(acmst.add_1 ?? ''.toString(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(acmst.add_2 ?? ''.toString(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(acmst.add_3 ?? ''.toString(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(acmst.add_4 ?? ''.toString(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(acmst.city ?? ''.toString(),
                                      softWrap: true,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  Text(acmst.pin ?? ''.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              )
                            ],
                          ),
                        ),
                      ])),
              Card(
                  elevation: 2.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Other Details',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Mobile ',
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    acmst.mobile.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Phone '),
                                  Text(
                                    acmst.phone_no.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Email'),
                                  Text(
                                    acmst.email_id.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    softWrap: true,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Bank / Branch '),
                                  Text(
                                    '${acmst.bank_ac_nm} / ${acmst.bank_branch}',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Beat '),
                                  Text(
                                    acmst.beatnm.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('GST '),
                                  Text(
                                    acmst.gstin.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('PAN '),
                                  Text(
                                    acmst.pan_no.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])),
              Card(
                  elevation: 2.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'A/C Status',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                                fontSize: 18,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Opening Balance Rs.',
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${acmst.open_bal!.abs().toDouble().toStringAsFixed(2)} $opncaption',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Closing Balance Rs. '),
                                  Text(
                                    '${acmst.clos_bal!.abs().toDouble().toStringAsFixed(2)} $clscaption',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Outstanding Amount'),
                                  Text(
                                    acmst.osamt!.toStringAsFixed(2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Outstanding Bill Nos.'),
                                  Text(
                                    acmst.osbill!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Outstanding Days '),
                                  Text(
                                    acmst.osdays!.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])),
              Card(
                  elevation: 2.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Location ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 18,
                                  ),
                            ),
                            IconButton(
                                icon: const Icon(Icons.my_location,
                                    size: 20, color: tAccentColor),
                                onPressed: controller.getloc),
                            IconButton(
                                icon: const Icon(
                                  Icons.alt_route,
                                  size: 20,
                                  color: tAccentColor,
                                ),
                                onPressed: () {
                                  print('going to party route page');
                                  if (appData.livlat != '0.0' &&
                                      appData.livlon != '0.0') {
                                    Get.to(() => const PartyRoute());
                                  }
                                })
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Latitude ',
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    acmst.latitude.toString() == '0.0'
                                        ? controller.ordlat.value.toString()
                                        : acmst.latitude.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Longitude'),
                                  Text(
                                    acmst.longitude.toString() == '0.0'
                                        ? controller.ordlon.value.toString()
                                        : acmst.longitude.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    textAlign: TextAlign.end,
                                  )
                                ],
                              ),
                              /*
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    icon: new Icon(
                                      Icons.save,
                                      color: Colors.blueAccent,
                                    ),
                                    onPressed: () {}), //_updloc)
                              ],
                            ),
                            */
                            ],
                          ),
                        ),
                      ])),
            ],
          )),
    ]);
  }
}

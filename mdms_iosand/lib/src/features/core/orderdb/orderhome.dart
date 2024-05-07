// ignore_for_file: invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:mdms_iosand/singletons/AppData.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/general_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/exceptions/internet_exception_widget.dart';
import 'package:mdms_iosand/src/features/core/network/status.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
//import 'package:mdms_iosand/src/features/core/neworder/screen/orderedit.dart';
import 'package:mdms_iosand/src/features/core/neworder/screen/ordernavigation.dart';
//import 'package:mdms_iosand/src/features/core/orderdb/orderdetail.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/dashboard.dart';

class OrderHomeView extends StatefulWidget {
  const OrderHomeView({super.key});

  @override
  State<OrderHomeView> createState() => _OrderHomeViewState();
}

class _OrderHomeViewState extends State<OrderHomeView> {
  final ordcontroller = Get.put(OrderController());
  String ordrs = "";
  var _colorapproved = Colors.blue;
  final Dio dio = Dio();
  String progress = "0";

  Future<void> _handleRefresh() async {
    ordcontroller.setPartyOrderList(ordcontroller.ordforacid);
    return await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    super.initState();
    ordcontroller.setPartyOrderList(ordcontroller.ordforacid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(55.0), // here the desired height
            child: AppBar(
              automaticallyImplyLeading: false,
              title: const Text("ORDER"),
              backgroundColor: tPrimaryColor.withOpacity(0.3),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        appData.ordqottype = "ORD";
                        appData.prtid = 0;
                        appData.prtnm = '';
                        appData.ordrefno = 0;
                        appData.ordmaxlimit = 0.0;
                        appData.ordlimitvalid = true;
                      });
                      ordcontroller.setOrdrefno(0);
                      //Get.to(() => const AddOrderHomeScreen());
                      Get.to(() => const OrderNavigationScreen());
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 24,
                    )),
                IconButton(
                    onPressed: () {
                      Get.to(const Dashboard());
                    },
                    icon: const Icon(
                      Icons.home,
                      size: 24,
                    )),
              ],
            )),
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: () {
                            gotoselected('all');
                          },
                          child: Text(
                            'ALL',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('apprvpend');
                          },
                          child: Text(
                            'PENDING',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('billpend');
                          },
                          child: Text(
                            'APPROVED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('billed');
                          },
                          child: Text(
                            'BILLED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      TextButton(
                          onPressed: () {
                            gotoselected('apprvreject');
                          },
                          child: Text(
                            'REJECTED',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                      /*TextButton(
                          onPressed: () {
                            gotoselected('noorder');
                          },
                          child: Text(
                            'NO-ORDER',
                            style: Theme.of(context).textTheme.labelSmall,
                          )),
                          */
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _searchBar(),
                  ),
                  const Divider(
                    height: 5,
                    color: tPrimaryColor,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: double.infinity,
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Obx(() {
                            switch (ordcontroller.RxRequestStatus.value) {
                              case Status.LOADING:
                                return const Center(
                                    child: CircularProgressIndicator());
                              case Status.ERROR:
                                if (ordcontroller.error.value ==
                                    'No Internet') {
                                  return InternetExceptionWidget(
                                      onPress: () =>
                                          ordcontroller.refreshListApi());
                                } else {
                                  return GeneralExceptionWidget(
                                      onPress: () =>
                                          ordcontroller.refreshListApi());
                                }
                              case Status.COMPLETED:
                                return _showList(context);
                            }
                          }),
                        ],
                      )),
                ],
              )),
        ));
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
              controller: ordcontroller.searchtxt,
              textAlign: TextAlign.start,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                ordcontroller.applyfilters(value);
              },
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Obx(
          () => Text(
            ordcontroller.lislen.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
            onPressed: () {
              ordcontroller.searchtxt.text = "";
              ordcontroller.refreshListApi();
            },
            icon: const Icon(
              Icons.refresh,
              size: 24,
            )),
      ],
    );
  }

  Widget _showList(BuildContext context) {
    return LiquidPullRefresh(
      onRefresh: _handleRefresh,
      color: tAccentColor.withOpacity(0.3),
      height: 250,
      backgroundColor: tCardLightColor,
      animSpeedFactor: 2,
      showChildOpacityTransition: true,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: ordcontroller.reslist.value.length,
        itemBuilder: (context, index) {
          return _listItem(index);
        },
      ),
    );
  }

  Widget _listItem(index) {
    String ordstatus = '';
    if (ordcontroller.reslist[index].billed == 'Y') {
      ordstatus = 'Billed';
      _colorapproved = Colors.green;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('REJECTED')) {
      ordstatus = 'Rejected';
      _colorapproved = Colors.purple;
    }
    if (ordcontroller.reslist[index].approvalstatus!
        .toUpperCase()
        .contains('PENDING')) {
      ordstatus = 'Approval Pending';
      _colorapproved = Colors.red;
    }

    return Card(
      color: Get.isDarkMode ? tCardDarkColor : tCardLightColor,
      child: ListTile(
        trailing: IconButton(
            onPressed: () {
              setState(() {
                appData.prtid =
                    int.parse(ordcontroller.reslist[index].ac_id.toString());
                appData.prtnm = ordcontroller.reslist[index].ac_nm!.trim();
                appData.ordrefno = ordcontroller.reslist[index].ref_no;
                appData.bukid = ordcontroller.reslist[index].tran_type_id ?? 0;
                appData.bukcmpstr =
                    ordcontroller.reslist[index].company_sel ?? "";
                appData.buknm = ordcontroller.reslist[index].tran_desc;
                appData.billdetails = ordcontroller.reslist[index].billdetails;
                appData.chainid = ordcontroller.reslist[index].chainid ?? 0;
                appData.chainnm =
                    ordcontroller.reslist[index].chainareanm ?? "";
                appData.ordmaxlimit = 0.0;
                appData.ordlimitvalid = true;
                appData.saletype = ordcontroller.reslist[index].saletype;
                appData.ordbilled = ordcontroller.reslist[index].billed;
                appData.approvalstatus =
                    ordcontroller.reslist[index].approvalstatus ?? '';
                appData.ordqottype = 'ORD';
              });
              if (ordcontroller.reslist[index].ref_no! > 0) {
                ordcontroller.setOrdrefno(ordcontroller.reslist[index].ref_no!);
                Get.to(() => OrderNavigationScreen());
              }
            },
            icon: Icon(
              LineAwesomeIcons.angle_double_right,
              size: 28,
              color: tAccentColor,
            )),
        title: Text(
          ordcontroller.reslist[index].ac_nm.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Text(
                  ordcontroller.reslist[index].tran_dt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Flexible(
                flex: 6,
                child: Text(
                    ordcontroller.reslist[index].ref_no.toString() +
                        '-' +
                        ordcontroller.reslist[index].tran_desc
                            .toString()
                            .trim(),
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
              Flexible(
                flex: 3,
                child: Text(
                  ordcontroller.reslist[index].net_amt.toString(),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Status ', style: Theme.of(context).textTheme.bodyMedium),
                Flexible(
                  flex: 6,
                  child: Text(ordstatus.toString(),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: _colorapproved)),
                )
              ]),
        ]),
      ),
    );
  }

  void gotoselected(String opt) async {
    ordcontroller.setOrdBillList(opt);
  }
}

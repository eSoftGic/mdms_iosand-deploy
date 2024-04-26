// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/rcp/controller_rcp.dart';
import '../../../../../../constants/colors.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';
import 'dart:core';
import '../../../../../../../singletons/singletons.dart';
import 'package:date_format/date_format.dart';

class PartyRcpScreen extends StatelessWidget {
  const PartyRcpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PartyRcpController rController = Get.put(PartyRcpController());

    Widget showrcp(BuildContext context, PartyRcpController controller) {
      return controller.rcplen.value != null ? buildColumn(controller, context) : const Text('....');
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: ('${appData.prtnm!} Receipt'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(() {
                  switch (rController.RxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      if (rController.error.value == 'No Internet') {
                        return InternetExceptionWidget(onPress: () => rController.prtRcpApi());
                      } else {
                        return GeneralExceptionWidget(onPress: () => rController.prtRcpApi());
                      }
                    case Status.COMPLETED:
                      return showrcp(context, rController);
                  }
                }),
              ],
            ),
          ),
        ));
  }

  Column buildColumn(PartyRcpController rController, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
            color: Colors.blueGrey.shade50,
            child: const Padding(
                padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0, bottom: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                      Text(
                        'Rcp. Date',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'No',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'Chq. Date',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'Amount',
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ]),
                  ],
                ))),
        const Divider(
          color: tPrimaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: rController.rcplen.value,
            itemBuilder: (context, index) {
              return ListTile(
                  contentPadding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  title: SizedBox(
                    width: 250,
                    height: 80.0,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        color: Colors.grey.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  formatDate(DateTime.parse(rController.rcplist[index].vchrdt!),
                                      [dd, '/', mm, '/', yyyy]),
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  rController.rcplist[index].vchrno.toString(),
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  formatDate(DateTime.parse(rController.rcplist[index].chqdt!),
                                      [dd, '/', mm, '/', yyyy]),
                                  style: const TextStyle(fontSize: 14, color: Colors.black),
                                ),
                                Text(
                                  rController.rcplist[index].rcvdamt.toString(),
                                  style: TextStyle(fontSize: 14, color: Colors.blue.shade600),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    rController.rcplist[index].cqmode == "CHEQUE"
                                        ? 'CHEQUE-${rController.rcplist[index].chqno!}'
                                        : 'CASH',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green.shade600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    appData.prtid = int.parse(rController.rcplist[index].acid.toString());
                    appData.prtnm = rController.rcplist[index].acnm;
                    appData.prtrcpno = rController.rcplist[index].vchrno ?? 0;
                    appData.prtrcpref = rController.rcplist[index].refno ?? 0;
                    appData.prtbnknm = rController.rcplist[index].acbank ?? "";
                    appData.prtbrnnm = rController.rcplist[index].acbranch ?? "";
                    appData.prtbnkid = rController.rcplist[index].acbankid ?? 0;
                    appData.prtbrnid = rController.rcplist[index].acbranchid ?? 0;
                    appData.prtrcpchqdt = rController.rcplist[index].chqdt ?? "";
                    appData.prtrcpamt = rController.rcplist[index].rcvdamt ?? 0.0;
                    appData.prtrcpchqno = rController.rcplist[index].chqno ?? "";
                    appData.prtrcpmode = "CRR";
                    if (appData.prtbnkid! > 0 || appData.prtbrnid! > 0) {
                      appData.prtrcpmode = "CHQ";
                    }
                    /*Navigator.push(context,MaterialPageRoute(builder: (context) => ReceiptDetail()));*/
                  });
            }),
      ],
    );
  }
}
// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/uncrn/controller_uncrn.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../ecommerce/widget/custom_appbar.dart';
import '../../../../network/exceptions/general_exception_widget.dart';
import '../../../../network/exceptions/internet_exception_widget.dart';
import '../../../../network/status.dart';
import 'dart:core';
import '../../../../../../../singletons/singletons.dart';

class PartyUnCrnScreen extends StatelessWidget {
  const PartyUnCrnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PartyUnCrnController ucrnController = Get.put(PartyUnCrnController());

    Widget showcrn(BuildContext context, PartyUnCrnController controller) {
      return controller.oslen.value != null ? buildColumn(controller, context) : const Text('....');
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: ('${appData.prtnm!} UnAdjusted Credit Note'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Obx(() {
                  switch (ucrnController.RxRequestStatus.value) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      if (ucrnController.error.value == 'No Internet') {
                        return InternetExceptionWidget(onPress: () => ucrnController.prtUnCrnApi());
                      } else {
                        return GeneralExceptionWidget(onPress: () => ucrnController.prtUnCrnApi());
                      }
                    case Status.COMPLETED:
                      return showcrn(context, ucrnController);
                  }
                }),
              ],
            ),
          ),
        ));
  }

  Column buildColumn(PartyUnCrnController osController, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Text(
            'Date  ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Vchr.No ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Amount ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Adjusted Amt',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ]),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
          Text(
            'Type    ',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          Text(
            'Pend.Amt',
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 0),
                child: Text(
                  'Unadjusted Credit Rs. ${osController.ostot.value}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade900,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
              ),
            ]),
        const Divider(
          color: tPrimaryColor,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: osController.oslen.value,
            itemBuilder: (context, index) {
              String pamt = "";
              pamt = (osController.oslist[index].netamt! - osController.oslist[index].rcvdamt!)
                  .toStringAsFixed(2);
              return ListTile(
                  title: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                osController.oslist[index].trandt!.toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue.shade600),
                              ),
                            ),
                            Text(
                              osController.oslist[index].tranno!.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade600),
                            ),
                            Text(
                              osController.oslist[index].netamt!.toDouble().toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade600),
                            ),
                            Text(
                              osController.oslist[index].rcvdamt.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade600),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              osController.oslist[index].trandesc!.toString(),
                              style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
                            ),
                            Text(
                              osController.oslist[index].penamt == 0
                                  ? (osController.oslist[index].netamt! -
                                          osController.oslist[index].rcvdamt!)
                                      .toString()
                                  : osController.oslist[index - 1].penamt.toString(),
                              style: TextStyle(fontSize: 14, color: Colors.red.shade900),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Wrap(
                                alignment: WrapAlignment.spaceAround,
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    osController.oslist[index].descrem.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.blueGrey.shade600),
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {});
            }),
      ],
    );
  }
}
// ignore_for_file: non_constant_identifier_names

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/history/controller_history.dart';
import '../../../../../../../singletons/singletons.dart';
import '../../../../../../constants/constants.dart';
import 'package:intl/intl.dart';

import '../../../../../../ecommerce/widget/custom_appbar.dart';

class OrdHistoryScreen extends StatelessWidget {
  const OrdHistoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    OrderHistoryController hisController = Get.put(OrderHistoryController());

    final df = DateFormat('dd/MM/yyyy');
    final dfmdy = DateFormat('MM/dd/yyyy');
    DateTime fromdate = DateTime.parse('2023-04-01');
    DateTime inidate = DateTime.now().subtract(const Duration(days: 30));
    DateTime fstdt = DateTime.parse('2023-04-01');
    DateTime enddt = DateTime.now();
    final FocusNode myFocusfDt = FocusNode();
    TextEditingController fdtController = TextEditingController();
    fdtController.text = df.format(fromdate);
    hisController.setfdt(dfmdy.format(fromdate));
    hisController.setTop10(10);
    // Date Selection
    Future<Null> selectFDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: inidate,
          firstDate: DateTime(fstdt.year, fstdt.month, fstdt.day),
          lastDate: DateTime(enddt.year, enddt.month, enddt.day));
      if (picked != null && picked != fromdate) {
        fromdate = picked;
        hisController.setfdt(dfmdy.format(fromdate));
        fdtController.text = df.format(fromdate);
      }
    }

    // Date Selection
    showhis() async {
      hisController.setfdt(dfmdy.format(fromdate));
      hisController.prtOrdHisApi();
    }

    ShowButton() {
      return IconButton(
        icon: const Icon(Icons.remove_red_eye_outlined),
        color: tAccentColor,
        iconSize: 30.0,
        disabledColor: Colors.grey,
        highlightColor: tPrimaryColor,
        onPressed: () {
          showhis();
        },
      );
    }

    Card buildheader(BuildContext context) {
      return Card(
          color: Colors.blueGrey.shade50,
          child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <Widget>[
                      SizedBox(
                          width: 90.0,
                          child: InkWell(
                            onTap: () {
                              selectFDate(context);
                            },
                            child: IgnorePointer(
                              child: TextField(
                                focusNode: myFocusfDt,
                                controller: fdtController,
                                style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(1.0),
                                  border: InputBorder.none,
                                  labelText: "FROM DATE",
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Last 10 Orders',
                              style: TextStyle(fontSize: 16, color: Colors.blue),
                            ),
                            Obx(() {
                              return Switch(
                                  value: hisController.top10.value == 10 ? true : false,
                                  onChanged: (val) {
                                    hisController.setTop10(0);
                                    if (val == true) {
                                      hisController.setTop10(10);
                                    }
                                  },
                                  activeColor: tAccentColor);
                            }),
                            ShowButton(),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              )));
    }

    Widget showhistory(BuildContext context, OrderHistoryController controller) {
      return controller.hislen.value > 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Text('Date / No ', style: Theme.of(context).textTheme.bodyMedium),
                    Text('Status', style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Text('Product Name', style: Theme.of(context).textTheme.bodyMedium),
                    Text('Quantity ', style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                    Text('Rate', style: Theme.of(context).textTheme.bodyMedium),
                    Text('GST %', style: Theme.of(context).textTheme.bodyMedium),
                    Text('GST Rs ', style: Theme.of(context).textTheme.bodyMedium),
                    Text('Net Amt Rs', style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                ),
                const Divider(
                  color: tPrimaryColor,
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.hislen.value,
                    itemBuilder: (context, index) {
                      String odt = '';
                      String ostatus = '';
                      if (index > 0) {
                        odt =
                            df.format(DateTime.parse(controller.hislist[index].ord_dt!.toString()));
                        ostatus = controller.hislist[index].no_order == true
                            ? 'NO ORDER'
                            : controller.hislist[index].ord_approval_status!.toString();
                      }
                      return ListTile(
                          title: Card(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                                      Widget>[
                                    Text('$odt - ${controller.hislist[index].ref_no!}',
                                        style: Theme.of(context).textTheme.bodyLarge),
                                    Text(ostatus, style: Theme.of(context).textTheme.bodyLarge),
                                  ]),
                                  (ostatus != 'NO ORDER')
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                              Expanded(
                                                child: Text(
                                                  controller.hislist[index].item_nm!.toString(),
                                                  style: Theme.of(context).textTheme.bodyMedium,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                controller.hislist[index].qty!.toStringAsFixed(2),
                                                style: Theme.of(context).textTheme.bodyMedium,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            ])
                                      : const SizedBox(),
                                  (ostatus != 'NO ORDER')
                                      ? Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                              Text(controller.hislist[index].rate!
                                                  .toStringAsFixed(2)),
                                              Text(controller.hislist[index].gst_page!
                                                  .toStringAsFixed(1)),
                                              Text(controller.hislist[index].gst_amt!
                                                  .toStringAsFixed(1)),
                                              Text(controller.hislist[index].item_net!
                                                  .toStringAsFixed(2)),
                                            ])
                                      : const SizedBox(),
                                ]),
                          ),
                          onTap: () {});
                    }),
              ],
            )
          : const Text('....');
    }

    return Scaffold(
        appBar: CustomAppBar(
          title: ('${appData.prtnm!} Order History'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildheader(context),
                Obx(() {
                  return showhistory(context, hisController);
                }),
                //OrderSummary(),
              ],
            ),
          ),
        ));
  }
}
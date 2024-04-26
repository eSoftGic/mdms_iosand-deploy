// ignore_for_file: depend_on_referenced_packages, invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/custom_appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/approval/controller_approvalhome.dart';
import '../../../../constants/constants.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class ApprovalScreen extends StatelessWidget {
  const ApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApprovalController aprController = Get.put(ApprovalController());

    Color getColor(String stat) {
      if (stat.contains('Pending')) return Colors.orange;
      if (stat.contains('Approved')) return Colors.green;
      if (stat.contains('Rejected')) return Colors.red;
      return Get.isDarkMode ? tWhiteColor : tPrimaryColor;
    }

    String getdmy(String dt) {
      if (dt == 'NA') {
        return 'NA';
      }
      final datm = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dt);
      String dat = '${datm.day}/${datm.month}/${datm.year}';
      String tim = '${datm.hour}:${datm.minute}:${datm.second}';
      if (tim == '0:0:0') {
        return dat;
      } else {
        return '$dat $tim';
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: ('Approvals'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          stockOptionWidget(aprController: aprController),
          SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 250,
                child: Obx(
                  () => GroupedListView<dynamic, String>(
                    elements: aprController.groupedData.value,
                    groupBy: (element) => element[aprController.grp1nm.value],
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) =>
                        item1[aprController.grp2nm.value]
                            .compareTo(item2[aprController.grp2nm.value]),
                    order: GroupedListOrder.DESC,
                    useStickyGroupSeparators: false,
                    groupSeparatorBuilder: (String value) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value,
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: getColor(value))),
                    ),
                    itemBuilder: (c, element) {
                      return Card(
                        elevation: 8.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: SizedBox(
                          child: ExpansionTile(
                            title: Text(
                              element[aprController.grp2nm.value],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                      color:
                                          getColor(aprController.grp2nm.value)),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Order',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                          Text(
                                              element['tran_desc']
                                                      .toString()
                                                      .trim() +
                                                  ' - ' +
                                                  element['tran_no']
                                                      .toString()
                                                      .trim(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                          Text(
                                              'Rs. ' +
                                                  element['net_amt']
                                                      .toStringAsFixed(2),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                          flex: 1,
                                          child: Text(''),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['approvalstatus']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: getColor(
                                                      element['approvalstatus']
                                                          .toString())),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(getdmy(
                                                element['ord_dt'].toString()))),
                                        const Expanded(
                                            flex: 1, child: Text('')),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Billing',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                          Text(
                                            element['billdetails'].toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall,
                                          ),
                                        ]),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Expanded(
                                            flex: 1, child: Text(' ')),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['bill_asm_approval_status']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: getColor(element[
                                                          'bill_asm_approval_status']
                                                      .toString())),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              getdmy(element[
                                                      'bill_asm_approval_dt']
                                                  .toString()),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(element[
                                                    'bill_asm_approval_user']
                                                .toString())),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text('Finance',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['bill_account_approval_status']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: getColor(element[
                                                          'bill_account_approval_status']
                                                      .toString())),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              getdmy(element[
                                                      'bill_account_approval_dt']
                                                  .toString()),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(element[
                                                    'bill_account_approval_user']
                                                .toString())),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text('Logistic',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                              element['bill_logistic_approval_status']
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: getColor(element[
                                                          'bill_logistic_approval_status']
                                                      .toString())),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: Text(
                                              getdmy(element[
                                                      'bill_logistic_approval_dt']
                                                  .toString()),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Text(element[
                                                    'bill_logistic_approval_user']
                                                .toString())),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          /*ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                //leading: const Icon(Icons.account_circle),
                                title: Text(element[aController.grp2nm.value]),
                                //trailing: const Icon(Icons.arrow_forward),
                              ),*/
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class stockOptionWidget extends StatelessWidget {
  const stockOptionWidget({
    super.key,
    required this.aprController,
  });

  final ApprovalController aprController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Obx(() => Radio(
                          value: 'Status',
                          groupValue: aprController.grouptype.value,
                          //activeColor: tAccentColor,
                          onChanged: (value) {
                            aprController.onChangeGroup(value);
                          })),
                      const Expanded(child: Text('Statuswise'))
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Obx(
                        () => Radio(
                            value: 'Partywise',
                            groupValue: aprController.grouptype.value,
                            //activeColor: tAccentColor,
                            onChanged: (value) {
                              aprController.onChangeGroup(value);
                            }),
                      ),
                      const Expanded(child: Text('Partywise'))
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          //color: tAccentColor,
                          iconSize: 30.0,
                          disabledColor: Colors.grey,
                          highlightColor: tPrimaryColor,
                          onPressed: () async {
                            aprController.approveApi();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh),
                          //color: tAccentColor,
                          iconSize: 30.0,
                          disabledColor: Colors.grey,
                          highlightColor: tPrimaryColor,
                          onPressed: () async {
                            aprController.approveApi();
                          },
                        ),
                      ],
                    )),
              ],
            ),
            const Divider(
              color: tPrimaryColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: Text('Details',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
                Expanded(
                    flex: 1,
                    child: Text('Status',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
                Expanded(
                    flex: 1,
                    child: Text('Date',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
                Expanded(
                    flex: 1,
                    child: Text('ApprovedBy',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontSize: 18))),
              ],
            ),
            const Divider(
              color: tPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

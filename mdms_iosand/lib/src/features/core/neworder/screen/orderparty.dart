// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/appsecure.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:list_picker/list_picker.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';

class OrderPartyScreen extends StatelessWidget {
  const OrderPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderController ordcontroller = Get.put(OrderController());

    // this will check for add or edit
    int ordno = ordcontroller.ordrefno.value;

    OrderBasicController controller = Get.put(OrderBasicController());

    if (ordno > 0) {
      ordcontroller.setSingleOrderDetail(ordno);
      controller.acid(ordcontroller.currentOrder[0].ac_id);
      controller.ordrefno(ordcontroller.currentOrder[0].ref_no);
      controller.bukcmpstr(ordcontroller.currentOrder[0].company_sel);
      controller.setEditOrderRecord();
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TPrimaryHeaderContainer(
          height: 400,
          child: Column(
            children: [
              TAppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(ordno > 0 ? 'EDIT ORDER' : 'ADD ORDER'),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text('Book/Party/Credit Limit',
                          style: TextStyle(fontSize: 16, color: tPrimaryColor)),
                    ]),
                showBackArrow: false,
              ),
              OrderHeader(context, controller),
              PartySelect(context, controller),
              ChainOfStoreSelect(context, controller),
              SalesBookSelect(context, controller),
              //const TSearchContainer(text: 'Search Party',),
            ],
          )),
      Column(
        children: [
          Obx(() {
            return (controller.buknm.value != '' && controller.acid.value > 0)
                ? _Limit(context, controller)
                : const SizedBox();
          }),
        ],
      )
    ])));
  }

  _Limit(BuildContext context, OrderBasicController controller) {
    return ExpansionTile(
      initiallyExpanded: controller.ordrefno == 0 ? true : false,
      title: Text(
        'Credit Limits',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: controller.iscrdlimitover.value == false
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold),
      ),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CREDIT',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('O/S', style: Theme.of(context).textTheme.bodySmall),
                      Text('LIMIT',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('STATUS',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DAYS',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(
                      controller.bukosday.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(controller.bukcrday.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstday.toString().trim() == 'Over'
                        ? Icon(
                            Icons.clear,
                            color: Colors.red.shade900,
                            size: 20,
                          )
                        : Icon(
                            Icons.check,
                            color: Colors.green.shade900,
                            size: 20,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BILLS',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(controller.bukosbil.toString().trim(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(controller.bukcrbil.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstbil.toString().trim() == 'Over'
                        ? Icon(Icons.clear,
                            size: 20, color: Colors.red.shade900)
                        : Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.green.shade900,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('RS.#',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w400)),
                    Text(controller.bukosrs.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    Text(controller.bukcrrs.toString(),
                        style: Theme.of(context).textTheme.bodyMedium),
                    controller.bukstrs.trim() == 'Over'
                        ? Icon(
                            Icons.clear,
                            size: 20,
                            color: Colors.red.shade900,
                          )
                        : Icon(
                            Icons.check,
                            size: 20,
                            color: Colors.green.shade900,
                          ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CreditLimit(context, controller),
              ],
            ),
          ),
        ),
      ],
    );
  }

  CreditLimit(BuildContext context, OrderBasicController controller) {
    String msg = "";
    if (controller.iscrdlimitover == false) {
      msg = "Max. Order Amount Rs. " + controller.OrdLimit.toStringAsFixed(0);
    } else {
      msg = "Credit Limit Over";
    }
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            msg,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: controller.iscrdlimitover.value
                      ? Colors.red.shade900
                      : Colors.green.shade900,
                ),
          )
        ],
      ),
    );
  }

  Widget OrderHeader(BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(controller.ordqottype != 'QOT' ? 'Order # ' : 'Quote # ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 18)),
                  Text(
                      controller.istelephonicorder
                          ? controller.ordrefno.value.toString() +
                              ' Telephonic '
                          : (controller.ordrefno.value.toString()),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ]),
            //const Divider(),
          ]),
    );
  }

  Widget PartySelect(BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                    controller.acnm.value.isEmpty
                        ? 'Select Party '
                        : controller.acnm.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tCardLightColor, // Background color
                  foregroundColor:
                      tPrimaryColor, // Text Color (Foreground color)
                ),
                onPressed: () async {
                  final String? prnm = await showPickerDialog(
                    context: context,
                    label: 'Party',
                    items: controller.prtlist.map((f) => f.ac_nm!).toList(),
                  );
                  if (prnm != null) {
                    controller.setParty(prnm);
                    controller.acnm.value = prnm.toString();
                    controller.initorder(controller.acid.value);
                  }
                  if (controller.acid > 0) {
                    if (appSecure.chklocation == true &&
                        controller.invaliddist.value == false) {
                      Get.snackbar(
                          'Invalid Distance, You are ',
                          controller.cdistance.toString() +
                              ' mtrs away from Party Location');
                    }
                  }
                },
                child: const Text('>>'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  controller.ordlat.toString() +
                      '/' +
                      controller.ordlon.toString().toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400)),
              Text(controller.cdistance.toStringAsFixed(3) + ' mtrs',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }

  Widget ChainOfStoreSelect(
      BuildContext context, OrderBasicController controller) {
    bool shwcos = controller.coslist.isNotEmpty;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: shwcos
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Obx(
                        () => Text(
                            controller.chainareanm.value.isEmpty
                                ? 'Chain of Stores'
                                : controller.chainareanm.value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 16)),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tCardLightColor, // Background color
                          foregroundColor:
                              tPrimaryColor, // Text Color (Foreground color)
                        ),
                        onPressed: () async {
                          final String? cosnm = await showPickerDialog(
                            context: context,
                            label: 'Chain of Stores',
                            items: controller.coslist
                                .map((f) => f.areanm!)
                                .toList(),
                          );
                          if (cosnm != null) {
                            controller.chainareanm.value = cosnm;
                          }
                        },
                        child: const Text('>>'),
                      ),
                    ],
                  ),
                ],
              )
            : null);
  }

  Widget SalesBookSelect(
      BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                    controller.buknm.value.isEmpty
                        ? 'Sales Book '
                        : controller.buknm.value,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: tCardLightColor, // Background color
                  foregroundColor:
                      tPrimaryColor, // Text Color (Foreground color)
                ),
                onPressed: () async {
                  final String? buknm = await showPickerDialog(
                    context: context,
                    label: 'Sales Book',
                    items: controller.buklist.map((f) => f.trandesc!).toList(),
                  );
                  if (buknm != null) {
                    controller.buknm.value = buknm;
                    controller.loadcredit(buknm);
                    controller.setbukcmp(buknm);
                  }
                },
                child: const Text('>>'),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Today' 's Order ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
                Obx(() => Switch(
                      activeColor: Colors.green,
                      value: controller.todayorder.value,
                      onChanged: (bool newvalue) {
                        controller.setTodayorder(newvalue);
                        if (newvalue == false) {
                          Get.defaultDialog(
                              title: 'Save as No Order for Today',
                              middleText: 'Confirm',
                              backgroundColor: tCardLightColor.withOpacity(0.3),
                              titleStyle: const TextStyle(
                                  color: tSecondaryColor, fontSize: 20),
                              middleTextStyle:
                                  const TextStyle(color: tPrimaryColor),
                              radius: 15,
                              barrierDismissible: false,
                              textConfirm: "Yes",
                              confirmTextColor: tPrimaryColor,
                              textCancel: "No",
                              cancelTextColor: tSecondaryColor,
                              buttonColor: tCardBgColor,
                              onCancel: () => controller.setTodayorder(true));
                        }
                      },
                    ))
              ]),
        ],
      ),
    );
  }

  Future<dynamic> buildMsg(
      String title, String mtext, Color tcolor, Color mcolor) {
    return Get.defaultDialog(
      title: title,
      middleText: mtext,
      backgroundColor: tPrimaryColor.withOpacity(0.5),
      titleStyle: TextStyle(color: tcolor, fontSize: 20),
      middleTextStyle: TextStyle(color: mcolor),
      radius: 15,
      barrierDismissible: true,
      textConfirm: "OK",
      confirmTextColor: tPrimaryColor,
      textCancel: "CANCEL",
      cancelTextColor: tSecondaryColor,
      buttonColor: tCardBgColor,
    );
  }
}

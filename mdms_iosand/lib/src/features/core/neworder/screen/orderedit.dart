// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:list_picker/list_picker.dart';
import 'package:mdms_iosand/singletons/appsecure.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_order.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderitem.dart';

class OrderEditScreen extends StatelessWidget {
  const OrderEditScreen({super.key, required this.ordno});

  final int ordno;
  @override
  Widget build(BuildContext context) {
    OrderController ordcontroller = Get.put(OrderController());
    ordcontroller.setSingleOrderDetail(ordno);

    OrderBasicController controller = Get.put(OrderBasicController());
    controller.acid(ordcontroller.currentOrder[0].ac_id);
    controller.ordrefno(ordcontroller.currentOrder[0].ref_no);
    controller.bukcmpstr(ordcontroller.currentOrder[0].company_sel);
    controller.setEditOrderRecord();

    OrderItemController orditmcontroller = Get.put(OrderItemController());
    orditmcontroller.setTrantype('ORD');
    if (ordno > 0) {
      orditmcontroller.setOrdChoice('EDIT');
    }
    orditmcontroller.setImgcnt(1);
    orditmcontroller.refreshListApi();

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TPrimaryHeaderContainer(
          height: 400,
          child: Column(
            children: [
              const TAppBar(
                title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EDIT ORDER'),
                      SizedBox(
                        height: 8,
                      ),
                      Text('Book/Party/Credit Limit',
                          style: TextStyle(fontSize: 16, color: tPrimaryColor)),
                    ]),
                showBackArrow: false,
              ),
              EditOrderHeader(context, controller),
              EditPartySelect(context, controller),
              EditChainOfStoreSelect(context, controller),
              EditSalesBookSelect(context, controller),
              //EditOrderTotal(context, controller),
            ],
          )),
      const Column(
        children: [
          Text('Cart Items List'),
          //EditCartItems(context, controller),
        ],
      )
    ])));
  }

  Widget EditOrderHeader(
      BuildContext context, OrderBasicController controller) {
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
                  Text(
                      controller.ordqottype != 'QOT'
                          ? controller.istelephonicorder
                              ? 'Telephonic Order # '
                              : 'Order # '
                          : 'Quote # ',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400, fontSize: 18)),
                  Text(
                      '${controller.buknm.value.toString()} - ${controller.ordrefno.value.toString()}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ],
              ),
            ]),
            //const Divider(),
          ]),
    );
  }

  Widget EditPartySelect(
      BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Text(
                    controller.acnm.value.isEmpty
                        ? 'Party Name '
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
                onPressed: appSecure.editorder == false
                    ? null
                    : () async {
                        final String? prnm = await showPickerDialog(
                          context: context,
                          label: 'Party',
                          items:
                              controller.prtlist.map((f) => f.ac_nm!).toList(),
                        );
                        if (prnm != null) {
                          controller.setParty(prnm);
                          controller.acnm.value = prnm.toString();
                          controller.BookListApi(controller.acid.value);
                          controller.initEditorder(
                              controller.acid.value, controller.ordrefno.value);
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
              )
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

  Widget EditChainOfStoreSelect(
      BuildContext context, OrderBasicController controller) {
    bool shwcos = controller.coslist.isNotEmpty;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        onPressed: appSecure.editorder == false
                            ? null
                            : () async {
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

  Widget EditSalesBookSelect(
      BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                onPressed: appSecure.editorder == false
                    ? null
                    : () async {
                        final String? buknm = await showPickerDialog(
                          context: context,
                          label: 'Sales Book',
                          items: controller.buklist
                              .map((f) => f.trandesc!)
                              .toList(),
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
          /*
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
                      },
                    ))
              ]),
          */
        ],
      ),
    );
  }
}

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/common_widgets/appbar/appbar.dart';
import 'package:mdms_iosand/src/common_widgets/custom_shapes/container/primary_header_container.dart';
import 'package:mdms_iosand/src/common_widgets/searchbar/tsearchbar.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderbasic.dart';

class OrderPartyScreen extends StatelessWidget {
  const OrderPartyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    OrderBasicController controller = Get.put(OrderBasicController());
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      TPrimaryHeaderContainer(
          height: 300,
          child: Column(
            children: [
              const TAppBar(
                title: Text('ORDER - Basic Details'),
                showBackArrow: false,
              ),
              const Divider(),
              OrderHeader(context, controller),
              const Divider(),
              // SearchBar
              const TSearchContainer(
                text: 'Search Party',
              ),
            ],
          )),
    ])));
  }

  Widget OrderHeader(BuildContext context, OrderBasicController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                      controller.ordlat.toString() +
                          '/' +
                          controller.ordlon.toString().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  Text(controller.cdistance.toStringAsFixed(3) + ' mtrs',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              )
            ]),
            const Divider(),
          ]),
    );
  }
}

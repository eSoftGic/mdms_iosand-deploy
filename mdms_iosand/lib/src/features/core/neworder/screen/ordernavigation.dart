// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/screen/orderitemlist.dart';
import 'package:mdms_iosand/src/features/core/neworder/screen/orderparty.dart';

//import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_orderbasic.dart';
//import 'package:mdms_iosand/src/features/core/neworder/screen/orderparty.dart';
//import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_ordercartlist.dart';
//import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/widget_orderitemlist.dart';

class OrderNavigationScreen extends StatelessWidget {
  const OrderNavigationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final navcontroller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(() => NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: navcontroller.selectedIndex.value,
              onDestinationSelected: (index) =>
                  navcontroller.selectedIndex.value = index,
              destinations: const [
                NavigationDestination(
                    icon: Icon(Icons.person), label: 'Basic Details'),
                NavigationDestination(
                    icon: Icon(Icons.category), label: 'Products'),
                NavigationDestination(
                    icon: Icon(Icons.shopping_cart), label: 'Cart List'),
                NavigationDestination(
                    icon: Icon(Icons.save), label: 'Save Order'),
              ])),
      body: Obx(() => navcontroller.screens[navcontroller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final screens = [
    OrderPartyScreen(),
    OrderitemListScreen(),
    //OrderBasicFormWidget(),
    //OrderItemList(ordch: 'ADD'),
    Container(
      color: Colors.blue,
    ),
    //OrderCartScreen(),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.orange,
    ),
  ];
}

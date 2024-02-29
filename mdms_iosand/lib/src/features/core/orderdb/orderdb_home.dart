// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/orderdb/orderdb_controller.dart';
//import 'package:mdms_iosand/src/features/core/screens/target/Target.dart';

class OrderDbHomePage extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  OrderDbHomePage({super.key});

  buildBottomNavigationMenu(context, orderdbController) {
    return Obx(() => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              showUnselectedLabels: true,
              showSelectedLabels: true,
              onTap: orderdbController.changeTabIndex,
              currentIndex: orderdbController.tabIndex.value,
              backgroundColor: tPrimaryColor, //.fromRGBO(36, 60, 101, 1.0),
              unselectedItemColor: Colors.white.withOpacity(0.5),
              selectedItemColor: Colors.white,
              unselectedLabelStyle: unselectedLabelStyle,
              selectedLabelStyle: selectedLabelStyle,
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.home,
                      size: 24.0,
                    ),
                  ),
                  label: 'List',
                  backgroundColor: Color.fromRGBO(36, 60, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.search,
                      size: 24.0,
                    ),
                  ),
                  label: 'Pending',
                  backgroundColor: Color.fromRGBO(36, 60, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.location_history,
                      size: 24.0,
                    ),
                  ),
                  label: 'Billed',
                  backgroundColor: Color.fromRGBO(36, 60, 101, 1.0),
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.settings,
                      size: 24.0,
                    ),
                  ),
                  label: 'Settings',
                  backgroundColor: Color.fromRGBO(36, 60, 101, 1.0),
                ),
              ],
            ),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    final OrderDbController orderdbController =
        Get.put(OrderDbController(), permanent: false);
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, orderdbController),
      body: Obx(() => IndexedStack(
            index: orderdbController.tabIndex.value,
            children: const [
              Text('HomePage()'),
              Text('ExplorePage()'),
              Text('PlacesPage()'),
              Text('SettingsPage()'),
            ],
          )),
    ));
  }
}

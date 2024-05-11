// ignore_for_file: unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/constants/sizes.dart';
import 'package:mdms_iosand/src/constants/text_strings.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/widgets/appbar.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/widgets/categories.dart';
import 'package:mdms_iosand/src/features/core/screens/dashboard/widgets/dashboard_chart.dart';

import '../../../../../singletons/AppData.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool shwchart = false;
  @override
  Widget build(BuildContext context) {
    //Variables
    final txtTheme = Theme.of(context).textTheme;
    final isDark = MediaQuery.of(context).platformBrightness ==
        Brightness.dark; //Dark mode
    return SafeArea(
      child: Scaffold(
        appBar: DashboardAppBar(isDark: Get.isDarkMode),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDashboardPadding - 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Heading
                Text(getutype(),
                    style: txtTheme.bodyLarge!.copyWith(
                        fontSize: 20,
                        color: isDark ? tSecondaryColor : tPrimaryColor)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tDashboardHeading,
                        style: txtTheme.displaySmall!.copyWith(
                          fontSize: 18,
                          color: isDark ? tSecondaryColor : tCardBgColor,
                        )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          shwchart = !shwchart;
                        });
                      },
                      child: Icon(
                        Icons.bar_chart,
                        color: isDark
                            ? tCardLightColor //.withOpacity(0.5)
                            : tCardBgColor, //.withOpacity(0.5),
                        size: 24,
                      ),
                    ),
                  ],
                ),
                shwchart
                    ? Padding(
                        padding: const EdgeInsets.all(5.0),
                        child:
                            DashboardChart(txtTheme: txtTheme, isDark: isDark),
                      )
                    : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: DashboardCategories(
                    txtTheme: txtTheme,
                    showchart: shwchart,
                  ),
                ),

                //Search Box
                //DashboardSearchBox(txtTheme: txtTheme),
                //const SizedBox(height: tDashboardPadding),
                //Categories

                const SizedBox(height: tDashboardPadding),
                //ShowStaggeredGrid(),
                //Banners
                //DashboardBanners(txtTheme: txtTheme, isDark: isDark),
                //const SizedBox(height: tDashboardPadding),
                //Top Course
                //Text(tDashboardTopCourses, style: txtTheme.headlineMedium?
                //.apply(fontSizeFactor: 1.2)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getutype() {
    String utype = '';
    if (appData.log_type == 'SMAN' ||
        appData.log_type == 'ASM' ||
        appData.log_type == 'DLR') {
      return 'Salesman ' + appData.log_name.toString().toUpperCase();
    }
    if (appData.log_type == 'DLR' || appData.log_type == 'PARTY') {
      return 'Dealer ' + appData.prtnm.toString().toUpperCase();
    }
    if (appData.log_type == 'DLV') {
      return 'Deliveryman ' + appData.log_name.toString().toUpperCase();
    }
    return appData.log_type.toString() +
        ' ' +
        appData.log_name.toString().toUpperCase();
  }
}

/*
  // Staggerd View from Prev. Version
  Widget myItems(
      String heading, IconData icon, int color, int index, bool enbl) {
    return GestureDetector(
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: <Widget>[
            Icon(
              icon,
              size: 96.0,
              color: Color(color),
            ),
            Text(heading, style: TextStyle(fontSize: 18, color: Color(color))),
          ],
        ),
      ),
      onTap: () => _onTileClicked(index),
    );
  }
  Widget ShowStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      //padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: <Widget>[
        myItems("Party", Icons.people, 0xff3399fe, 1, true),
        myItems("Orders", Icons.shopping_cart, 0xff622f74, 2, true),
        myItems("Outstanding", Icons.receipt, 0xff26cb3c, 3, true),
        myItems("Receipts", Icons.payment, 0xffff5829, 5, true),
        myItems("Stock", Icons.category, 0xffff3266, 4, true),
        myItems("Maps", Icons.map, 0xff5B8076, 6, true),
        myItems("Target/Achivement", Icons.show_chart, 0xffff5829, 8, true),
        myItems("Delivery", Icons.airport_shuttle, 0xffeab676, 9, true),
      ],
    );
  }
  void _onTileClicked(int index) {
    print(index);
    if (_usertype != 'DMAN') {
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Party()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Order()));
      }
      if (index == 3) {
        if (appSecure.showos == false) {
          _showAlert('Outstanding Report', 'You are not Authorised');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Outstanding()));
        }
      }
      if (index == 5) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReceiptSummary()));
      }
      if (index == 6) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MapPage()));
      }
      if (index == 4) {
        if (appSecure.showstock == false) {
          _showAlert('Stock Report', 'You are not Authorised');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Stock()));
        }
      }
      if (index == 7) {
        if (appSecure.showqot == false) {
          _showAlert('Quotation', 'You are not Authorised');
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Quotation()));
        }
      }
      if (index == 8) {
        if (appSecure.showtarget == false) {
          _showAlert('Target/Achievement', 'You are not Authorised');
        } else {
          setState(() {
            appData.ispartytrgt = false;
            appData.partytrgtid = 0;
          });
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Target()));
        }
      }
      if (index == 9) {
        if (_usertype == 'DMAN') {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Delivery()));
        } else {
          _showAlert(
              'User is not Deliveryman', 'You are not Authorised for Delivery');
        }
      }
    } else {
    if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Delivery()));
      }
    if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ReceiptSummary()));
      }
  }*/
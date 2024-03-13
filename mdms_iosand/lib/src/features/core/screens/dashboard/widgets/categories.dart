// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/AppData.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/orderdb/orderhome.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/screen_allocation.dart';
import 'package:mdms_iosand/src/features/core/screens/approval/screen_approvalhome.dart';
import 'package:mdms_iosand/src/features/core/screens/order/controller_order.dart';
import 'package:mdms_iosand/src/features/core/screens/order/screen_orderhome.dart';
import '../../../models/dashboard/categories_model.dart';
import '../../party/home_list/party_home.dart';
import '../../prebook/home/screen_prebookhome.dart';
import '../../stock/stock_home.dart';
import '../../target/Target.dart';

class DashboardCategories extends StatelessWidget {
  const DashboardCategories({
    super.key,
    required this.txtTheme,
    required this.showchart,
  });

  final TextTheme txtTheme;
  final bool showchart;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final list = appData.log_type == 'PARTY'
        ? DashboardCategoriesModel.prtlist
        : DashboardCategoriesModel.list;
    double listht = size.height - (showchart ? 550 : 200);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
          height: listht,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Get.isDarkMode
                ? tCardDarkColor
                : tCardLightColor.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ListView.builder(
            itemCount: list.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical, //.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                switch (list[index].menuname) {
                  case 'STK':
                    Get.to(() => const StockHomeScreen());
                    break;
                  case 'PRT':
                    Get.to(() => const PartyHomeScreen());
                    break;
                  case 'ORD':
                    OrderController().setOrdforacid(0);
                    Get.to(() => const OrderHomeView());
                    //Get.to(() => const OrderHomeScreen());
                    break;
                  case 'ALO':
                    Get.to(() => const AllocateScreen());
                    break;
                  case 'APR':
                    Get.to(() => const ApprovalScreen());
                    break;
                  case 'TRK':
                    Get.to(() =>
                        const OrderHomeScreen()); //TrackScreen()); // MyTimeLine()); //
                    break;
                  case 'PRB':
                    Get.to(() =>
                        const PrebookHomeScreen()); //TrackScreen()); // MyTimeLine()); //
                    break;
                  case 'TRG':
                    Get.to(() => const Target());
                    break;
                  case 'DWN':
                    Get.snackbar('Download', 'RDS');
                    break;
                  case 'OS':
                    Get.snackbar('Outstanding', 'RDS');
                    break;
                  case 'GEO':
                    Get.snackbar('Geo', 'RDS');
                    break;
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: 70,
                  child: Card(
                      elevation: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          width: 1, color: tAccentColor),
                                      color: Get.isDarkMode
                                          ? tCardLightColor.withOpacity(0.5)
                                          : tCardBgColor.withOpacity(0.5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        list[index].icon,
                                        size: 28.0,
                                        color: Color(list[index].color),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  list[index].heading +
                                      ' ' +
                                      list[index].subHeading,
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: Color(list[index].color),
                                      ),
                                ),
                              ],
                            ),
                          ),
                          /*showchart
                          ? Row(
                                  children: [
                                    Container(
                                      height: 175,
                                      width: 375,
                                      child: HighCharts(
                                        loader: const SizedBox(
                                          child: LinearProgressIndicator(),
                                          width: 40,
                                        ),
                                        size: Size(370, 170),
                                        data: _chartData,
                                        scripts: const [
                                          "https://code.highcharts.com/highcharts.js",
                                          'https://code.highcharts.com/modules/networkgraph.js',
                                          'https://code.highcharts.com/modules/exporting.js',
                                        ],
                                      ),
                                    )
                                  ],
                                )
                          : SizedBox()*/
                        ],
                      )),
                ),
              ),
            ),
          )),
    );
  }
}

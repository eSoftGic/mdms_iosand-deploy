// ignore_for_file: dead_code, depend_on_referenced_packages

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constants/colors.dart';
import 'package:high_chart/high_chart.dart';
import '../../../models/dashboard/chart_model.dart';
import 'package:pie_chart/pie_chart.dart';

enum LegendShape { circle, rectangle }

class DashboardChart extends StatelessWidget {
  const DashboardChart({
    super.key,
    required this.txtTheme,
    required this.isDark,
  });

  final TextTheme txtTheme;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final list = DashboardChartModel.list;
    return SizedBox(
      height: 410,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 385,
            height: 400,
            child: Padding(
              padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? tCardDarkColor : tCardLightColor.withOpacity(0.2),
                ),
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 400,
                          width: 375,
                          child: ChartWidget(list: list, showpie: true, index: index),
                        )
                      ],
                    ),
                    /*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            list[index].title,
                            style: txtTheme.headlineMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(child: Image(image: AssetImage(list[index].image), height: 110)),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                          onPressed: () {},
                          child: const Icon(Icons.play_arrow),
                        ),
                        const SizedBox(width: tDashboardCardPadding),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              list[index].heading,
                              style: txtTheme.headlineMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              list[index].subHeading,
                              style: txtTheme.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    )
                    */
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.list, required this.showpie, required this.index});

  final List<DashboardChartModel> list;
  final bool showpie;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colorList = <Color>[
      const Color(0xfffdcb6e),
      const Color(0xff0984e3),
      const Color(0xfffd79a8),
      const Color(0xffe17055),
      const Color(0xff6c5ce7),
    ];
    final gradientList = <List<Color>>[
      [
        const Color.fromRGBO(223, 250, 92, 1),
        const Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        const Color.fromRGBO(129, 182, 205, 1),
        const Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        const Color.fromRGBO(175, 63, 62, 1.0),
        const Color.fromRGBO(254, 154, 92, 1),
      ]
    ];
    final legendLabels = <String, String>{
      "Order": "Order",
      "NoOrder": "NoOrder",
      "Apprv.Pending": "Apprv.Pending",
      "PreBook": "PreBook",
    };

    ChartType? chartType = ChartType.disc;
    bool showCenterText = true;
    double? ringStrokeWidth = 32;
    double? chartLegendSpacing = 32;
    bool showLegendsInRow = false;
    bool showLegends = true;
    bool showLegendLabel = false;
    bool showChartValueBackground = true;
    bool showChartValues = true;
    bool showChartValuesInPercentage = false;
    bool showChartValuesOutside = false;
    bool showGradientColors = false;
    LegendShape? legendShape = LegendShape.circle;
    LegendPosition? legendPosition = LegendPosition.right;
    int key = 0;
    return showpie == false
        ? HighCharts(
            loader: const SizedBox(
              width: 40,
              child: LinearProgressIndicator(),
            ),
            size: const Size(370, 400),
            data: list[index].chartdata,
            scripts: const [
              "https://code.highcharts.com/highcharts.js",
              'https://code.highcharts.com/modules/networkgraph.js',
              'https://code.highcharts.com/modules/exporting.js',
            ],
          )
        : PieChart(
            key: ValueKey(key),
            dataMap: list[index].datapie,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: chartLegendSpacing,
            chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: chartType,
            centerText: showCenterText ? list[index].title : null,
            legendLabels: showLegendLabel ? legendLabels : {},
            legendOptions: LegendOptions(
              showLegendsInRow: showLegendsInRow,
              legendPosition: legendPosition,
              showLegends: showLegends,
              legendShape:
                  legendShape == LegendShape.circle ? BoxShape.circle : BoxShape.rectangle,
              legendTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: showChartValueBackground,
              showChartValues: showChartValues,
              showChartValuesInPercentage: showChartValuesInPercentage,
              showChartValuesOutside: showChartValuesOutside,
            ),
            ringStrokeWidth: ringStrokeWidth,
            emptyColor: Colors.grey,
            gradientList: showGradientColors ? gradientList : null,
            emptyColorGradient: const [
              Color(0xff6c5ce7),
              Colors.blue,
            ],
            baseChartColor: Colors.transparent,
          );
  }
}
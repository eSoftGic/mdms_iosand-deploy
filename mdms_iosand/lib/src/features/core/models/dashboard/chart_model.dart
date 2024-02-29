import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/constants/image_strings.dart';

class DashboardChartModel {
  final String title;
  final String heading;
  final String subHeading;
  final String image;
  final VoidCallback? onPress;
  final String chartdata;
  final Map<String, double> datapie;

  DashboardChartModel(this.title, this.heading, this.subHeading, this.image, this.onPress,
      this.chartdata, this.datapie);

  static const String _chartOrderData = '''{
      title: {
          text: 'Order [86]'
      },    
      xAxis: {
          categories: ['Ord', 'NoOrd', 'Pend', 'PreBk']
      },
      labels: {
          items: [{
              html: 'Order',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
       series: [
      {
          type: 'pie',
          name: 'Order',
          data: [{
              name: 'Ord',
              y: 40,
              color: Highcharts.getOptions().colors[0] // Qtr 1 color
          }, {
              name: 'NoOrd',
              y: 16,
              color: Highcharts.getOptions().colors[1] // Qtr 2 color
          }, {
              name: 'Appr.Pending',
              y: 20,
              color: Highcharts.getOptions().colors[2] // Qtr 3 color
          },{
              name: 'PreBk',
              y: 10,
              color: Highcharts.getOptions().colors[3] // Qtr 4 color
          }
          ],
          center: [150, 50],
          size: 125,
          showInLegend: true,
          dataLabels: {
              enabled: true
          }
        }]
    }''';
  static const String _chartPartyData = '''{
      title: {
          text: 'Party [123]'
      },    
      xAxis: {
          categories: ['Ord', 'NoOrd', 'Pend', 'PreBk']
      },
      labels: {
          items: [{
              html: 'Party',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
       series: [
      {
          type: 'pie',
          name: 'Order',
          data: [{
              name: 'Ord',
              y: 20,
              color: Highcharts.getOptions().colors[0] // Qtr 1 color
          }, {
              name: 'NoOrd',
              y: 36,
              color: Highcharts.getOptions().colors[1] // Qtr 2 color
          }, {
              name: 'Appr.Pending',
              y: 10,
              color: Highcharts.getOptions().colors[2] // Qtr 3 color
          },{
              name: 'PreBk',
              y: 2,
              color: Highcharts.getOptions().colors[3] // Qtr 4 color
          }
          ],
          center: [150, 50],
          size: 125,
          showInLegend: true,
          dataLabels: {
              enabled: true
          }
        }]
    }''';
  static const String _chartStockData = '''{
      title: {
          text: 'Stock Status'
      },    
      xAxis: {
          categories: ['Orders', 'NoOrders', 'Apprvl.Pending', 'PreBook']
      },
      labels: {
          items: [{
              html: 'Stock',
              style: {
                  left: '50px',
                  top: '18px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
      },
       series: [{
          type: 'column',
          name: 'Jane',
          data: [3, 2, 1, 3, 3]
      }, {
          type: 'column',
          name: 'John',
          data: [2, 4, 5, 7, 6]
      }, {
          type: 'column',
          name: 'Joe',
          data: [4, 3, 3, 5, 0]
      }, {
          type: 'spline',
          name: 'Average',
          data: [3, 2.67, 3, 6.33, 3.33],
          marker: {
              lineWidth: 2,
              lineColor: Highcharts.getOptions().colors[3],
              fillColor: 'white'
          }
      }, {
          type: 'pie',
          name: 'Total consumption',
          data: [{
              name: 'Jane',
              y: 13,
              color: Highcharts.getOptions().colors[0] // Jane's color
          }, {
              name: 'John',
              y: 23,
              color: Highcharts.getOptions().colors[1] // John's color
          }, {
              name: 'Joe',
              y: 19,
              color: Highcharts.getOptions().colors[2] // Joe's color
          }],
          center: [50, 5],
          size: 50,
          showInLegend: true,
          dataLabels: {
              enabled: false
          }
        }]
    }''';

  static Map<String, double> dataOrderMap = <String, double>{
    "Orders": 5,
    "NoOrder": 3,
    "Appr.Pending": 2,
    "PreBook": 2,
  };
  static Map<String, double> dataPartyMap = <String, double>{
    "Orders": 15,
    "NoOrder": 7,
    "Appr.Pending": 10,
    "PreBook": 5,
  };
  static Map<String, double> dataStockMap = <String, double>{
    "Total Items": 3545,
    "Order Items": 1500,
    "NoOrder Items": 2200,
    "Prebook Items": 56,
  };

  static List<DashboardChartModel> list = [
    DashboardChartModel("Orders", "3 Sections", "Programming Languages", tTopCourseImage1, () {},
        _chartOrderData, dataOrderMap),
    DashboardChartModel(
        "Party", "2 Sections", "35 Lessons", tTopCourseImage2, null, _chartPartyData, dataPartyMap),
    DashboardChartModel("Stock", "6 Sections", "Programming & Design", tTopCourseImage1, () {},
        _chartStockData, dataStockMap),
  ];
}
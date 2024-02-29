// ignore_for_file: library_private_types_in_public_api, unused_field, file_names, depend_on_referenced_packages, non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:high_chart/high_chart.dart';
import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Target extends StatefulWidget {
  const Target({super.key});

  @override
  _TargetState createState() => _TargetState();
}

List<TargetModel> _targetlist = <TargetModel>[];
List<TargetSalesModel> _targetsalelist = <TargetSalesModel>[];
List<TargetOsModel> _targetoslist = <TargetOsModel>[];
List<TargetOsRowModel> _targetosRowlist = <TargetOsRowModel>[];
late TargetDataSource targetDataSource;
late TargetSaleDataSource targetSaleDataSource;
late TargetOsRowDataSource targetOsRowDataSource;

class _TargetState extends State<Target> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int tablength = 3;
  int _curind = 0;
  String _trgttype = "";
  int _trgtid = 0;
  String _subtitle = "";

  var tabtextstyle = const TextStyle(
      color: Colors.white,
      //fontFamily: 'Montserrat-Regular',
      fontSize: 18,
      fontWeight: FontWeight.bold);
  var tabunselstyle = const TextStyle(
      //fontFamily: 'Montserrat-Regular',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black);
  var gridtextstyle = TextStyle(
      //fontFamily: 'Montserrat-Medium',
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Get.isDarkMode ? tWhiteColor : tPrimaryColor);
  var hdrcaptionstyle = TextStyle(
      //fontFamily: 'Montserrat-Medium',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? tWhiteColor : tPrimaryColor);

  String catlist = '';
  String datatarget = '';
  String dataachvd = '';
  double trgtot = 0.0;
  double achtot = 0.0;
  double trgpcn = 0.0;
  double achpcn = 0.0;

  String dataytd = '';
  String datamtd = '';
  String dataprv = '';

  String data1 = '';
  String ddesc1 = '';
  String data2 = '';
  String ddesc2 = '';
  String data3 = '';
  String ddesc3 = '';
  String data4 = '';
  String ddesc4 = '';
  String data5 = '';
  String ddesc5 = '';
  int b1 = 0;
  int b2 = 0;
  int b3 = 0;
  int b4 = 0;
  int b5 = 0;
  int btot = 0;

  bool _targetchartloaded = false;
  bool _saleschartloaded = false;
  bool _oschartloaded = false;

  String _chart_target = '''{
        title: {
          text: 'TARGET v/s ACHEIVEMENT'
        },
        subtitle: {
         text : 'SUBTITLE',
         style: {
            color: 'black',
         }
        },
        xAxis: {
          categories: [CATSTR]
        },
         labels: {
          items: [{
              html: '',
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
          name: 'Target',
          data: [COL1DATA],
        },{
          type: 'column',
          name: 'Acheived',
          data: [COL2DATA],
        },{
          type: 'pie',
          name: 'Total',
          data: [{
              name: 'Target',
              y: TPCN,
              color: Highcharts.getOptions().colors[0] 
          }, {
              name: 'Acheived',
              y: APCN,
              color: Highcharts.getOptions().colors[1] 
          },
           ],
          center: [150, 10],
          size: 60,
          showInLegend: false,
          dataLabels: {
              enabled: false
          }
        }
      ]
     }''';
  String _chart_sales = '''{
        title: {
          text: 'SALES'
        },
        subtitle: {
         text : 'SUBTITLE',
         style: {
            color: 'black',
         }
        },
         xAxis: {
          categories: [CATSTR]
        },
        labels: {
          items: [{
              html: '',
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
          name: 'PREVIOUS',
          data: [COL1DATA]
        },{
          type: 'column',
          name: 'MTD',
          data: [COL2DATA]
        },
        {
          type: 'column',
          name: 'YTD',
          data: [COL3DATA]
        },  
      ]
     }''';
  String _chart_os = '''{
        title: {
          text: 'OUTSTANDING'
        },
        subtitle: {
         text : 'SUBTITLE',
         style: {
            color: 'black',
         }
        },
         xAxis: {
          categories: [CATSTR]
        },
        
        labels: {
          items: [{
              html: 'Bills',
              style: {
                  left: '200px',
                  top: '10px',
                  color: ( // theme
                      Highcharts.defaultOptions.title.style &&
                      Highcharts.defaultOptions.title.style.color
                  ) || 'black'
              }
          }]
        },
        series: [{
          type: 'column',
          name: 'D1',
          data: [COL1DATA]
        },{
          type: 'column',
          name: 'D2',
          data: [COL2DATA]
        }, {
          type: 'column',
          name: 'D3',
          data: [COL3DATA]
        }, {
          type: 'column',
          name: 'D4',
          data: [COL4DATA]
        },{
          type: 'column',
          name: 'D5',
          data: [COL5DATA]
        },{
          type: 'pie',
          name: '',
          data: [{
              name: 'D1',
              y: B1,
              color: Highcharts.getOptions().colors[0] ,
          },{
              name: 'D2',
              y: B2,
              color: Highcharts.getOptions().colors[1] 
          },
          {
              name: 'D3',
              y: B3,
              color: Highcharts.getOptions().colors[2] 
          },
          {
              name: 'D4',
              y: B4,
              color: Highcharts.getOptions().colors[3] 
          },
          {
              name: 'D5',
              y: B5,
              color: Highcharts.getOptions().colors[4] 
          }
           ],
          center: [150, 10],
          size: 60,
          showInLegend: false,
          dataLabels: {
              enabled: false
          }
        }
      ]
     }''';

  final String _chartData = '''{
      title: {
          text: 'TRG v/s ACHV'
      },    
      xAxis: {
          categories: [CATSTR]
          
      },
      labels: {
          items: [{
              html: 'Total fruit consumption',
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
          center: [100, 80],
          size: 100,
          showInLegend: false,
          dataLabels: {
              enabled: false
          }
        }]
    }''';

  Future<List<TargetModel>> fetchTarget() async {
    var qryparam = "DbName=${appData.log_dbnm!}&User_Type_Code=$_trgttype&Sman_Party_Id=${_trgtid.toString().trim()}";

    var url = Uri.parse("${appData.baseurl!}mdms_target_achieve?$qryparam");
    print(url);
    var trglist = <TargetModel>[];

    var response = await http.get(url);
    catlist = '';
    datatarget = '';
    dataachvd = '';
    trgtot = 0.0;
    achtot = 0.0;
    trgpcn = 0;
    achpcn = 0;
    if (response.statusCode == 200) {
      trglist.clear();
      var ors = json.decode(response.body);
      for (var ordjson in ors) {
        trglist.add(TargetModel.fromJson(ordjson));
        catlist += catlist.trim().isNotEmpty
            ? "${",'" + ordjson['TARGET_DESC']}'"
            : "${"'" + ordjson['TARGET_DESC']}'";
        datatarget += datatarget.trim().isNotEmpty
            ? ",${ordjson['TARGET']}"
            : "${ordjson['TARGET']}";
        dataachvd += dataachvd.trim().isNotEmpty
            ? ",${ordjson['ACHIEVED']}"
            : ordjson['ACHIEVED'].toString();
        trgtot += ordjson['TARGET'];
        achtot += ordjson['ACHIEVED'];
      }
    }

    double pietot = achtot + trgtot;
    trgpcn = trgtot * 100 / pietot;
    achpcn = 100 - trgpcn;
    _chart_target = _chart_target
        .replaceAll('CT1', 'TARGET / ACHEIVEMENT')
        .replaceAll('SUBTITLE', _subtitle)
        .replaceAll('CATSTR', catlist)
        .replaceAll('COL1DATA', datatarget)
        .replaceAll('COL2DATA', dataachvd)
        .replaceAll('TPCN', trgpcn.toStringAsFixed(2))
        .replaceAll('APCN', achpcn.toStringAsFixed(2));

    setState(() {
      _targetchartloaded = trglist.isNotEmpty;
    });
    return trglist;
  }

  Future<List<TargetSalesModel>> fetchSales() async {
    var qryparam = "DbName=${appData.log_dbnm!}&User_Type_Code=$_trgttype&Sman_Party_Id=${_trgtid.toString().trim()}";

    var url = Uri.parse("${appData.baseurl!}mdms_sales_total?$qryparam");
    print(url);
    var trgsllist = <TargetSalesModel>[];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      trgsllist.clear();
      var ors = json.decode(response.body);
      catlist = '';
      dataprv = '';
      datamtd = '';
      dataytd = '';
      for (var ordjson in ors) {
        trgsllist.add(TargetSalesModel.fromJson(ordjson));
        catlist += catlist.trim().isNotEmpty
            ? "${",'" + ordjson['COMPANY_NM']}'"
            : "${"'" + ordjson['COMPANY_NM']}'";
        dataprv += dataprv.trim().isNotEmpty
            ? ",${ordjson['SALES_YESTERDAYT']}"
            : "${ordjson['SALES_YESTERDAY']}";
        datamtd += datamtd.trim().isNotEmpty
            ? ",${ordjson['SALES_MTD']}"
            : "${ordjson['SALES_MTD']}";
        dataytd += dataytd.trim().isNotEmpty
            ? ",${ordjson['SALES_YTD']}"
            : "${ordjson['SALES_YTD']}";
      }
    }
    _chart_sales = _chart_sales
        .replaceAll('SUBTITLE', _subtitle)
        .replaceAll('CATSTR', catlist)
        .replaceAll('COL1DATA', dataprv)
        .replaceAll('COL2DATA', datamtd)
        .replaceAll('COL3DATA', dataytd);
    setState(() {
      _saleschartloaded = trgsllist.isNotEmpty;
    });
    return trgsllist;
  }

  Future<List<TargetOsModel>> fetchOutStanding() async {
    var qryparam = "DbName=${appData.log_dbnm!}&User_Type_Code=$_trgttype&Sman_Party_Id=${_trgtid.toString().trim()}";
    var url = Uri.parse("${appData.baseurl}mdms_outstanding?$qryparam");
    print(url);
    var trgoslist = <TargetOsModel>[];
    var response = await http.get(url);
    catlist = '';
    data1 = '';
    data2 = '';
    data3 = '';
    data4 = '';
    data5 = '';
    ddesc1 = '';
    ddesc2 = '';
    ddesc3 = '';
    ddesc4 = '';
    ddesc5 = '';
    b1 = 0;
    b2 = 0;
    b3 = 0;
    b4 = 0;
    b5 = 0;
    btot = 0;

    if (response.statusCode == 200) {
      trgoslist.clear();
      var ors = json.decode(response.body);
      for (var ordjson in ors) {
        trgoslist.add(TargetOsModel.fromJson(ordjson));
        catlist += catlist.trim().isNotEmpty
            ? "${",'" + ordjson['TRAN_DESC']}'"
            : "${"'" + ordjson['TRAN_DESC']}'";
        data1 += data1.trim().isNotEmpty
            ? ",${ordjson['AGE_AMOUNT_1']}"
            : "${ordjson['AGE_AMOUNT_1']}";
        data2 += data2.trim().isNotEmpty
            ? ",${ordjson['AGE_AMOUNT_2']}"
            : "${ordjson['AGE_AMOUNT_2']}";
        data3 += data3.trim().isNotEmpty
            ? ",${ordjson['AGE_AMOUNT_3']}"
            : "${ordjson['AGE_AMOUNT_3']}";
        data4 += data4.trim().isNotEmpty
            ? ",${ordjson['AGE_AMOUNT_4']}"
            : "${ordjson['AGE_AMOUNT_4']}";
        data5 += data5.trim().isNotEmpty
            ? ",${ordjson['AGE_AMOUNT_5']}"
            : "${ordjson['AGE_AMOUNT_5']}";

        ddesc1 = ddesc1 == '' ? ordjson['AGE_1_DESC'] : ddesc1;
        ddesc2 = ddesc2 == '' ? ordjson['AGE_2_DESC'] : ddesc2;
        ddesc3 = ddesc3 == '' ? ordjson['AGE_3_DESC'] : ddesc3;
        ddesc4 = ddesc4 == '' ? ordjson['AGE_4_DESC'] : ddesc4;
        ddesc5 = ddesc5 == '' ? ordjson['AGE_5_DESC'] : ddesc5;
        b1 += int.parse(ordjson!['AGE_BILLS_1'].toString());
        b2 += int.parse(ordjson['AGE_BILLS_2'].toString());
        b3 += int.parse(ordjson['AGE_BILLS_3'].toString());
        b4 += int.parse(ordjson['AGE_BILLS_4'].toString());
        b5 += int.parse(ordjson['AGE_BILLS_5'].toString());
      }
      _chart_os = _chart_os
          .replaceAll('SUBTITLE', _subtitle)
          .replaceAll('CATSTR', catlist)
          .replaceAll('COL1DATA', data1)
          .replaceAll('COL2DATA', data2)
          .replaceAll('COL3DATA', data3)
          .replaceAll('COL4DATA', data4)
          .replaceAll('COL5DATA', data5)
          .replaceAll('D1', ddesc1)
          .replaceAll('D2', ddesc2)
          .replaceAll('D3', ddesc3)
          .replaceAll('D4', ddesc4)
          .replaceAll('D5', ddesc5)
          .replaceAll('B1', b1.toString())
          .replaceAll('B2', b2.toString())
          .replaceAll('B3', b3.toString())
          .replaceAll('B4', b4.toString())
          .replaceAll('B5', b5.toString());

      //print(_chart_os);
      setState(() {
        _oschartloaded = trgoslist.isNotEmpty;
      });
    }
    return trgoslist;
  }

  Future<List<TargetOsRowModel>> fetchOutRowStanding() async {
    var qryparam = "DbName=${appData.log_dbnm!}&User_Type_Code=$_trgttype&Sman_Party_Id=${_trgtid.toString().trim()}";
    var url = Uri.parse("${appData.baseurl}mdms_outstanding_row?$qryparam");
    print(url);
    var trgosrowlist = <TargetOsRowModel>[];
    var response = await http.get(url);
    if (response.statusCode == 200) {
      trgosrowlist.clear();
      var ors = json.decode(response.body);
      for (var ordjson in ors) {
        trgosrowlist.add(TargetOsRowModel.fromJson(ordjson));
      }
    }
    return trgosrowlist;
  }

  @override
  void initState() {
    super.initState();
    _targetchartloaded = false;
    _saleschartloaded = false;
    _oschartloaded = false;
    _trgttype = appData.log_type.toString();
    _trgtid = int.parse(appData.log_smanid.toString());
    _subtitle = appData.log_name.toString();

    if (appData.ispartytrgt == true) {
      _trgttype = "PARTY";
      _trgtid = int.parse(appData.partytrgtid.toString());
      _subtitle = appData.trgtsubtit.toString();
    }

    loaddata();
    targetDataSource = TargetDataSource(targetlist: _targetlist);
    targetSaleDataSource = TargetSaleDataSource(targetsalelist: _targetsalelist);
    targetOsRowDataSource = TargetOsRowDataSource(targetosrow: _targetosRowlist);

    _tabController = TabController(
      length: tablength,
      initialIndex: 1,
      vsync: this,
    )..addListener(() {
        setState(() {
          _curind = _tabController.index;
        });
      });
  }

  loaddata() async {
    print('fetching trgt');
    fetchTarget().then((value) {
      setState(() {
        _targetlist.clear();
        _targetlist.addAll(value);
        targetDataSource = TargetDataSource(targetlist: _targetlist);
      });
    });
    print('fetching sales');
    fetchSales().then((value) {
      setState(() {
        _targetsalelist.clear();
        _targetsalelist.addAll(value);
        targetSaleDataSource = TargetSaleDataSource(targetsalelist: _targetsalelist);
      });
    });
    print('fetching os');
    fetchOutStanding().then((value) {
      setState(() {
        _targetoslist.clear();
        _targetoslist.addAll(value);
      });
    });
    print('fetching os row');
    fetchOutRowStanding().then((value) {
      setState(() {
        _targetosRowlist.clear();
        _targetosRowlist.addAll(value);
        targetOsRowDataSource = TargetOsRowDataSource(targetosrow: _targetosRowlist);
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _curind = _tabController.index;
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: Colors.blueGrey.withOpacity(0.5), //GFColors.getGFColor(GFColor.dark),
        title: GFSegmentTabs(
          tabController: _tabController,
          tabBarColor: tCardLightColor.withOpacity(0.5),
          labelColor: tPrimaryColor,
          unselectedLabelColor: tWhiteColor,
          unselectedLabelStyle: const TextStyle(),
          labelStyle: tabtextstyle,
          indicator: const BoxDecoration(
            color: Colors.black12,
          ),
          indicatorPadding: const EdgeInsets.all(4.0),
          indicatorWeight: 2.0,
          width: 350,
          border: Border.all(color: Colors.white, width: 2.0),
          //initialIndex: 0,
          length: appData.ispartytrgt == false ? 3 : 1,
          tabs: <Widget>[
            const Text(
              "Target",
            ),
            appData.ispartytrgt == false
                ? const Text(
                    "Sales ",
                  )
                : const Text(''),
            appData.ispartytrgt == false
                ? const Text(
                    "O/S",
                  )
                : const Text('')
          ],
        ),
        actions: <Widget>[
          GFIconButton(
            icon: const Icon(Icons.refresh, color: tPrimaryColor),
            onPressed: () {
              loaddata();
            },
            type: GFButtonType.transparent,
          ),
        ],
      ),
      body: GFTabBarView(controller: _tabController, children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: _targetchartloaded
                        ? HighCharts(
                            loader: const SizedBox(
                              width: 200,
                              child: LinearProgressIndicator(),
                            ),
                            size: const Size(400, 400),
                            data: _chart_target,
                            scripts: const [
                              "https://code.highcharts.com/highcharts.js",
                              'https://code.highcharts.com/modules/networkgraph.js',
                              'https://code.highcharts.com/modules/exporting.js',
                            ],
                          )
                        : Text(
                            'Target vs Acheivement',
                            style: hdrcaptionstyle,
                          )),
                //_listtrgheader(),
                _targetchartloaded
                    ? SizedBox(height: 275, child: Card(child: _ShowTarget()))
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No Data to Show',
                          style: TextStyle(
                            color: Get.isDarkMode ? tWhiteColor : tPrimaryColor,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
              ]),
            ),
          ),
        ),
        appData.ispartytrgt == false
            ? AspectRatio(
                aspectRatio: 1,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: _saleschartloaded
                                ? HighCharts(
                                    loader: const SizedBox(
                                      width: 200,
                                      child: LinearProgressIndicator(),
                                    ),
                                    size: const Size(400, 400),
                                    data: _chart_sales,
                                    scripts: const [
                                      "https://code.highcharts.com/highcharts.js",
                                      'https://code.highcharts.com/modules/networkgraph.js',
                                      'https://code.highcharts.com/modules/exporting.js',
                                    ],
                                  )
                                : Text(
                                    'Sales Chart',
                                    style: hdrcaptionstyle,
                                  )),
                        //_listsalheader(),
                        _saleschartloaded
                            ? SizedBox(height: 275, child: Card(child: _ShowSales()))
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No Data to Show',
                                  style: TextStyle(
                                    color: Get.isDarkMode ? tWhiteColor : tPrimaryColor,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              )
            : const Text(''),
        appData.ispartytrgt == false
            ? AspectRatio(
                aspectRatio: 1,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  color: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: _oschartloaded
                                ? HighCharts(
                                    loader: const SizedBox(
                                      width: 200,
                                      child: LinearProgressIndicator(),
                                    ),
                                    size: const Size(400, 400),
                                    data: _chart_os,
                                    scripts: const [
                                      "https://code.highcharts.com/highcharts.js",
                                      'https://code.highcharts.com/modules/networkgraph.js',
                                      'https://code.highcharts.com/modules/exporting.js',
                                    ],
                                  )
                                : Text(
                                    'Outstanding',
                                    style: hdrcaptionstyle,
                                  )),
                        _oschartloaded
                            ? SizedBox(
                                height: 275,
                                child: Card(child: _ShowOS()),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'No Data to Show',
                                  style: TextStyle(
                                    color: Get.isDarkMode ? tWhiteColor : tPrimaryColor,
                                    fontSize: 24,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              )
            : const Text(''),
      ]),
    );
  }

  Widget _ShowTarget() {
    return SfDataGrid(
      source: targetDataSource,
      isScrollbarAlwaysShown: true,
      columnWidthMode: ColumnWidthMode.auto,
      gridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'trgdesc',
          label: Container(
              padding: const EdgeInsets.all(8.0), alignment: Alignment.centerLeft, child: const Text('Name')),
        ),
        /*GridTextColumn(
          mappingName: 'trgdesc',
          softWrap: true,
          headerText: 'Name',
        ),*/
        GridColumn(columnName: 'trgval', label: const Text('Target'), allowSorting: true),
        /*
        GridNumericColumn(
          mappingName: 'trgval',
          headerText: 'Target',
          allowSorting: true,
        ),*/
        GridColumn(columnName: 'achval', label: const Text('Achieved'), allowSorting: true),
        /*
        GridNumericColumn(
          mappingName: 'achval',
          headerText: 'Achieved',
          allowSorting: true,
        ),*/
        GridColumn(columnName: 'trgpcn', label: const Text('%'), allowSorting: true),
        /*
        GridNumericColumn(
          mappingName: 'trgpcn',
          headerText: '%',
          allowSorting: true,
        ),*/
        GridColumn(columnName: 'trginc', label: const Text('Incentive'), allowSorting: true),
        /*
        GridNumericColumn(
          mappingName: 'trginc',
          headerText: 'Incentive',
          allowSorting: true,
        )*/
      ],
    );
  }

  Widget _ShowSales() {
    return SfDataGrid(
      source: targetSaleDataSource,
      columnWidthMode: ColumnWidthMode.auto,
      gridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      columns: <GridColumn>[
        GridColumn(
          columnName: 'acyear',
          label: const Text('A/C Year'),
        ),
        /*
        GridTextColumn(
            mappingName: 'acyear', headerText: 'A/C Year', allowSorting: true),
         */
        GridColumn(
          columnName: 'companynm',
          label: const Text('Company'),
        ),
        /*
        GridTextColumn(
            mappingName: 'companynm',
            headerText: 'Company',
            allowSorting: true),
         */
        GridColumn(columnName: 'salesyesterday', label: const Text('Yesterday')),
        /*
        GridNumericColumn(
            mappingName: 'salesyesterday',
            headerText: 'Yesterday',
            allowSorting: true),
         */
        GridColumn(columnName: 'salesmtd', label: const Text('MTD')),
        /*
        GridNumericColumn(
            mappingName: 'salesmtd', headerText: 'MTD', allowSorting: true),
         */
        GridColumn(columnName: 'salesytd', label: const Text('YTD')),
        /*
        GridNumericColumn(
            mappingName: 'salesytd', headerText: 'YTD', allowSorting: true)
         */
      ],
    );
    /*ListView.builder(
          itemCount: _targetsalelist.length,
          itemBuilder: (context, index) {
            return _listItemSales(index);
          },
        );*/
  }

  Widget _ShowOS() {
    return SfDataGrid(
      source: targetOsRowDataSource,
      columnWidthMode: ColumnWidthMode.auto,
      gridLinesVisibility: GridLinesVisibility.both,
      allowSorting: true,
      columns: <GridColumn>[
        GridColumn(columnName: 'tran_desc', label: const Text('Book')),
        GridColumn(columnName: 'daystr', label: const Text('Days')),
        GridColumn(columnName: 'dayamt', label: const Text('Amount')),
        GridColumn(columnName: 'daybills', label: const Text('Bills')),
        /*
        GridTextColumn(
            mappingName: 'tran_desc', headerText: 'Book', allowSorting: true),
        GridTextColumn(
            mappingName: 'daystr', headerText: 'Days', allowSorting: true),
        GridNumericColumn(
            mappingName: 'dayamt', headerText: 'Amount', allowSorting: true),
        GridNumericColumn(
            mappingName: 'daybills', headerText: 'Bills', allowSorting: true),
         */
      ],
    );
    /*ListView.builder(
          itemCount: _targetosRowlist.length,
          itemBuilder: (context, index) {
            return _listItemOs(index);
          },
        ); */
  }
}

class TargetModel {
  final String trgdesc;
  final String trgunit;
  final double trgval;
  final double achval;
  final double trgpcn;
  final double trginc;
  final String trgmax;

  TargetModel({
    required this.trgdesc,
    required this.trgunit,
    required this.trgval,
    required this.achval,
    required this.trgpcn,
    required this.trgmax,
    required this.trginc,
  });

  factory TargetModel.fromJson(Map<String, dynamic> json) {
    return TargetModel(
      trgdesc: json['TARGET_DESC'],
      trgunit: json['TARGET_UNIT'],
      trgval: json['TARGET'] is int ? (json['TARGET'] as int).toDouble() : json['TARGET'],
      achval: json['ACHIEVED'] is int ? (json['ACHIEVED'] as int).toDouble() : json['ACHIEVED'],
      trgpcn: json['ACHIEVED_PAGE'],
      trgmax:
          json['MAX_TARGET'] is int ? (json['MAX_TARGET'] as int).toString() : json['MAX_TARGET'],
      trginc:
          json['PAYOUT_AMT'] is int ? (json['PAYOUT_AMT'] as int).toString() : json['PAYOUT_AMT'],
    );
  }
}

class TargetSalesModel {
  final String acyear;
  final String companynm;
  final double salesytd;
  final double salesmtd;
  final double salesyesterday;
  TargetSalesModel(
      {required this.acyear,
      required this.companynm,
      required this.salesytd,
      required this.salesmtd,
      required this.salesyesterday});

  factory TargetSalesModel.fromJson(Map<String, dynamic> json) {
    return TargetSalesModel(
      acyear: json['AC_YEAR'],
      companynm: json['COMPANY_NM'],
      salesytd:
          json['SALES_YTD'] is int ? (json['SALES_YTD'] as int).toDouble() : json['SALES_YTD'],
      salesmtd:
          json['SALES_MTD'] is int ? (json['SALES_MTD'] as int).toDouble() : json['SALES_MTD'],
      salesyesterday: json['SALES_YESTERDAY'] is int
          ? (json['SALES_YESTERDAY'] as int).toDouble()
          : json['SALES_YESTERDAY'],
    );
  }
}

class TargetOsModel {
  final String ac_year;
  final String tran_desc;
  final double total_amount;
  final int total_bills;
  final double total_unadj_cr_amt;
  final double total_unadj_cr_entry;
  final double age_amount_1;
  final int age_bills_1;
  final String age_desc_1;
  final double age_amount_2;
  final int age_bills_2;
  final String age_desc_2;
  final double age_amount_3;
  final int age_bills_3;
  final String age_desc_3;
  final double age_amount_4;
  final int age_bills_4;
  final String age_desc_4;
  final double age_amount_5;
  final int age_bills_5;
  final String age_desc_5;

  TargetOsModel({
    required this.ac_year,
    required this.tran_desc,
    required this.total_amount,
    required this.total_bills,
    required this.total_unadj_cr_amt,
    required this.total_unadj_cr_entry,
    required this.age_amount_1,
    required this.age_bills_1,
    required this.age_desc_1,
    required this.age_amount_2,
    required this.age_bills_2,
    required this.age_desc_2,
    required this.age_amount_3,
    required this.age_bills_3,
    required this.age_desc_3,
    required this.age_amount_4,
    required this.age_bills_4,
    required this.age_desc_4,
    required this.age_amount_5,
    required this.age_bills_5,
    required this.age_desc_5,
  });

  factory TargetOsModel.fromJson(Map<String, dynamic> json) {
    return TargetOsModel(
      ac_year: json['AC_YEAR'],
      tran_desc: json['TRAN_DESC'],
      total_amount: json['TOTAL_AMOUNT'] is int
          ? (json['TOTAL_AMOUNT'] as int).toDouble()
          : json['TOTAL_AMOUNT'],
      total_bills: json['TOTAL_BILLS'],
      total_unadj_cr_amt: json['TOTAL_UNADJ_CR_AMT'] is int
          ? (json['TOTAL_UNADJ_CR_AMT'] as int).toDouble()
          : json['TOTAL_UNADJ_CR_AMT'],
      total_unadj_cr_entry: json['TOTAL_UNADJ_CR_ENTRY'] is int
          ? (json['TOTAL_UNADJ_CR_ENTRY'] as int).toDouble()
          : json['TOTAL_UNADJ_CR_ENTRY'],
      age_amount_1: json['AGE_AMOUNT_1'] is int
          ? (json['AGE_AMOUNT_1'] as int).toDouble()
          : json['AGE_AMOUNT_1'],
      age_bills_1: json['AGE_BILLS_1'],
      age_amount_2: json['AGE_AMOUNT_2'] is int
          ? (json['AGE_AMOUNT_2'] as int).toDouble()
          : json['AGE_AMOUNT_2'],
      age_bills_2: json['AGE_BILLS_2'],
      age_amount_3: json['AGE_AMOUNT_3'] is int
          ? (json['AGE_AMOUNT_3'] as int).toDouble()
          : json['AGE_AMOUNT_3'],
      age_bills_3: json['AGE_BILLS_3'],
      age_amount_4: json['AGE_AMOUNT_4'] is int
          ? (json['AGE_AMOUNT_4'] as int).toDouble()
          : json['AGE_AMOUNT_4'],
      age_bills_4: json['AGE_BILLS_4'],
      age_amount_5: json['AGE_AMOUNT_5'] is int
          ? (json['AGE_AMOUNT_5'] as int).toDouble()
          : json['AGE_AMOUNT_5'],
      age_bills_5: json['AGE_BILLS_5'],
      age_desc_2: '',
      age_desc_4: '',
      age_desc_5: '',
      age_desc_3: '',
      age_desc_1: '',
    );
  }
}

class TargetOsRowModel {
  final String tran_desc;
  final String daystr;
  final double dayamt;
  final int daybills;

  TargetOsRowModel({
    required this.tran_desc,
    required this.daystr,
    required this.dayamt,
    required this.daybills,
  });

  factory TargetOsRowModel.fromJson(Map<String, dynamic> json) {
    return TargetOsRowModel(
      tran_desc: json['TRAN_DESC'],
      daystr: json['AGE_DESC'],
      dayamt: json['AMOUNT'] is int ? (json['AMOUNT'] as int).toDouble() : json['AMOUNT'],
      daybills: json['BILLS'],
    );
  }
}

class TargetDataSource extends DataGridSource {
  TargetDataSource({required List<TargetModel> targetlist}) {
    _targetlist = targetlist
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'trgdesc', value: e.trgdesc.toString()),
              DataGridCell<double>(columnName: 'trgval', value: e.trgval),
              DataGridCell<double>(columnName: 'achval', value: e.achval),
              DataGridCell<double>(columnName: 'trgpcn', value: e.trgpcn),
              DataGridCell<double>(columnName: 'trginc', value: e.trginc),
            ]))
        .toList();
  }
  List<DataGridRow> _targetlist = [];

  @override
  List<DataGridRow> get rows => _targetlist;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment:
            (dataGridCell.columnName == 'trgdesc') ? Alignment.centerLeft : Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class TargetSaleDataSource extends DataGridSource {
  TargetSaleDataSource({required List<TargetSalesModel> targetsalelist}) {
    _targetsalelist = targetsalelist
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'acyear', value: e.acyear),
              DataGridCell<String>(columnName: 'companynm', value: e.companynm),
              DataGridCell<double>(columnName: 'salesyesterday', value: e.salesyesterday),
              DataGridCell<double>(columnName: 'salesmtd', value: e.salesmtd),
              DataGridCell<double>(columnName: 'salesytd', value: e.salesytd),
            ]))
        .toList();
  }
  List<DataGridRow> _targetsalelist = [];

  @override
  List<DataGridRow> get rows => _targetsalelist;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'acyear' || dataGridCell.columnName == 'companynm')
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}

class TargetOsRowDataSource extends DataGridSource {
  TargetOsRowDataSource({required List<TargetOsRowModel> targetosrow}) {
    _targetosrow = targetosrow
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'tran_desc', value: e.tran_desc),
              DataGridCell<String>(columnName: 'daystr', value: e.daystr),
              DataGridCell<double>(columnName: 'dayamt', value: e.dayamt),
              DataGridCell<int>(columnName: 'daybills', value: e.daybills),
            ]))
        .toList();
  }
  List<DataGridRow> _targetosrow = [];

  @override
  List<DataGridRow> get rows => _targetosrow;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'acyear' || dataGridCell.columnName == 'companynm')
            ? Alignment.centerLeft
            : Alignment.centerRight,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
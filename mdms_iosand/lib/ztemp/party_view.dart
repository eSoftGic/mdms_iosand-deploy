// ignore_for_file: library_private_types_in_public_api, unused_label, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:mdms_iosand/src/constants/colors.dart';
import 'package:mdms_iosand/src/features/core/screens/party/home_list/party_filter.dart';
import 'package:unique_list/unique_list.dart';

class Party extends StatefulWidget {
  const Party({super.key});

  @override
  _PartyState createState() => _PartyState();
}

class _PartyState extends State<Party> {
  final List<PartyModel> _prtlist = <PartyModel>[];
  List<PartyModel> _prtlistforDisplay = <PartyModel>[];
  List<PartyModel> _prtfiltlist = <PartyModel>[];

  bool isloading = true;
  String stkrs = "";
  final int _lckedt = appSecure.editac == false ? 1 : 0;
  final int _lcknac = appSecure.addac == false ? 1 : 0;

  Future<List<PartyModel>> fetchParty() async {
    int rtwis = appData.sortbyroute == true ? 1 : 0;

    if (appData.log_type != "PARTY") {
      appData.prtid = 0;
    }
    var qryparam = "DbName=${appData.log_dbnm!}&Branch_Id=${appData.log_branchid.toString().trim()}&BEAT_ID_STR=${appData.log_smnbeat!}&ac_id=${appData.prtid}&Bill_Iss_no=${appData.billissno.toString().trim()}&Route_Sr_Wise=$rtwis&Order_Status=${appData.filtordnm}&SmanId=${appData.log_smanid}";

    var url = Uri.parse("${appData.baseurl!}party_list?$qryparam");
    print(url);
    var response = await http.get(url);
    isloading = true;
    var prtlist = <PartyModel>[];
    if (response.statusCode == 200) {
      var prt = json.decode(response.body);
      for (var prtjson in prt) {
        prtlist.add(PartyModel.fromJson(prtjson));
      }
    }
    return prtlist;
  }

  @override
  void initState() {
    super.initState();
    appData.filtordnm = 'ALL';
    refreshdata();
    List<String> betlist = _prtlist.map((t) => t.beatnm!).toList();
    appData.allbeat = UniqueList<String>.from(betlist);
    List<String> clslist = _prtlist.map((t) => t.classnm!).toList();
    appData.allclass = UniqueList<String>.from(clslist);
    List<String> typlist = _prtlist.map((t) => t.typenm!).toList();
    appData.alltype = UniqueList<String>.from(typlist);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          AddButton(context),
          RefreshButton(context),
        ],
        title: const Text(
          'Party',
          style: TextStyle(
            color: tPrimaryColor,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      body: Column(
        children: <Widget>[_searchBar(), isloading ? _showprogress() : _showList()],
      ),
    );
  }

  Widget _showList() {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _prtlistforDisplay.length,
        itemBuilder: (context, index) {
          return _listItem(index);
        },
      ),
    );
  }

  setfilter(String text) {
    print(text);
    setState(() {
      _prtfiltlist = _prtlist;
      if (text.isNotEmpty) {
        //print(' Before Filter Applited ' + _prtfiltlist.length.toString());
        if (appData.filtbeat.isNotEmpty) {
          _prtfiltlist = _prtfiltlist.where((prt) {
            String betnm = prt.beatnm!;
            return appData.filtbeat.contains(betnm);
          }).toList();
        }
        if (appData.filtclass.isNotEmpty) {
          _prtfiltlist = _prtfiltlist.where((prt) {
            String clsnm = prt.classnm!;
            return appData.filtclass.contains(clsnm);
          }).toList();
        }
        if (appData.filttype.isNotEmpty) {
          _prtfiltlist = _prtfiltlist.where((prt) {
            String typenm = prt.typenm!;
            return appData.filttype.contains(typenm);
          }).toList();
        }
        //print(' After Filter Applited ' + _prtfiltlist.length.toString());
        if (appSecure.namecontains == true) {
          _prtfiltlist = _prtfiltlist.where((prt) {
            return prt.ac_nm!.toLowerCase().contains(text);
          }).toList();
        } else {
          _prtfiltlist = _prtfiltlist.where((prt) {
            return prt.ac_nm!.toLowerCase().startsWith(text, 0);
          }).toList();
        }
        //print(' After Search Applited ' + _prtfiltlist.length.toString());
      }
    });
    setState(() {
      _prtlistforDisplay = _prtfiltlist;
      _showList();
    });
  }

  refreshdata() {
    isloading = true;
    _prtlist.clear();
    fetchParty().then((value) {
      //print('refreshdata called');
      setState(() {
        _prtlist.addAll(value);
        _prtlistforDisplay = _prtlist;
        isloading = false;
      });
    });
  }

  FilterWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 45.0,
        width: 30.0,
        child: GestureDetector(
          onTap: () {
            highlightColor:
            Colors.deepOrangeAccent;
          },
          child: Stack(
            children: <Widget>[
              IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    color: tPrimaryColor,
                    size: 24,
                  ),
                  onPressed: () {
                    Get.to(() => const PartyFilter());
                  }),
              Positioned(
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.brightness_1, size: 24.0, color: tAccentColor.withOpacity(0.5)),
                    Positioned(
                      top: 2.0,
                      right: 5.5,
                      child: Center(
                        child: Text(
                          (appData.filtbeat.length +
                                  appData.filttype.length +
                                  appData.filtclass.length)
                              .toString(),
                          style: const TextStyle(
                              color: tPrimaryColor, fontSize: 160, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FloatingButton(BuildContext context) {
    return FloatingActionButton.extended(
        onPressed: () {
          /*  Navigator.push(
              context, MaterialPageRoute(builder: (context) => AccountMst()));*/
        },
        backgroundColor: Colors.deepOrangeAccent,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Party',
          style: TextStyle(fontSize: 16.0),
        ));
  }

  _showprogress() {
    //return Loader();
    return const Center(
      child: SizedBox(
        height: 20.0,
        width: 20.0,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.lightBlue), strokeWidth: 3.0),
      ),
    );
  }

  _searchBar() {
    String srchint = 'Search..';
    if (appSecure.namecontains!) {
      srchint += ' contains';
    } else {
      srchint += ' starts with';
    }
    return Card(
        color: tWhiteColor,
        elevation: 1.0,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(hintText: srchint),
                    style: const TextStyle(fontSize: 18.0, color: Colors.black87),
                    onChanged: (text) {
                      setState(() {
                        setfilter(text.toLowerCase().trim());
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  _prtlistforDisplay.length.toString(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: tPrimaryColor),
                ),
                FilterWidget(),
              ],
            )));
  }

  _listItem(index) {
    return ListTile(
        title: Card(
            color: Colors.grey.shade100,
            elevation: 1.0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 12,
                        child: Text(
                          _prtlistforDisplay[index].ac_nm!,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 10,
                        child: Text(
                          _prtlistforDisplay[index].beatnm!,
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          "${_prtlistforDisplay[index].classnm!}/${_prtlistforDisplay[index].typenm!}",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        _prtlistforDisplay[index].sale_type.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _prtlistforDisplay[index].routeSr ?? '-'.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      IconButton(
                          icon: const Icon(Icons.edit),
                          color: tCardBgColor,
                          iconSize: 20.0,
                          onPressed: () {
                            appData.acmstid = _prtlistforDisplay[index].ac_id;
                            appData.acmstnm = _prtlistforDisplay[index].ac_nm;
                            if (_lckedt == 0) {
                              /*var route = MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyFormPage());
                              Navigator.of(context).push(route);*/
                            } else {
                              _showAlert('Not Authorised', 'To Edit Party');
                            }
                          }),
                      IconButton(
                          icon: const Icon(Icons.show_chart),
                          color: tCardBgColor,
                          iconSize: 24.0,
                          onPressed: () {
                            appData.ispartytrgt = true;
                            appData.partytrgtid = _prtlistforDisplay[index].ac_id;
                            appData.trgtsubtit =
                                appData.trgtsubtit = _prtlistforDisplay[index].ac_nm;

                            /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Target()));*/
                          })
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          _prtlistforDisplay[index].addr.toString(),
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        _prtlistforDisplay[index].mobile!,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          _prtlistforDisplay[index].ordstatus!.toString(),
                          softWrap: true,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        _prtlistforDisplay[index].orddetail!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        onTap: () {
          appData.prtid = _prtlistforDisplay[index].ac_id;
          appData.prtnm = _prtlistforDisplay[index].ac_nm;
          appData.saletype = _prtlistforDisplay[index].sale_type;
          appData.chainofstores = false;
          appData.chainid = 0;
          appData.chainnm = "";
          if (_prtlistforDisplay[index].anychain != null) {
            appData.chainofstores = _prtlistforDisplay[index].anychain;
          }
          /*var route = MaterialPageRoute(
              builder: (BuildContext context) => PartyTabBar());
          Navigator.of(context).push(route);*/
        });
  }

  /*
  _showDialog(int ind) {
    showDialog(
        barrierDismissible: false,
        context: context,
        child: CupertinoAlertDialog(
          title: Column(
            children: <Widget>[
              Icon(
                Icons.person_outline,
                color: Colors.lightBlue,
              )
            ],
          ),
          content: Text(
            _prtlistforDisplay[ind].ac_nm,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                appData.acmstid = 0;
                appData.acmstnm = '';
                var route = MaterialPageRoute(
                  builder: (BuildContext context) => PartyTabBar(),
                );
                Navigator.of(context).push(route);
                //Navigator.of(context).pop();
              },
              child: Text('Details'),
            )
          ],
        ));
  }
  */

  AddButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.add),
        color: tPrimaryColor,
        iconSize: 30.0,
        onPressed: () {
          appData.acmstid = 0;
          appData.acmstnm = '';
          if (_lcknac == 0) {
            /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyFormPage(),
                ));*/
          } else {
            _showAlert('Not Authorised', 'To Add New A/C');
          }
        });
  }

  RefreshButton(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.refresh),
        color: tPrimaryColor,
        iconSize: 30.0,
        onPressed: () {
          print('refreshed init called');
          refreshdata();
        });
  }

  _showAlert(title, text) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(text),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

class PartyModel {
  //Define
  final int? ac_id;
  final String? ac_nm;
  final String? mobile;
  final String? beatnm;
  final int? branch_id;
  final String? sale_type;
  final bool? anychain;
  final String? classnm;
  final String? typenm;
  final String? addr;
  final String? routeSr;
  final String? ordstatus;
  final String? orddetail;

  // Constructutor
  PartyModel(
      {this.ac_id,
      this.ac_nm,
      this.mobile,
      this.beatnm,
      this.branch_id,
      this.sale_type,
      this.anychain,
      this.classnm,
      this.typenm,
      this.addr,
      this.routeSr,
      this.ordstatus,
      this.orddetail});

  //Maping
  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
        ac_id: json['AC_ID'],
        ac_nm: json['AC_NM'],
        mobile: json['MOBILE_NO'],
        beatnm: json['BEAT_NM'],
        branch_id: json['BRANCH_ID'],
        sale_type: json['SALE_TYPE'],
        anychain: json['ANY_CHAIN'],
        classnm: json['AC_CLASS_NM'],
        typenm: json['AC_TYPE_NM'],
        addr: json['ADDR'],
        routeSr: json['ROUTE_SR'],
        ordstatus: json['ORDER_STATUS'],
        orddetail: json['ORDER_DETAIL']);
  }
}
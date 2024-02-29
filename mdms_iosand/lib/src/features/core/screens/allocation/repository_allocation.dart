// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/foundation.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/model_allocation.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';

class AllocationRepository {
  final _apiService = NetworkApiServices();

  Future<List<AllocationModel>> allocateApi(String cmpstr, String itmstr, String prtstr) async {
    if (appData.log_type == 'PARTY') {
      prtstr = appData.log_dlrid!.toString();
    }
    var qryparam = "DbName=" +
        appData.log_dbnm! +
        "&COMPANY_ID_STR=" +
        cmpstr +
        "&ITEM_ID_STR=" +
        itmstr +
        "&PARTY_ID_STR=" +
        prtstr +
        "&CHAIN_ID_STR=0" +
        "&REF_NO=0";
    var aloclst = <AllocationModel>[];
    var resdata = await _apiService.getApi(AppUrl.allocateUrl + qryparam);
    if (resdata != null) {
      for (var resjson in resdata) {
        if (kDebugMode) {
          print(resjson.toString());
        }
        aloclst.add(AllocationModel.fromJson(resjson as Map<String, dynamic>));
      }
    }
    if (kDebugMode) {
      print('alloc len ' + aloclst.length.toString());
    }
    return aloclst;
  }
}
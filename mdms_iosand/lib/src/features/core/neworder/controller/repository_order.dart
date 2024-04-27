import 'package:flutter/material.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_book.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_chain.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_quot.dart';

import '../../../../../singletons/AppData.dart';
import '../../models/company_model.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';
import 'model_order.dart';

class OrderRepository {
  final _apiService = NetworkApiServices();

  Future<List<OrderModel>> orderListApi(int acid) async {
    
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!; }

    final String ordersummqryparam =
        "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&chain_id=0&Branch_Id=${appData.log_branchid.toString().trim()}&SmanId=${appData.log_smanid.toString().trim()}&User_Type_Code=${appData.log_type.toString().trim()}&tran_type=ORD&User_Type_Code=${appData.log_type.toString().trim()}";

    var ordlist = <OrderModel>[];
    var resdata = await _apiService.getApi(AppUrl.ordersummaryListUrl + ordersummqryparam);
    if (resdata != null) {
      debugPrint('res data ${resdata.toString()}');
      
      for (var ordjson in resdata) {
        ordlist.add(OrderModel.fromJson(ordjson as Map<String, dynamic>));
      }
    }
    return ordlist;
  }

  Future<List<BookModel>> bookListApi(int acid) async {
    var qryparam = '';
    if (appData.log_forbuk!.isNotEmpty) {
      qryparam =
          "DbName=${appData.log_dbnm!}&TRAN_TYPE=SAL&Branch_Id=${appData.log_branchid.toString().trim()}&ac_id=${acid.toString().trim()}&forcmp=${appData.log_smncomp.toString().trim()}&forbook=${appData.log_forbuk!}&ordtype=${appData.ordqottype!}";
    } else {
      qryparam =
          "DbName=${appData.log_dbnm!}&TRAN_TYPE=SAL&Branch_Id=${appData.log_branchid.toString().trim()}&ac_id=${acid.toString().trim()}&forcmp=${appData.log_smncomp.toString().trim()}&ordtype=${appData.ordqottype!}";
    }
    var buklist = <BookModel>[];
    var resdata = await _apiService.getApi(AppUrl.bookListUrl + qryparam);
    if (resdata != null) {
      for (var bukjson in resdata) {
        buklist.add(BookModel.fromJson(bukjson as Map<String, dynamic>));
      }
    }
    return buklist;
  }

  Future<List<ChainModel>> cosListApi(int acid) async {
    var qryparam =
        "DbName=${appData.log_dbnm!}&acid=$acid&Branch_Id=${appData.log_branchid.toString().trim()}";

    var coslist = <ChainModel>[];
    var resdata = await _apiService.getApi(AppUrl.cosListUrl + qryparam);
    if (resdata != null) {
      for (var cosjson in resdata) {
        coslist.add(ChainModel.fromJson(cosjson as Map<String, dynamic>));
      }
    }
    return coslist;
  }

  Future<List<CompanyModel>> cmpListApi() async {
    var qryparam =
        "DbName=${appData.log_dbnm!}&Branch_Id=${appData.log_branchid.toString().trim()}";
    //print('buk cmp str ' + appData.bukcmpstr.toString());
    if (appData.bukcmpstr.toString().isNotEmpty) {
      qryparam += "&CmpStr=${appData.bukcmpstr.toString().trim()}";
    }
    var cmplist = <CompanyModel>[];
    var resdata = await _apiService.getApi(AppUrl.cmpListUrl + qryparam);

    if (resdata != null) {
      for (var cmpjson in resdata) {
        cmplist.add(CompanyModel.fromJson(cmpjson as Map<String, dynamic>));
      }
    }
    return cmplist;
  }

  Future<List<QotData>> qotdatalist() async {
    String qryparam =
        "DbName=${appData.log_dbnm!}&ref_no=${appData.ordrefno.toString().trim()}&tran_type=${appData.ordqottype!}&tran_type_id=${appData.bukid}&ac_id=0&chain_id=0&user_id=${appData.log_id.toString().trim()}&branch_id=${appData.log_branchid.toString().trim()}&sman_id=${appData.log_smanid.toString().trim()}&sr_no=-1";

    var qotlist = <QotData>[];
    var resdata = await _apiService.getApi(AppUrl.getqotnoUrl + qryparam);
    if (resdata != null) {
      for (var qotjson in resdata) {
        qotlist.add(QotData.fromJson(qotjson as Map<String, dynamic>));
      }
    }
    return qotlist;
  }
}

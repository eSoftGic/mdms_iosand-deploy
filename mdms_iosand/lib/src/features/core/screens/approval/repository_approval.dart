// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:mdms_iosand/src/features/core/neworder/controller/model_order.dart';

import '../../../../../singletons/AppData.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';


class ApprovalRepository {
  final _apiService = NetworkApiServices();
  Future<List<OrderModel>> approvalListApi(int acid) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!;
    }
    final String approvalsummqryparam = "DbName=" +
        appData.log_dbnm! +
        "&AcId=" +
        acid.toString().trim() +
        "&chain_id=0" +
        "&Branch_Id=" +
        appData.log_branchid.toString().trim() +
        "&SmanId=" +
        appData.log_smanid.toString().trim() +
        "&User_Type_Code=" +
        appData.log_type.toString().trim() +
        "&tran_type=ORD&User_Type_Code=" +
        appData.log_type.toString().trim();

    var ordlist = <OrderModel>[];
    var resdata = await _apiService.getApi(AppUrl.ordersummaryListUrl + approvalsummqryparam);
    if (resdata != null) {
      for (var ordjson in resdata) {
        ordlist.add(OrderModel.fromJson(ordjson as Map<String, dynamic>));
      }
    }
    return ordlist;
  }
}
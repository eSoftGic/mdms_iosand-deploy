// ignore_for_file: avoid_print

import '../../../../../singletons/AppData.dart';
import '../../features/core/network/app_url.dart';
import '../../features/core/network/network_api_service.dart';
import '../models/ecomm_model.dart';

class ItemRepository {
  final _apiService = NetworkApiServices();

  final String itemlistqryparam = "DbName=${appData.log_dbnm!}&Branch_Id=${appData.log_branchid.toString().trim()}&Company_Id_Str=1&tran_type_id=1&ref_no=0&ac_id=241&chain_id=${appData.chainid}&user_id=${appData.log_id}";

  final String withmaxstr =
      ((appData.ordrefno)! > 0 && appData.prtid! > 0) ? "&WITH_MAX_ORD_AMT=true" : "";

  Future<List<ItemModel>> itemListApi() async {
    var itmlist = <ItemModel>[];
    var resdata = await _apiService.getApi(AppUrl.itmListUrl + itemlistqryparam + withmaxstr);
    if (resdata != null) {
      print('res data$resdata');
      for (var itmjson in resdata) {
        itmlist.add(ItemModel.fromJson(itmjson as Map<String, dynamic>));
      }
    }
    //print(itmlist);
    return itmlist;
  }
}
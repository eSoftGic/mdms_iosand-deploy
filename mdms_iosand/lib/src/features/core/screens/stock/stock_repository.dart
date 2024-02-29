// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'package:mdms_iosand/src/features/core/screens/stock/stock_model.dart';
import '../../../../../singletons/AppData.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';

class StockRepository {
  final _apiService = NetworkApiServices();

  final String stocklistqryparam =
      "DbName=${appData.log_dbnm!}&Branch_Id=${appData.log_branchid.toString().trim()}&COMPANY_ID_STR=${appData.log_smncomp.toString().trim()}";

  Future<List<StockModel>> stockListApi(int imgcnt) async {
    String imgstr = "&Image_Cnt_Reqd=" + imgcnt.toString().trim();

    var stklist = <StockModel>[];
    var resdata = await _apiService
        .getApi(AppUrl.stockListUrl + stocklistqryparam + imgstr);
    if (resdata != null) {
      print('res data$resdata');
      for (var stkjson in resdata) {
        stklist.add(StockModel.fromJson(stkjson as Map<String, dynamic>));
      }
    }
    return stklist;
  }
}

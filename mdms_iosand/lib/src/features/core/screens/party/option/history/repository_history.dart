import 'package:mdms_iosand/src/features/core/screens/party/option/history/model_history.dart';

import '../../../../../../../singletons/AppData.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';

class OrderHistoryRepository {
  final _apiService = NetworkApiServices();

  Future<List<OrdHistoryModel>> prtordhisApi(
      String acid, String fdt, int topNRec) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!.toString();
    }
    var qryparam =
        "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&chain_id=0&Branch_Id=0&fdt=$fdt&Smanid=${appData.log_smanid.toString().trim()}&tran_type=ORD&User_Type_Code=${appData.log_type.toString().trim()}&Top_N_Rec=${topNRec.toString().trim()}";

    var hislist = <OrdHistoryModel>[];
    var resdata = await _apiService.getApi(AppUrl.acmsthistoryUrl + qryparam);
    if (resdata != null) {
      for (var hisjson in resdata) {
        hislist.add(OrdHistoryModel.fromJson(hisjson as Map<String, dynamic>));
      }
    }
    return hislist;
  }
}

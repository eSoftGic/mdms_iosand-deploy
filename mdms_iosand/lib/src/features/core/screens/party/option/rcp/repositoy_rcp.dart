import 'package:mdms_iosand/src/features/core/screens/party/option/rcp/model_rcp.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';

class PartyRcpRepository {
  final _apiService = NetworkApiServices();

  Future<List<PrtRcpModel>> prtRcpApi(String acid) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!.toString();
    }
    var qryparam = "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&user_id=${appData.log_id.toString().trim()}";

    var rcplist = <PrtRcpModel>[];
    var resdata = await _apiService.getApi(AppUrl.acmstrcpUrl + qryparam);
    if (resdata != null) {
      for (var rcpjson in resdata) {
        rcplist.add(PrtRcpModel.fromJson(rcpjson as Map<String, dynamic>));
      }
    }
    return rcplist;
  }
}
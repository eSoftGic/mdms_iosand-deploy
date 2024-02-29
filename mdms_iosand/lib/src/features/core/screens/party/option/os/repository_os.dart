import 'package:mdms_iosand/src/features/core/models/Prtos_model.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';

class PartyOsRepository {
  final _apiService = NetworkApiServices();

  Future<List<PrtOs>> prtosApi(String acid) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!.toString();
    }
    String demostr = appData.demover == true ? "true" : "false";
    var qryparam = "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&Demo=$demostr&Bill_Iss_No=${appData.billissno.toString().trim()}";
    var oslist = <PrtOs>[];
    var resdata = await _apiService.getApi(AppUrl.acmstosUrl + qryparam);
    if (resdata != null) {
      for (var osjson in resdata) {
        oslist.add(PrtOs.fromJson(osjson as Map<String, dynamic>));
      }
    }
    return oslist;
  }

  Future<List<PrtOs>> prtUnCrnApi(String acid) async {
    String demostr = appData.demover == true ? "true" : "false";
    var qryparam =
        "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&Demo=$demostr";
    var oslist = <PrtOs>[];
    var resdata = await _apiService.getApi(AppUrl.acmstuncrnUrl + qryparam);
    if (resdata != null) {
      for (var osjson in resdata) {
        oslist.add(PrtOs.fromJson(osjson as Map<String, dynamic>));
      }
    }
    return oslist;
  }
}
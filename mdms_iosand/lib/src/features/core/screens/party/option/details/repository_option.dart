import '../../../../../../../singletons/AppData.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';
import 'model_acmstdetail.dart';

class PartyOptionRepository {
  final _apiService = NetworkApiServices();

  Future<List<AcMstDetail>> acmstApi(int acid) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!;
    }
    final String acmstqryparam =
        "DbName=${appData.log_dbnm!}&ACId=${acid.toString().trim()}&Branch_Id=${appData.log_branchid.toString().trim()}&Bill_Iss_No=${appData.billissno.toString().trim()}";
    var prtlist = <AcMstDetail>[];
    var resdata =
        await _apiService.getApi(AppUrl.acmstdetailUrl + acmstqryparam);
    if (resdata != null) {
      for (var prtjson in resdata) {
        prtlist.add(AcMstDetail.fromJson(prtjson as Map<String, dynamic>));
      }
    }
    return prtlist;
  }
}

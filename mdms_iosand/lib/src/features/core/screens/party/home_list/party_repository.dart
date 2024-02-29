import '../../../../../../singletons/singletons.dart';
import '../../../models/party/party_model.dart';
import '../../../network/app_url.dart';
import '../../../network/network_api_service.dart';

class PartyRepository {
  final _apiService = NetworkApiServices();
  Future<List<PartyModel>> partyListApi(int acid) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!;
    }
    final String partylistqryparam =
        "DbName=${appData.log_dbnm}&Branch_Id=${appData.log_branchid.toString().trim()}&BEAT_ID_STR=${appData.log_smnbeat}&ac_id=$acid&Bill_Iss_no=${appData.billissno.toString().trim()}&Route_Sr_Wise=${appData.sortbyroute ? 1 : 0}&Order_Status=${appData.filtordnm}&SmanId=${appData.log_smanid}";
    var prtlist = <PartyModel>[];
    var resdata =
        await _apiService.getApi(AppUrl.partyListUrl + partylistqryparam);
    if (resdata != null) {
      for (var prtjson in resdata) {
        prtlist.add(PartyModel.fromJson(prtjson as Map<String, dynamic>));
      }
    }
    return prtlist;
  }
}

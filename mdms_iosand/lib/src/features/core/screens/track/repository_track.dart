import 'package:mdms_iosand/src/features/core/screens/track/model_track.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';

class TrackRepository {
  final _apiService = NetworkApiServices();

  Future<List<TrackModel>> trackApi(String trantype, String refno) async {
    var qryparam = "DbName=${appData.log_dbnm!}&Branch_id=${appData.log_branchid.toString().trim()}&AcId=0&chain_id=0&Smain_id=${appData.log_smanid.toString().trim()}&tran_type=$trantype&ref_no=${refno.toString().trim()}";

    var trklst = <TrackModel>[];
    var resdata = await _apiService.getApi(AppUrl.trackUrl + qryparam);
    if (resdata != null) {
      for (var resjson in resdata) {
        trklst.add(TrackModel.fromJson(resjson as Map<String, dynamic>));
      }
    }
    return trklst;
  }
}
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings
import 'package:mdms_iosand/src/features/core/screens/os/os_model.dart';
import '../../../../../singletons/AppData.dart';
import '../../network/app_url.dart';
import '../../network/network_api_service.dart';

class OsRepository {
  final _apiService = NetworkApiServices();
  final String oslistqryparam =
      "DbName=${appData.log_dbnm!}&ACId=0&BEAT_ID_STR=${appData.log_smnbeat!}&Demo=${appData.demover.toString()}&Bill_Iss_No=${appData.billissno!.toString().trim()}";

  Future<List<OsTotalModel>> osListApi() async {
    var oslist = <OsTotalModel>[];

    var resdata = await _apiService.getApi(AppUrl.osListUrl + oslistqryparam);
    if (resdata != null) {
      print('res data$resdata');
      for (var osjson in resdata) {
        oslist.add(OsTotalModel.fromJson(osjson as Map<String, dynamic>));
      }
    }
    return oslist;
  }
}

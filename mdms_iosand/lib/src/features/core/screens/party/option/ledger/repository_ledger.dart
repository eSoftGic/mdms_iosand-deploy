// ignore_for_file: avoid_print

import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/model_ledger.dart';
import '../../../../../../../singletons/AppData.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';

class PartyLedgerRepository {
  final _apiService = NetworkApiServices();

  Future<List<LedgerModel>> prtlgrApi(String acid, String fdt, String tdt, String srtad) async {
    if (appData.log_type == 'PARTY') {
      acid = appData.log_dlrid!.toString();
    }
    String demostr = appData.demover == true ? "true" : "false";
    var qryparam = "DbName=${appData.log_dbnm!}&AcId=${acid.toString().trim()}&Demo=$demostr&Fdt=$fdt&Tdt=$tdt&OrderBy=$srtad";
    print(AppUrl.acmstledgerUrl + qryparam);

    var grllist = <LedgerModel>[];
    var resdata = await _apiService.getApi(AppUrl.acmstledgerUrl + qryparam);
    if (resdata != null) {
      for (var grljson in resdata) {
        grllist.add(LedgerModel.fromJson(grljson as Map<String, dynamic>));
      }
    }
    return grllist;
  }
}
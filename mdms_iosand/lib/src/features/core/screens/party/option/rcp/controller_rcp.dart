// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/rcp/repositoy_rcp.dart';
import '../../../../network/status.dart';
import 'model_rcp.dart';

class PartyRcpController extends GetxController {
  final _api = PartyRcpRepository();
  RxInt rcplen = 0.obs;
  RxString error = ''.obs;
  String rcpacid = '0';
  RxString rcptot = ''.obs;

  final RxRequestStatus = Status.LOADING.obs;
  final rcplist = <PrtRcpModel>[].obs;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;

  void setRcpList(List<PrtRcpModel> value) {
    rcplist.value = value.toList();
    rcplen.value = rcplist.length;
    /*  var values = rcplist.map((f) => (f.netamt! - f.rcvdamt!));
    rcptot.value = (values.reduce((sum, element) => sum + element)).toDouble().toStringAsFixed(2);*/
  }

  void prtRcpApi() async {
    await _api.prtRcpApi(rcpacid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setRcpList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;

  void setclearrcp() {
    rcplist.value.clear();
    rcptot.value = '';
  }

  void setrcpacid(int val) {
    rcpacid = val.toString();
  }
}
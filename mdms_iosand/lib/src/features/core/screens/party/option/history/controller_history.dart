// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/history/repository_history.dart';
import '../../../../network/status.dart';
import 'model_history.dart';

class OrderHistoryController extends GetxController {
  final _api = OrderHistoryRepository();

  RxInt hislen = 0.obs;
  RxString error = ''.obs;
  RxString fdt = ''.obs;
  RxInt top10 = 0.obs;
  String hisacid = '0';
  String fdtstr = '';

  final RxRequestStatus = Status.LOADING.obs;
  final hislist = <OrdHistoryModel>[].obs;

  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;

  void setHisList(List<OrdHistoryModel> value) {
    hislist.value = value.toList();
    hislen.value = hislist.length;
  }

  void setTop10(int val) {
    top10.value = val;
  }

  void prtOrdHisApi() async {
    await _api.prtordhisApi(hisacid, fdtstr, top10.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setHisList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void sethisacid(int val) {
    hisacid = val.toString();
  }

  void setfdt(String fdate) {
    fdtstr = fdate.toString().trim();
  }

  void setclearhis() {
    hislist.value.clear();
  }

  void setError(String value) => error.value = value;
}
// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/models/Prtos_model.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/os/repository_os.dart';
import '../../../../network/status.dart';

class PartyOsController extends GetxController {
  final _api = PartyOsRepository();

  RxInt oslen = 0.obs;
  RxString error = ''.obs;
  String osacid = '0';
  RxString ostot = ''.obs;

  final RxRequestStatus = Status.LOADING.obs;
  final oslist = <PrtOs>[].obs;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;

  void setOsList(List<PrtOs> value) async {
    oslist.value = value.toList();
    oslen.value = oslist.length;
    var values = oslist.map((f) => (f.netamt! - f.rcvdamt!));
    ostot.value = (values.reduce((sum, element) => sum + element)).toDouble().toStringAsFixed(2);
  }

  void prtOsApi() async {
    await _api.prtosApi(osacid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setOsList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
  void setclearos() {
    oslist.value.clear();
    ostot.value = '';
  }

  void setosacid(int val) {
    osacid = val.toString();
  }
}
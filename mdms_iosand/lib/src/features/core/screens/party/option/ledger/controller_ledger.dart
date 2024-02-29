// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/model_ledger.dart';
import 'package:mdms_iosand/src/features/core/screens/party/option/ledger/repository_ledger.dart';
import '../../../../network/status.dart';

class PartyLedgerController extends GetxController {
  final _api = PartyLedgerRepository();
  RxInt grllen = 0.obs;
  RxString error = ''.obs;
  RxString fdt = ''.obs;
  RxString tdt = ''.obs;
  RxString srtad = ''.obs;
  String grlacid = '0';
  String fdtstr = '';
  String tdtstr = '';
  String sortad = 'A';
  RxString dbtot = ''.obs;
  RxString crtot = ''.obs;
  RxString clbal = ''.obs;
  RxBool srtdesc = false.obs;

  final RxRequestStatus = Status.LOADING.obs;
  final grllist = <LedgerModel>[].obs;

  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setGrlList(List<LedgerModel> value) {
    grllist.value = value.toList();
    grllen.value = grllist.length;
    var dbvalues = grllist.map((f) => (f.dbamt));
    dbtot.value =
        (dbvalues.reduce((sum, element) => sum! + element!))!.toDouble().toStringAsFixed(2);
    var crvalues = grllist.map((f) => (f.cramt));
    crtot.value =
        (crvalues.reduce((sum, element) => sum! + element!))!.toDouble().toStringAsFixed(2);
    var clvalues = grllist.map((f) => (f.cramt! - f.dbamt!));
    clbal.value = (clvalues.reduce((sum, element) => sum + element)).toDouble().toStringAsFixed(2);
  }

  void prtGrlApi() async {
    await _api.prtlgrApi(grlacid, fdtstr, tdtstr, sortad).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setGrlList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setgrlacid(int val) {
    grlacid = val.toString();
  }

  void setfdt(String fdate) {
    fdtstr = fdate.toString().trim();
  }

  void settdt(String tdate) {
    tdtstr = tdate.toString().trim();
  }

  void setsordad(bool srt) {
    srtdesc.value = srt;
    sortad = srtdesc.value == true ? 'D' : 'A';
  }

  void setcleargrl() {
    grllist.value.clear();
    dbtot.value = '';
    crtot.value = '';
    clbal.value = '';
  }

  void setError(String value) => error.value = value;
}
// ignore_for_file: avoid_print

import 'package:get/get.dart';
import '../../../../../../singletons/AppData.dart';

class PreBookEditController extends GetxController {
  RxInt ordrefno = 0.obs;
  RxString buknm = ''.obs;
  RxString bukid = ''.obs;
  RxString acnm = ''.obs;
  RxInt acid = 0.obs;
  RxBool todayorder = true.obs;
  RxInt chainid = 0.obs;
  RxBool ordlimitvalid = true.obs;
  RxString bukcmpstr = ''.obs;
  RxDouble ordmaxlimit = 0.0.obs;
  RxBool iscrdlimitover = false.obs;
  RxDouble plat = 0.0.obs;
  RxDouble plon = 0.0.obs;
  RxString ordqottype = 'ORD'.obs;
  bool istelephonicorder = false;
  RxString chainnm = ''.obs;
  RxBool costore = false.obs;
  RxString saletype = ''.obs;
  RxBool hascostores = false.obs;

  void setOrdrefno(int value) => ordrefno.value = value;
  void setAcid(int value) => acid.value = value;
  void setAcnm(String value) => acnm.value = value;
  void setBukid(String value) => bukid.value = value;
  void setBuknm(String value) => buknm.value = value;
  void setSaleType(String value) => saletype.value = value;
  void setTodayorder(bool value) {
    todayorder.value = value;
  }

  void setOrderRecord() {
    print('setting order record from order home');
    setAcid(int.parse(appData.prtid.toString()));
    setAcnm(appData.prtnm.toString());
    setOrdrefno(int.parse(appData.ordrefno.toString()));
    setBukid(appData.bukid.toString());
    bukcmpstr.value = appData.bukcmpstr.toString();
    setBuknm(appData.buknm.toString());
    chainid.value = int.parse(appData.chainid.toString());
    chainnm.value = appData.chainnm.toString();
    saletype.value = appData.saletype.toString();
    ordqottype.value = appData.ordqottype.toString();
    ordmaxlimit.value = appData.ordmaxlimit!;
    ordlimitvalid.value = appData.ordlimitvalid!;
  }
}
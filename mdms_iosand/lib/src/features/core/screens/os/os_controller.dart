// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/os/os_model.dart';
import 'package:mdms_iosand/src/features/core/screens/os/os_repository.dart';
import '../../../../../singletons/singletons.dart';
import '../../network/status.dart';

class OsController extends GetxController {
  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();

  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  RxDouble stockRs = 0.0.obs;

  final _api = OsRepository();

  List<OsTotalModel> _fulllist = <OsTotalModel>[];
  final reslist = <OsTotalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ListApi();
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setFullList(List<OsTotalModel> value) async {
    _fulllist = value.toList();
    lislen.value = _fulllist.length;
  }

  void setOsList(List<OsTotalModel> value) {
    reslist.value = value.toList();
    lislen.value = reslist.length;
    /*var stkrs = _value.map((f) => f.net_avail_amount ?? 0);
    stockRs =
        (stkrs.reduce((sum, element) => sum + element)).toDouble().toStringAsFixed(2) as RxDouble;*/
  }

  void applyfilters(String text) async {
    //print(text);
    List<OsTotalModel> osfiltlist = _fulllist;
    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        osfiltlist = osfiltlist.where((rec) {
          return rec.acnm!.toLowerCase().contains(text.toLowerCase());
        }).toList();
      } else {
        osfiltlist = osfiltlist.where((rec) {
          return rec.acnm!.startsWith(text.toLowerCase(), 0);
        }).toList();
      }
    }
    reslist.value = osfiltlist;
    lislen.value = reslist.value.length;
  }

  void ListApi() {
    _api.osListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setOsList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.osListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setOsList(value);
      filterlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }
}

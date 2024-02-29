// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/stock/stock_model.dart';
import 'package:mdms_iosand/src/features/core/screens/stock/stock_repository.dart';
import 'package:unique_list/unique_list.dart';
import '../../../../../singletons/singletons.dart';
import '../../network/status.dart';

class StockController extends GetxController {
  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();

  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  RxDouble stockRs = 0.0.obs;
  RxBool withimg = false.obs;

  final _api = StockRepository();

  List<StockModel> _fulllist = <StockModel>[];
  final reslist = <StockModel>[].obs;
  final itemImagelist = [].obs;

  @override
  void onInit() {
    super.onInit();
    ListApi();
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setFullList(List<StockModel> value) async {
    _fulllist = value.toList();
    lislen.value = _fulllist.length;
    loadfiltervalues();
  }

  void setStockList(List<StockModel> value) {
    reslist.value = value.toList();
    lislen.value = reslist.length;
    /*var stkrs = _value.map((f) => f.net_avail_amount ?? 0);
    stockRs =
        (stkrs.reduce((sum, element) => sum + element)).toDouble().toStringAsFixed(2) as RxDouble;*/
  }

  void applyfilters(String text) async {
    //print(text);
    List<StockModel> stkfiltlist = _fulllist;
    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        stkfiltlist = stkfiltlist.where((rec) {
          return rec.item_nm.toLowerCase().contains(text.toLowerCase());
        }).toList();
      } else {
        stkfiltlist = stkfiltlist.where((rec) {
          return rec.item_nm.toLowerCase().startsWith(text.toLowerCase(), 0);
        }).toList();
      }
    }
    //print('filter list ' + _stkfiltlist.length.toString());
    if (appData.filtcompany.isNotEmpty) {
      print(appData.filtcompany.toString());
      stkfiltlist = stkfiltlist.where((rec) {
        String cmpnm = rec.company_nm;
        return appData.filtcompany.contains(cmpnm);
      }).toList();
    }
    if (appData.filtcategory.isNotEmpty) {
      stkfiltlist = stkfiltlist.where((rec) {
        String catnm = rec.item_cat_nm;
        return appData.filtcategory.contains(catnm);
      }).toList();
    }
    if (appData.filtbrand.isNotEmpty) {
      stkfiltlist = stkfiltlist.where((rec) {
        String brndnm = rec.item_brand_nm;
        return appData.filtbrand.contains(brndnm);
      }).toList();
    }
    reslist.value = stkfiltlist;
    lislen.value = reslist.value.length;
  }

  void setItemImageList(String itemCode) async {}

  void ListApi() {
    int imgcnt = 0;
    if (withimg.value == true) {
      imgcnt = 1;
    }
    _api.stockListApi(imgcnt).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setStockList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshListApi() {
    int imgcnt = 0;
    if (withimg.value == true) {
      imgcnt = 1;
    }
    appData.filtcompany = [];
    appData.filtcategory = [];
    appData.filtbrand = [];
    appData.applystkfilter = false;

    setRxRequestStatus(Status.LOADING);
    _api.stockListApi(imgcnt).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setStockList(value);
      filterlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadfiltervalues() async {
    if (_fulllist.isNotEmpty) {
      appData.allcomp = UniqueList<String>.from(
          _fulllist.map((t) => t.company_nm.toLowerCase()).toList());
      appData.allcategory = UniqueList<String>.from(
          _fulllist.map((t) => t.item_cat_nm.toLowerCase()).toList());
      appData.allbrand = UniqueList<String>.from(
          _fulllist.map((t) => t.item_brand_nm.toLowerCase()).toList());
    }
  }
}

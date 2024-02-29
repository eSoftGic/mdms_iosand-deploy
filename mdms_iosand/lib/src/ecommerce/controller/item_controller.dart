// ignore_for_file: avoid_print, invalid_use_of_protected_member, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/repository/item_repositoy.dart';
import 'package:unique_list/unique_list.dart';
import '../../../../../singletons/singletons.dart';
import '../../features/core/network/status.dart';
import '../models/ecomm_model.dart';

class ItemController extends GetxController {
  final rxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();

  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  final _api = ItemRepository();

  List<ItemModel> _fulllist = <ItemModel>[];
  final reslist = <ItemModel>[].obs;
  final itemImagelist = [].obs;

  @override
  void onInit() {
    super.onInit();
    ItemListApi();
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setFullList(List<ItemModel> value) async {
    _fulllist = value.toList();
    lislen.value = _fulllist.length;
    loadfiltervalues();
  }

  void setItemList(List<ItemModel> value) {
    reslist.value = value.toList();
    lislen.value = reslist.length;
  }

  void applyfilters(String text) async {
    //print(text);
    List<ItemModel> itmfiltlist = _fulllist;
    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        itmfiltlist = itmfiltlist.where((rec) {
          return rec.item_nm!.toLowerCase().contains(text);
        }).toList();
      } else {
        itmfiltlist = itmfiltlist.where((rec) {
          return rec.item_nm!.toLowerCase().startsWith(text, 0);
        }).toList();
      }
    }
    if (appData.filtcompany.isNotEmpty) {
      print(appData.filtcompany.toString());
      itmfiltlist = itmfiltlist.where((rec) {
        String cmpnm = rec.company_nm!;
        return appData.filtcompany.contains(cmpnm);
      }).toList();
    }
    if (appData.filtcategory.isNotEmpty) {
      itmfiltlist = itmfiltlist.where((rec) {
        String catnm = rec.item_cat_nm!;
        return appData.filtcategory.contains(catnm);
      }).toList();
    }
    if (appData.filtbrand.isNotEmpty) {
      itmfiltlist = itmfiltlist.where((rec) {
        String brndnm = rec.item_brand_nm!;
        return appData.filtbrand.contains(brndnm);
      }).toList();
    }
    reslist.value = itmfiltlist;
    lislen.value = reslist.value.length;
  }

  void ItemListApi() {
    _api.itemListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setItemList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshListApi() {
    appData.filtcompany = [];
    appData.filtcategory = [];
    appData.filtbrand = [];
    appData.applystkfilter = false;

    setRxRequestStatus(Status.LOADING);
    _api.itemListApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setItemList(value);
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
          _fulllist.map((t) => t.company_nm!).toList());
      appData.allcategory = UniqueList<String>.from(
          _fulllist.map((t) => t.item_cat_nm!).toList());
      appData.allbrand = UniqueList<String>.from(
          _fulllist.map((t) => t.item_brand_nm!).toList());
    }
  }
}

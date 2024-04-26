// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/repository_orderitem.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_item.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/controller_prebookbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/add/controller_prebookcart.dart';
import 'package:unique_list/unique_list.dart';
import '../../../../../../../singletons/singletons.dart';
import '../../../network/status.dart';


class PreBookItemController extends GetxController {
  final ordbasiccontroller = Get.put(PreBookBasicController());
  //final editcontroller = Get.put(OrderEditController());
  final ordcartcontroller = Get.put(PreBookCartController());

  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();
  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  final _api = OrderItemRepository();
  var ordchoice = "ADD";
  var trantype = "PREBK";
  int imgcnt = 0;

  void setImgcnt(bool val) {
    imgcnt = val ? 1 : 0;
  }

  void setTrantype(String value) {
    trantype = value;
  }

  void setOrdChoice(String value) {
    ordchoice = value == "EDIT" ? "EDIT" : "ADD";
    update();
    print(ordchoice);
    if (ordchoice == 'EDIT') {
      refreshListApi();
    }
  }

  List<ItemModel> _fulllist = <ItemModel>[];

  final reslist = <ItemModel>[].obs;
  final itemImagelist = [].obs;
  RxInt Curitmid = 0.obs;
  RxString Curitmnm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ItemListApi(ordchoice, trantype);
  }

  @override
  void onReady() {
    super.onReady();
    if (reslist.value.isEmpty) {
      ItemListApi(ordchoice, trantype);
    }
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setRxCurItem(int index) {
    Curitmid.value = reslist[index].tbl_id!;
    Curitmnm.value = reslist[index].item_nm!;
  }

  void setFullList(List<ItemModel> value) async {
    searchtxt.text = "";
    _fulllist = value.toList();
    lislen.value = _fulllist.length;
    /*
    print(editcontroller.ordrefno.value.toString());
    if (editcontroller.ordrefno.value > 0 && _fulllist.length > 0) {
      setOrderCartlist(editcontroller.ordrefno.value);
    }
    */
    loadfiltervalues();
  }

  void setOrderCartlist(int ordno) async {
    List<ItemModel> crtitemlist = _fulllist.where((rec) {
      return (rec.ord_los_qty! > 0 || rec.ord_qty! > 0);
    }).toList();
    if (crtitemlist.isNotEmpty) {
      print('total cart list $crtitemlist');
      ordcartcontroller.clearCartlist();
      for (int i = 0; i < crtitemlist.length; i++) {
        double itmrt = crtitemlist[i].rate!;
        double igstp = crtitemlist[i].gst_page!;
        if (appSecure.rtwithtax == 1) {
          itmrt = itmrt / (1 + (igstp * 0.01));
        }
        double igross = roundDouble(
            (crtitemlist[i].ord_qty! * (itmrt / crtitemlist[i].rate_per!)), 2);
        double schp = crtitemlist[i].ord_sch_page ?? 0.0;
        double scha = crtitemlist[i].ord_sch_amt ?? 0.0;
        scha = roundDouble((igross * 0.01 * schp), 2);
        double disp = crtitemlist[i].ord_disc_page ?? 0.0;
        double disa = crtitemlist[i].ord_disc_amt ?? 0.0;
        disa = roundDouble(((igross - scha) * 0.01 * disp), 2);
        double igsta = roundDouble(((igross - scha - disa) * 0.01 * igstp), 2);
        if (appSecure.taxbeforescheme! == true) {
          igsta = (igross * 0.01 * igstp);
        }
        double inet = roundDouble((igross - scha - disa + igsta), 2);
        crtitemlist[i].itmgross = igross;
        crtitemlist[i].ord_sch_amt = scha;
        crtitemlist[i].ord_disc_amt = disa;
        crtitemlist[i].gstamt = igsta;
        crtitemlist[i].itemnet = inet;

        ordcartcontroller.addtoCartlist(crtitemlist[i]);
      }
    }
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

  void ItemListApi(String ordchoice, String trantype) {
    _api.itemListApi(ordchoice, trantype,imgcnt).then((value) {
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
    _api.itemListApi(ordchoice, trantype,imgcnt).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setItemList(value);
      print(reslist.value.length);
      filterlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadfiltervalues() async {
    if (_fulllist.isNotEmpty) {
      appData.allcomp =
          UniqueList<String>.from(_fulllist.map((t) => t.company_nm!).toList());
      appData.allcategory = UniqueList<String>.from(
          _fulllist.map((t) => t.item_cat_nm!).toList());
      appData.allbrand = UniqueList<String>.from(
          _fulllist.map((t) => t.item_brand_nm!).toList());
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}

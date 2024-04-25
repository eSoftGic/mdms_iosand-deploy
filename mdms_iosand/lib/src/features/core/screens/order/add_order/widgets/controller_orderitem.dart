// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, prefer_is_empty, invalid_use_of_protected_member, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_cart.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/screens/order/add_order/widgets/repository_orderitem.dart';
import 'package:unique_list/unique_list.dart';
import '../../../../../../../singletons/singletons.dart';
import '../../../../network/status.dart';
import '../../edit_order/controller_orderedit.dart';
import '../model_item.dart';

class OrderItemController extends GetxController {
  final ordbasiccontroller = Get.put(OrderBasicController());
  final editcontroller = Get.put(OrderEditController());
  final ordcartcontroller = Get.put(OrderCartController());

  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();
  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  final _api = OrderItemRepository();
  var ordchoice = "ADD";
  var trantype = "ORD";
  RxBool shwimg = false.obs;
  RxInt imgcnt = 0.obs;
  RxInt Curitmid = 0.obs;
  RxString Curitmnm = ''.obs;

  List<ItemModel> _fulllist = <ItemModel>[];

  final orditmlist = <ItemModel>[].obs;
  final reslist = <ItemModel>[].obs;
  final itemImagelist = [].obs;

  void setImgcnt(int val) {
    imgcnt.value = val;
  }

  void setShwimg(bool val) {
    shwimg.value = val;
    setImgcnt(val == true ? 1 : 0);
  }

  void setTrantype(String _value) {
    trantype = _value;
  }

  void setOrdChoice(String _value) {
    ordchoice = _value == "EDIT" ? "EDIT" : "ADD";
    update();
    if (kDebugMode) {
      print('Order Choice $ordchoice');
    }
    refreshListApi();
  }

  @override
  void onInit() {
    super.onInit();
    ItemListApi(ordchoice, trantype, imgcnt.value);
  }

  /*@override
  void onReady() {
    super.onReady();
    ItemListApi(ordchoice, trantype, imgcnt.value);
  }*/

  void setError(String _value) => error.value = _value;
  void setRxRequestStatus(Status _value) => RxRequestStatus.value = _value;

  void setRxCurItem(int index) {
    Curitmid.value = reslist[index].tbl_id!;
    Curitmnm.value = reslist[index].item_nm!;
    debugPrint(Curitmid.value.toString());
    debugPrint(Curitmnm.value.toString());
  }

  void ItemListApi(String ordchoice, String trantype, int imgcnt) {
    debugPrint('itemlistapi ' + ordchoice + ' ' + trantype);
    _api.itemListApi(ordchoice, trantype, imgcnt).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      //debugPrint(value.toString());
      setFullList(value.toList());
      setItemList(value);
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
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
    _api.itemListApi(ordchoice, trantype, imgcnt.value).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setItemList(value);
      debugPrint(reslist.value.length.toString());
      filterlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setFullList(List<ItemModel> _value) async {
    searchtxt.text = "";
    _fulllist = _value;
    lislen.value = _value.length;

    debugPrint('controller ordno ' + editcontroller.ordrefno.value.toString());
    debugPrint('setFulllist cnt ' + _value.length.toString());
    debugPrint('orditmlist cnt ' + orditmlist.value.length.toString());

    if (editcontroller.ordrefno.value > 0 && _value.length > 0) {
      orditmlist.value = _value.toList();
      if (ordcartcontroller.cartlist.length == 0) {
        debugPrint('setting order cart list for ' +
            editcontroller.ordrefno.value.toString());
        setOrderCartlist(editcontroller.ordrefno.value);
      }
    }
    loadfiltervalues();
  }

  void setOrderCartlist(int ordno) async {
    List<ItemModel> _crtitemlist = _fulllist.where((rec) {
      return (rec.ord_los_qty! > 0 || rec.ord_qty! > 0);
    }).toList();

    // this is for view only
    orditmlist.value = _crtitemlist.toList();
    debugPrint('for view only ' + orditmlist.value.length.toString());

    if (_crtitemlist.length > 0) {
      print('total cart list ' + _crtitemlist.toString());
      print('total ord view list ' + orditmlist.value.length.toString());
      ordcartcontroller.clearCartlist();
      for (int i = 0; i < _crtitemlist.length; i++) {
        double itmrt = _crtitemlist[i].rate!;
        double igstp = _crtitemlist[i].gst_page!;
        if (appSecure.rtwithtax == 1) {
          itmrt = itmrt / (1 + (igstp * 0.01));
        }
        double igross = roundDouble(
            (_crtitemlist[i].ord_qty! * (itmrt / _crtitemlist[i].rate_per!)),
            2);
        double schp = _crtitemlist[i].ord_sch_page ?? 0.0;
        double scha = _crtitemlist[i].ord_sch_amt ?? 0.0;
        scha = roundDouble((igross * 0.01 * schp), 2);
        double disp = _crtitemlist[i].ord_disc_page ?? 0.0;
        double disa = _crtitemlist[i].ord_disc_amt ?? 0.0;
        disa = roundDouble(((igross - scha) * 0.01 * disp), 2);
        double igsta = roundDouble(((igross - scha - disa) * 0.01 * igstp), 2);
        if (appSecure.taxbeforescheme! == true) {
          igsta = (igross * 0.01 * igstp);
        }
        double inet = roundDouble((igross - scha - disa + igsta), 2);
        _crtitemlist[i].itmgross = igross;
        _crtitemlist[i].ord_sch_amt = scha;
        _crtitemlist[i].ord_disc_amt = disa;
        _crtitemlist[i].gstamt = igsta;
        _crtitemlist[i].itemnet = inet;
        ordcartcontroller.addtoCartlist(_crtitemlist[i]);
      }
    }
  }

  void setItemList(List<ItemModel> _value) {
    debugPrint('setItemList Call' + _value.length.toString());
    reslist.value = _value.toList();
    lislen.value = reslist.length;
  }

  void applyfilters(String text) async {
    //print(text);
    List<ItemModel> _itmfiltlist = _fulllist;

    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        _itmfiltlist = _itmfiltlist.where((rec) {
          return rec.item_nm!.toLowerCase().contains(text.toLowerCase());
        }).toList();
      } else {
        _itmfiltlist = _itmfiltlist.where((rec) {
          return rec.item_nm!.toLowerCase().startsWith(text, 0);
        }).toList();
      }
    }

    if (appData.filtcompany.isNotEmpty) {
      print(appData.filtcompany.toString());
      _itmfiltlist = _itmfiltlist.where((rec) {
        String cmpnm = rec.company_nm!;
        return appData.filtcompany.contains(cmpnm);
      }).toList();
    }
    if (appData.filtcategory.isNotEmpty) {
      _itmfiltlist = _itmfiltlist.where((rec) {
        String catnm = rec.item_cat_nm!;
        return appData.filtcategory.contains(catnm);
      }).toList();
    }
    if (appData.filtbrand.isNotEmpty) {
      _itmfiltlist = _itmfiltlist.where((rec) {
        String brndnm = rec.item_brand_nm!;
        return appData.filtbrand.contains(brndnm);
      }).toList();
    }
    reslist.value = _itmfiltlist;
    lislen.value = reslist.value.length;
  }

  void loadfiltervalues() async {
    if (_fulllist.length > 0) {
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

  // For Individual Items Calculations
}

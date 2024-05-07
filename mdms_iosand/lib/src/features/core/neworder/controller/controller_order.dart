// ignore_for_file: non_constant_identifier_names, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import '../../../../../singletons/singletons.dart';
import '../../network/status.dart';
import 'model_order.dart';
import 'repository_order.dart';

class OrderController extends GetxController {
  final ordbasiccontroller = Get.put(OrderBasicController());
  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();
  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  RxDouble stockRs = 0.0.obs;
  int ordforacid = 0;
  final currentOrder = <OrderModel>[].obs;
  RxInt ordrefno = 0.obs;

  final _api = OrderRepository();
  List<OrderModel> _fulllist = <OrderModel>[];
  final reslist = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ListApi();
  }

  void setOrdrefno(int _val) => ordrefno.value = _val;

  void setOrdforacid(int _val) => ordforacid = _val;

  void setError(String _value) => error.value = _value;
  void setRxRequestStatus(Status _value) => RxRequestStatus.value = _value;
  void setFullList(List<OrderModel> _value) async {
    _fulllist = _value.toList();
    lislen.value = _fulllist.length;
    //loadfiltervalues();
  }

  void setOrdBillList(String opt) async {
    switch (opt) {
      case 'apprvpend':
        {
          reslist.value = _fulllist.where((rec) {
            return rec.approvalstatus!.toString().trim().toLowerCase() ==
                'pending'.toLowerCase();
          }).toList();
        }
        break;
      case 'billpend':
        {
          reslist.value = _fulllist.where((rec) {
            return rec.billed!.toString().trim().toLowerCase() == 'n' &&
                rec.approvalstatus!.toString().trim().toLowerCase() ==
                    'approved'.toLowerCase();
          }).toList();
        }
        break;
      case 'billed':
        {
          reslist.value = _fulllist.where((rec) {
            return rec.billed!.toString().trim().toLowerCase() == 'y';
          }).toList();
        }
        break;
      case 'noorder':
        {
          reslist.value = _fulllist.where((rec) {
            return rec.noorder!.toString().trim().toLowerCase() ==
                'y'.toLowerCase();
          }).toList();
        }
        break;
      case 'apprvreject':
        {
          reslist.value = _fulllist.where((rec) {
            return rec.approvalstatus!.toString().trim().toLowerCase() ==
                'rejected'.toLowerCase();
          }).toList();
        }
        break;
      default:
        {
          reslist.value = _fulllist.toList();
        }
        break;
    }
    lislen.value = reslist.length;
  }

  void setNoOrdList() async {
    reslist.value = _fulllist.where((rec) {
      return rec.noorder!.toString().trim().toLowerCase() == 'Y';
    }).toList();
    lislen.value = reslist.length;
  }

  void setApprovalStatus(String status) async {
    reslist.value = _fulllist.where((rec) {
      return rec.approvalstatus!.toString().trim().toLowerCase() ==
          status.toString().trim().toLowerCase();
    }).toList();
    lislen.value = reslist.length;
  }

  void setPartyOrderList(int prtid) async {
    ordforacid = prtid;
    update();
    ListApi();
  }

  void setOrderList(List<OrderModel> _value) {
    reslist.value = _value.toList();
    //reslist.value.sort((a,b) => a['ref_no'].compareTo(b['ref_no']));
    lislen.value = reslist.length;
  }

  void applyfilters(String text) async {
    List<OrderModel> _ordfiltlist = _fulllist;
    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        _ordfiltlist = _ordfiltlist.where((rec) {
          return rec.ac_nm!.toLowerCase().contains(text);
        }).toList();
      } else {
        _ordfiltlist = _ordfiltlist.where((rec) {
          return rec.ac_nm!.toLowerCase().startsWith(text, 0);
        }).toList();
      }
    }
    reslist.value = _ordfiltlist;
    lislen.value = reslist.value.length;
  }

  void ListApi() {
    _api.orderListApi(ordforacid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setOrderList(value);
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void refreshListApi() {
    setRxRequestStatus(Status.LOADING);
    _api.orderListApi(ordforacid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setFullList(value);
      setOrderList(value);
      filterlen.value = value.length;
    }).onError((error, stackTrace) {
      print(error.toString());
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setSingleOrderDetail(int orefno) async {
    currentOrder.value = _fulllist.where((rec) {
      return rec.ref_no == orefno;
    }).toList();
  }
}

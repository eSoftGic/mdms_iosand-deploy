// ignore_for_file: invalid_use_of_protected_member, non_constant_identifier_names, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/home/model_prebook.dart';
import 'package:mdms_iosand/src/features/core/screens/prebook/home/repository_prebook.dart';

import '../../../../../../singletons/appsecure.dart';
import '../../../network/status.dart';

class PrebookController extends GetxController {
  //final ordbasiccontroller = Get.put(OrderBasicController());

  final RxRequestStatus = Status.LOADING.obs;
  final searchtxt = TextEditingController();
  RxString error = ''.obs;
  RxInt lislen = 0.obs;
  RxInt filterlen = 0.obs;
  RxDouble stockRs = 0.0.obs;
  int ordforacid = 0;

  final _api = PreBookRepository();
  List<PreBookModel> _fulllist = <PreBookModel>[];
  final reslist = <PreBookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ListApi();
  }

  void setError(String value) => error.value = value;
  void setRxRequestStatus(Status value) => RxRequestStatus.value = value;
  void setFullList(List<PreBookModel> value) async {
    _fulllist = value.toList();
    lislen.value = _fulllist.length;
    //loadfiltervalues();
  }

  void setOrdBillList(String yn) async {
    if (yn == 'Y') {
      reslist.value = _fulllist.where((rec) {
        return rec.billed!.toString().trim().toLowerCase() == yn.toLowerCase();
      }).toList();
    } else {
      reslist.value = _fulllist.where((rec) {
        return rec.billed!.toString().trim().toLowerCase() != 'y'.toLowerCase();
      }).toList();
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
    ListApi();
  }

  void setOrderList(List<PreBookModel> value) {
    reslist.value = value.toList();
    //reslist.value.sort((a,b) => a["ref_no"].compareTo(b['ref_no']));
    lislen.value = reslist.length;
  }

  void applyfilters(String text) async {
    List<PreBookModel> ordfiltlist = _fulllist;
    if (text.isNotEmpty) {
      if (appSecure.namecontains == true) {
        ordfiltlist = ordfiltlist.where((rec) {
          return rec.ac_nm!.toLowerCase().contains(text);
        }).toList();
      } else {
        ordfiltlist = ordfiltlist.where((rec) {
          return rec.ac_nm!.toLowerCase().startsWith(text, 0);
        }).toList();
      }
    }
    reslist.value = ordfiltlist;
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

/*void loadfiltervalues() async {
    if (_fulllist.length > 0) {
      appData.allcomp = await UniqueList<String>.from(_fulllist.map((t) => t.company_nm!).toList());
      appData.allcategory =
          await UniqueList<String>.from(_fulllist.map((t) => t.item_cat_nm!).toList());
      appData.allbrand =
          await UniqueList<String>.from(_fulllist.map((t) => t.item_brand_nm!).toList());
    }
  }*/
}
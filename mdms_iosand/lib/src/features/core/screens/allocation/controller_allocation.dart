import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/model_allocation.dart';
import 'package:mdms_iosand/src/features/core/screens/allocation/repository_allocation.dart';
import '../../network/status.dart';

class AllocationController extends GetxController {
  final _api = AllocationRepository();
  RxInt aloclen = 0.obs;
  RxString error = ''.obs;
  final rxRequestStatus = Status.LOADING.obs;
  RxList<AllocationModel> allocationlist = <AllocationModel>[].obs;
  var groupedData = [].obs;
  var grouptype = 'Itemwise'.obs;
  var grp1nm = 'item_nm'.obs;
  var grp2nm = 'ac_nm'.obs;
  var cmpidstr = '';
  var itmidstr = '';
  var prtidstr = '';
  var chnidstr = '';
  var refno = '';

  void setCmpIdstr(String val) {
    cmpidstr = val.toString().trim();
    update();
  }

  void setItmIdstr(String val) {
    itmidstr = val.toString().trim();
    update();
  }

  void setprtIdstr(String val) {
    prtidstr = val.toString().trim();
    update();
  }

  onChangeGroup(var value) {
    grouptype.value = value;
    grp1nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'ac_nm' : 'item_nm';
    grp2nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'item_nm' : 'ac_nm';
  }

  void setRxRequestStatus(Status val) => rxRequestStatus.value = val;

  void setalocList(List<AllocationModel> val) {
    //print(grouptype.value);
    grp1nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'ac_nm' : 'item_nm';
    grp2nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'item_nm' : 'ac_nm';
    // ignore: invalid_use_of_protected_member
    groupedData.value.clear();
    allocationlist.value = val.toList();
    // ignore: invalid_use_of_protected_member
    aloclen.value = allocationlist.value.length;
    setListArray();
    //print(grp1nm.value);
    //print(grp2nm.value);
  }

  void setListArray() {
    // ignore: invalid_use_of_protected_member
    groupedData.value = allocationlist.value.map((e) => e.toJson()).toList();
  }

  void allocApi() async {
    await _api.allocateApi(cmpidstr, itmidstr, prtidstr).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setalocList(value);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setclearaloc() {
    // ignore: invalid_use_of_protected_member
    allocationlist.value.clear();
  }

  void setError(String val) => error.value = val;
}
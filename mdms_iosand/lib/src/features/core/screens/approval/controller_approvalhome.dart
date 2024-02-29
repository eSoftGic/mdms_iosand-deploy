// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers, invalid_use_of_protected_member

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../network/status.dart';
import '../order/model_order.dart';
import '../order/repository_order.dart';

class ApprovalController extends GetxController {
  final _api = OrderRepository();

  RxInt aprvlen = 0.obs;
  RxString error = ''.obs;
  final RxRequestStatus = Status.LOADING.obs;
  RxList<OrderModel> approvlist = <OrderModel>[].obs;
  var groupedData = [].obs;

  var grouptype = 'Statuswise'.obs;
  var grp1nm = 'approvalstatus'.obs;
  var grp2nm = 'ac_nm'.obs;
  int acid = 0;
  onChangeGroup(var value) {
    grouptype.value = value;
    grp1nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'ac_nm' : 'approvalstatus';
    grp2nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'approvalstatus' : 'ac_nm';
  }

  void setRxRequestStatus(Status _value) => RxRequestStatus.value = _value;

  void setapprovList(List<OrderModel> _value) {
    //print(grouptype.value);
    grp1nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'ac_nm' : 'approvalstatus';
    grp2nm.value = grouptype.value.toLowerCase() == 'partywise' ? 'approvalstatus' : 'ac_nm';
    groupedData.value.clear();
    approvlist.value = _value.toList();
    aprvlen.value = approvlist.value.length;
    setListArray();
    //print(grp1nm.value);
    //print(grp2nm.value);
  }

  void setListArray() {
    groupedData.value = approvlist.value.map((e) => e.toJson()).toList();
  }

  void approveApi() async {
    await _api.orderListApi(acid).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setapprovList(value);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      setError(error.toString());
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setclearaloc() {
    approvlist.value.clear();
  }

  void setError(String _value) => error.value = _value;
}
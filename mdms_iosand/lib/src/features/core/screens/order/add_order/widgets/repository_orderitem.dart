// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../singletons/singletons.dart';
import '../../../../network/app_url.dart';
import '../../../../network/network_api_service.dart';
import '../../../prebook/add/controller_prebookbasic.dart';
import '../../edit_order/controller_orderedit.dart';
import '../model_item.dart';
import 'controller_orderbasic.dart';

class OrderItemRepository {
  final _apiService = NetworkApiServices();
  final _controller = Get.put(OrderBasicController());
  final _editcontroller = Get.put(OrderEditController());
  final _pcontroller = Get.put(PreBookBasicController());

  Future<List<ItemModel>> itemListApi(
      String ordchoice, String trantype, int imgcnt) async {
    String itemlistqryparam = "";
    if (trantype == 'PREBK') {
      itemlistqryparam = "DbName=${appData.log_dbnm!}"
              "&Branch_Id=${appData.log_branchid.toString().trim()}"
              "&Company_Id_Str=${_pcontroller.bukcmpstr.value.toString()}"
              "&tran_type_id=${_pcontroller.bukid.value.toString()}"
              "&ref_no=${_pcontroller.ordrefno.value.toString()}"
              "&ac_id=${_pcontroller.acid.value.toString()}"
              "&chain_id=${_pcontroller.chainid.value}"
              "&user_id=${appData.log_id}"
              "&tran_type=" +
          trantype +
          "&Image_Cnt_Reqd=" +
          imgcnt.toString().trim() +
          "&Ordered_Item_Only=0";
    } else {
      if (ordchoice == 'ADD') {
        itemlistqryparam = "DbName=${appData.log_dbnm!}"
                "&Branch_Id=${appData.log_branchid.toString().trim()}"
                "&Company_Id_Str=${_controller.bukcmpstr.value.toString()}"
                "&tran_type_id=${_controller.bukid.value.toString()}"
                "&ref_no=${_controller.ordrefno.value.toString()}"
                "&ac_id=${_controller.acid.value.toString()}"
                "&chain_id=${_controller.chainid.value}"
                "&user_id=${appData.log_id}"
                "&tran_type=" +
            trantype +
            "&Image_Cnt_Reqd=" +
            imgcnt.toString().trim() +
            "&Ordered_Item_Only=0";
      } else {
        itemlistqryparam = "DbName=${appData.log_dbnm!}"
                "&Branch_Id=${appData.log_branchid.toString().trim()}"
                "&Company_Id_Str=${_editcontroller.bukcmpstr.value.toString()}"
                "&tran_type_id=${_editcontroller.bukid.value.toString()}"
                "&ref_no=${_editcontroller.ordrefno.value.toString()}"
                "&ac_id=${_editcontroller.acid.value.toString()}"
                "&chain_id=${_editcontroller.chainid.value}"
                "&user_id=${appData.log_id}"
                "&tran_type=" +
            trantype +
            "&Image_Cnt_Reqd=" +
            imgcnt.toString().trim() +
            "&Ordered_Item_Only=0";
      }
    }

    var itmlist = <ItemModel>[];

    var resdata =
        await _apiService.getApi(AppUrl.itmListUrl + itemlistqryparam);
    if (resdata != null) {
      for (var itmjson in resdata) {
        itmlist.add(ItemModel.fromJson(itmjson as Map<String, dynamic>));
      }
    }
    return itmlist;
  }
}

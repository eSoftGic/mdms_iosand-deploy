// ignore_for_file: prefer_is_empty, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings, unused_local_variable, unrelated_type_equality_checks, avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mdms_iosand/src/features/core/neworder/controller/controller_orderbasic.dart';
import 'package:mdms_iosand/src/features/core/neworder/model/model_item.dart';
import '../../../../../singletons/AppData.dart';
import 'controller_orderedit.dart';
import 'package:http/http.dart' as http;

class OrderCartController extends GetxController {
  final controller = Get.put(OrderBasicController());
  final editcontroller = Get.put(OrderEditController());
  //OrderItemController itemcontroller = Get.put(OrderItemController());

  List<ItemModel> cartlist = <ItemModel>[].obs;
  RxInt lislen = 0.obs;
  RxString ordtotstr = ''.obs;
  RxString ordwtstr = ''.obs;

  String setOrdTotal() {
    double ordtotal = 0.0;
    if (cartlist.length > 0) {
      ordtotal = cartlist.fold(0, (total, current) => total + current.itemnet!);
    }
    return ordtotal.toStringAsFixed(2);
  }

  String setOrdWtTotal() {
    double ordwttotal = cartlist.fold(
        0, (total, current) => total + (current.ord_qty! * current.kg_per_pc!));
    return ordwttotal.toStringAsFixed(3);
  }

  void addtoCartlist(ItemModel _value) async {
    var mycartFiltered = cartlist.where((e) => e.tbl_id == _value.tbl_id);
    if (mycartFiltered.length > 0) {
      debugPrint(mycartFiltered.toString());
      // update item list
    } else {
      // Element is not found
      cartlist.add(_value);
      debugPrint('New item added to cart');
    }
    /*
    final int foundIndex =
        itemcontroller.reslist.indexWhere((prd) => prd.tbl_id == _value.tbl_id);
    if (foundIndex != -1) {
      itemcontroller.reslist[foundIndex].ord_qty = _value.ord_qty;
    }
    */

    lislen.value = cartlist.length;
    debugPrint('cartlist len ' + lislen.value.toString());
    ordtotstr.value = setOrdTotal();
    ordwtstr.value = setOrdWtTotal();
  }

  void removefromCartlist(ItemModel _value) async {
    /*
    final int foundIndex =
        itemcontroller.reslist.indexWhere((prd) => prd.tbl_id == _value.tbl_id);
    if (foundIndex != -1) {
      itemcontroller.reslist[foundIndex].ord_qty = 0;
    }
    */
    cartlist.removeWhere((product) => product.tbl_id == _value.tbl_id);
    lislen.value = cartlist.length;
    ordtotstr.value = setOrdTotal();
    ordwtstr.value = setOrdWtTotal();
  }

  void clearCartlist() async {
    cartlist.clear();
    lislen.value = 0;
    ordtotstr.value = setOrdTotal();
    ordwtstr.value = setOrdWtTotal();
  }

  void saveOrder() async {
    //debugPrint('cart save order');
    int _noitems = cartlist.length;
    int srno = 0;
    String lstsrno = '0';
    for (var item in cartlist) {
      srno = srno + 1;
      debugPrint(srno.toString());
      lstsrno = srno == cartlist.length ? '1' : '0';

      String qryparam = '';
      if (controller.ordrefno == 0) {
        qryparam = "DbName=" +
            appData.log_dbnm! +
            "&ref_no=" +
            controller.ordrefno.toString().trim() +
            "&tran_type=" +
            controller.ordqottype +
            "&tran_type_id=" +
            controller.bukid.value +
            "&ac_id=" +
            controller.acid.toString() +
            "&chain_id=" +
            controller.chainid.value.toString() +
            "&user_id=" +
            appData.log_id.toString().trim() +
            "&branch_id=" +
            appData.log_branchid.toString().trim() +
            "&sr_no=" +
            srno.toString() +
            "&branch_mrp_id=" +
            item.branch_mrp_id.toString() +
            "&pkg=" +
            item.pkg.toString() +
            "&inr_pgk=" +
            item.inr_pkg.toString() +
            "&box_qty=" +
            item.ord_box_qty.toString() +
            "&inner_qty=" +
            item.ord_inr_qty.toString() +
            "&loose_qty=" +
            item.ord_los_qty!.toStringAsFixed(item.decno!) +
            "&qty=" +
            item.ord_qty.toString() +
            "&rate_per=" +
            item.rate_per.toString() +
            "&rate=" +
            item.rate!.toStringAsFixed(4) +
            "&amount=" +
            item.itmgross!.toStringAsFixed(2) +
            "&tax_before_scheme=1" + //(_txbfsch ? "1" : "0") +
            "&free_qty=" +
            item.ord_free_qty.toString() +
            "&sch_page=" +
            item.ord_sch_page.toString() +
            "&sch_amt=" +
            item.ord_sch_amt.toString() +
            "&disc_page=" +
            item.ord_disc_page.toString() +
            "&disc_amt=" +
            item.ord_disc_amt!.toStringAsFixed(2) +
            "&sale_type=" +
            controller.saletype.toString().trim() +
            "&UserNm=" +
            appData.log_name! +
            "&tran_desc=" +
            controller.buknm.value +
            "&sman_id=" +
            appData.log_smanid.toString().trim() +
            "&User_Type_Code=" +
            appData.log_type!.trim() +
            "&Latitude=0.0" + // _lat.toString().trim() +
            "&Longitude=0.0" + //_lon.toString().trim() +
            "&tot_sr_no=" +
            _noitems.toString().trim() +
            "&payterm_disc_id=0" + // _myPayId.toString() +
            "&trade_disc_page=" +
            item.trade_disc_pcn.toString().trim() +
            "&trade_disc=" +
            item.trade_disc_amt.toString().trim() +
            "&turnover_disc_id=0" + //    _turnoverid.toString().trim() +
            "&misc_disc_page=" +
            item.turnover_pcn.toString().trim() +
            "&misc_disc=" +
            item.turnover_rs.toString().trim() +
            "&dispatch_type_id=0" + // _myDispatchtype.toString().trim() +
            "&dispatch_rate_id=0" + // _frtid.toString().trim() +
            "&dispatch_amt=0" + // _frtrs.toString().trim() +
            "&assign_co_id=0" + //     _assigncmpid.toString().trim() +
            "&remark=" +
            item.ordremark.toString() + //_ordremark.trim() +
            "&retval=0";
      } else {
        qryparam = "DbName=" +
            appData.log_dbnm! +
            "&ref_no=" +
            editcontroller.ordrefno.toString().trim() +
            "&tran_type=" +
            editcontroller.ordqottype.toString().trim() +
            "&tran_type_id=" +
            editcontroller.bukid.value.toString() +
            "&ac_id=" +
            editcontroller.acid.value.toString() +
            "&chain_id=" +
            editcontroller.chainid.value.toString() +
            "&user_id=" +
            appData.log_id.toString().trim() +
            "&branch_id=" +
            appData.log_branchid.toString().trim() +
            "&sr_no=" +
            srno.toString() +
            "&branch_mrp_id=" +
            item.branch_mrp_id.toString() +
            "&pkg=" +
            item.pkg.toString() +
            "&inr_pgk=" +
            item.inr_pkg.toString() +
            "&box_qty=" +
            item.ord_box_qty.toString() +
            "&inner_qty=" +
            item.ord_inr_qty.toString() +
            "&loose_qty=" +
            item.ord_los_qty!.toStringAsFixed(item.decno!) +
            "&qty=" +
            item.ord_qty.toString() +
            "&rate_per=" +
            item.rate_per.toString() +
            "&rate=" +
            item.rate!.toStringAsFixed(4) +
            "&amount=" +
            item.itmgross!.toStringAsFixed(2) +
            "&tax_before_scheme=1" + //(_txbfsch ? "1" : "0") +
            "&free_qty=" +
            item.ord_free_qty.toString() +
            "&sch_page=" +
            item.ord_sch_page.toString() +
            "&sch_amt=" +
            item.ord_sch_amt.toString() +
            "&disc_page=" +
            item.ord_disc_page.toString() +
            "&disc_amt=" +
            item.ord_disc_amt!.toStringAsFixed(2) +
            "&sale_type=" +
            editcontroller.saletype.toString().trim() +
            "&UserNm=" +
            appData.log_name! +
            "&tran_desc=" +
            editcontroller.buknm.value +
            "&sman_id=" +
            appData.log_smanid.toString().trim() +
            "&User_Type_Code=" +
            appData.log_type!.trim() +
            "&Latitude=0.0" + // _lat.toString().trim() +
            "&Longitude=0.0" + //_lon.toString().trim() +
            "&tot_sr_no=" +
            _noitems.toString().trim() +
            "&payterm_disc_id=0" + // _myPayId.toString() +
            "&trade_disc_page=" +
            item.trade_disc_pcn.toString().trim() +
            "&trade_disc=" +
            item.trade_disc_amt.toString().trim() +
            "&turnover_disc_id=0" + //    _turnoverid.toString().trim() +
            "&misc_disc_page=" +
            item.turnover_pcn.toString().trim() +
            "&misc_disc=" +
            item.turnover_rs.toString().trim() +
            "&dispatch_type_id=0" + // _myDispatchtype.toString().trim() +
            "&dispatch_rate_id=0" + // _frtid.toString().trim() +
            "&dispatch_amt=0" + // _frtrs.toString().trim() +
            "&assign_co_id=0" + //     _assigncmpid.toString().trim() +
            "&remark=" +
            item.ordremark.toString() + //_ordremark.trim() +
            "&retval=0";
      }

      debugPrint(srno.toString());
      debugPrint(appData.baseurl.toString() + "/Order_add?" + qryparam);

      var res = await doitempost(
          appData.baseurl.toString() + "/Order_add?" + qryparam);
    }
    
    cleardata();
  }

  Future<http.Response> doitempost(String ordurl) async {
    Map<String, String> headersMap = {'Content-Type': 'application/json'};
    Map<String, dynamic> userData = {'dummy': 'dummy'};
    var res = await http.post(Uri.parse(ordurl),
        body: json.encode(userData), headers: headersMap);
    debugPrint('Response status: ${res.statusCode}');
    return res;
    /*
      .then((http.Response response) {
          return response.statusCode;
      });*/
  }

  void cleardata() {
    clearCartlist();
    appData.prtid = 0;
    appData.prtnm = '';
    appData.ordrefno = 0;
    appData.bukid = 0;
    appData.bukcmpstr = '';
    appData.buknm = '';
    appData.chainid = 0;
    appData.chainnm = '';
    appData.saletype = '';
    appData.ordqottype = '';
    appData.ordmaxlimit = 0.0;
    appData.ordlimitvalid = true;
    editcontroller.setAcid(0);
    editcontroller.setAcnm('');
    editcontroller.setOrdrefno(0);
    editcontroller.setBukid('0');
    editcontroller.setBuknm('');
    editcontroller.setSaleType('');
  }
}

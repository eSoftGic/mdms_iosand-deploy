// ignore_for_file: unused_local_variable, unrelated_type_equality_checks, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import '../../../../../../../singletons/AppData.dart';
import 'package:http/http.dart' as http;
import '../../order/add_order/model_item.dart';
import 'controller_prebookbasic.dart';
import 'controller_prebookedit.dart';

class PreBookCartController extends GetxController {
  final controller = Get.put(PreBookBasicController());
  final editcontroller = Get.put(PreBookEditController());
  List<ItemModel> cartlist = <ItemModel>[].obs;
  RxInt lislen = 0.obs;
  RxString ordtotstr = ''.obs;
  RxString ordwtstr = ''.obs;

  String setOrdTotal() {
    double ordtotal = 0.0;
    if (cartlist.isNotEmpty) {
      ordtotal = cartlist.fold(0, (total, current) => total + current.itemnet!);
    }
    return ordtotal.toStringAsFixed(2);
  }

  String setOrdWtTotal() {
    double ordwttotal =
        cartlist.fold(0, (total, current) => total + (current.ord_qty! * current.kg_per_pc!));
    return ordwttotal.toStringAsFixed(3);
  }

  void addtoCartlist(ItemModel value) async {
    //print(_value);
    //print(lislen.value);
    //print(cartlist);
    cartlist.add(value);
    lislen.value = cartlist.length;
    //print(lislen.value);
    ordtotstr.value = setOrdTotal();
    ordwtstr.value = setOrdWtTotal();
  }

  void removefromCartlist(ItemModel value) async {
    cartlist.removeWhere((product) => product.tbl_id == value.tbl_id);
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
    int noitems = cartlist.length;
    int srno = 0;
    for (var item in cartlist) {
      srno = srno + 1;
      String qryparam = '';
      if (editcontroller.ordrefno == 0) {
        qryparam = "DbName=${appData.log_dbnm!}&ref_no=${controller.ordrefno.toString().trim()}&tran_type=PREBK&tran_type_id=${controller.bukid.value}&ac_id=${controller.acid}&chain_id=${controller.chainid.value}&user_id=${appData.log_id.toString().trim()}&branch_id=${appData.log_branchid.toString().trim()}&sr_no=$srno&branch_mrp_id=${item.branch_mrp_id}&pkg=${item.pkg}&inr_pgk=${item.inr_pkg}&box_qty=${item.ord_box_qty}&inner_qty=${item.ord_inr_qty}&loose_qty=${item.ord_los_qty!.toStringAsFixed(item.decno!)}&qty=${item.ord_qty}&rate_per=${item.rate_per}&rate=${item.rate!.toStringAsFixed(4)}&amount=${item.itmgross!.toStringAsFixed(2)}&tax_before_scheme=1&free_qty=${item.ord_free_qty}&sch_page=${item.ord_sch_page}&sch_amt=${item.ord_sch_amt}&disc_page=${item.ord_disc_page}&disc_amt=${item.ord_disc_amt!.toStringAsFixed(2)}&sale_type=${controller.saletype.toString().trim()}&UserNm=${appData.log_name!}&tran_desc=${controller.buknm.value}&sman_id=${appData.log_smanid.toString().trim()}&User_Type_Code=${appData.log_type!.trim()}&Latitude=0.0&Longitude=0.0&tot_sr_no=${noitems.toString().trim()}&payterm_disc_id=0&trade_disc_page=${item.trade_disc_pcn.toString().trim()}&trade_disc=${item.trade_disc_amt.toString().trim()}&turnover_disc_id=0&misc_disc_page=${item.turnover_pcn.toString().trim()}&misc_disc=${item.turnover_rs.toString().trim()}&dispatch_type_id=0&dispatch_rate_id=0&dispatch_amt=0&assign_co_id=0&remark=${item.ordremark}&retval=0";
      } else {
        qryparam = "DbName=${appData.log_dbnm!}&ref_no=${editcontroller.ordrefno.toString().trim()}&tran_type=PREBK&tran_type_id=${editcontroller.bukid.value}&ac_id=${editcontroller.acid.value}&chain_id=${editcontroller.chainid.value}&user_id=${appData.log_id.toString().trim()}&branch_id=${appData.log_branchid.toString().trim()}&sr_no=$srno&branch_mrp_id=${item.branch_mrp_id}&pkg=${item.pkg}&inr_pgk=${item.inr_pkg}&box_qty=${item.ord_box_qty}&inner_qty=${item.ord_inr_qty}&loose_qty=${item.ord_los_qty!.toStringAsFixed(item.decno!)}&qty=${item.ord_qty}&rate_per=${item.rate_per}&rate=${item.rate!.toStringAsFixed(4)}&amount=${item.itmgross!.toStringAsFixed(2)}&tax_before_scheme=1&free_qty=${item.ord_free_qty}&sch_page=${item.ord_sch_page}&sch_amt=${item.ord_sch_amt}&disc_page=${item.ord_disc_page}&disc_amt=${item.ord_disc_amt!.toStringAsFixed(2)}&sale_type=${editcontroller.saletype.toString().trim()}&UserNm=${appData.log_name!}&tran_desc=${editcontroller.buknm.value}&sman_id=${appData.log_smanid.toString().trim()}&User_Type_Code=${appData.log_type!.trim()}&Latitude=0.0&Longitude=0.0&tot_sr_no=${noitems.toString().trim()}&payterm_disc_id=0&trade_disc_page=${item.trade_disc_pcn.toString().trim()}&trade_disc=${item.trade_disc_amt.toString().trim()}&turnover_disc_id=0&misc_disc_page=${item.turnover_pcn.toString().trim()}&misc_disc=${item.turnover_rs.toString().trim()}&dispatch_type_id=0&dispatch_rate_id=0&dispatch_amt=0&assign_co_id=0&remark=${item.ordremark}&retval=0";
      }

      print("${appData.baseurl}/Order_add?$qryparam");

      var res = await doitempost("${appData.baseurl}/Order_add?$qryparam");
    }
    cleardata();
  }

  Future<http.Response> doitempost(String ordurl) async {
    Map<String, String> headersMap = {'Content-Type': 'application/json'};
    Map<String, dynamic> userData = {'dummy': 'dummy'};
    var res = await http.post(Uri.parse(ordurl), body: json.encode(userData), headers: headersMap);
    //print('Response status: ${res.statusCode}');
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
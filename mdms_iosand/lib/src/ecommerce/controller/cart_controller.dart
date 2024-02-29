import 'package:get/get.dart';
import 'package:mdms_iosand/src/ecommerce/screen/home_screen.dart';
//import '../../features/core/screens/order/add_edit_order/model_item.dart';
import '../models/ecomm_model.dart';

class CartController extends GetxController {
  List<ItemModel> cartlist = <ItemModel>[].obs;
  RxInt lislen = 0.obs;

  RxString subtotstr = ''.obs;
  String setSubTotal() {
    double subtotal = cartlist.fold(0, (total, current) => total + current.rate!);
    return subtotal.toStringAsFixed(2);
  }

  double get subtotal => cartlist.fold(0, (total, current) => total + current.rate!);
  String get subtotalString => subtotal.toStringAsFixed(2);

  Map productQuantity(products) {
    var quantity = {};
    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double deliveryFee(subtotal) {
    if (subtotal >= 30.0) {
      return 0.0;
    } else {
      return cartlist.isNotEmpty ? 5.0 : 0.0;
    }
  }

  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);
  double biltotal(subtotal) {
    return subtotal + deliveryFee(subtotal);
  }

  String get biltotalString => biltotal(subtotal).toStringAsFixed(2);
  String freeDelivery(subtotal) {
    if (subtotal >= 30.0) {
      return 'You have FREE delivery';
    } else {
      double missing = 30.0 - subtotal;
      return 'Add ${missing.toStringAsFixed(2)} for FREE delivery';
    }
  }

  void addtoCartlist(ItemModel value) async {
    cartlist.add(value);
    lislen.value = cartlist.length;
    subtotstr.value = setSubTotal();
  }

  void removefromCartlist(ItemModel value) async {
    cartlist.remove(value);
    lislen.value = cartlist.length;
    subtotstr.value = setSubTotal();
  }

  void clearCartlist() async {
    cartlist.clear();
    lislen.value = 0;
    subtotstr.value = setSubTotal();
    Get.to(() => const HomeScreen());
  }

  void saveCarttoOrder() async {
    Get.snackbar('Save Order', 'Success');
  }

  /*void _saveorder() async {
    var _itmlistforDisplay = cartlist.where((itm) {
      double iqty = itm.qty!;
      return iqty>0.0;
    }).toList();

    int srno = 0;
    for (var item in _itmlistforDisplay) {
      srno = srno + 1;
      String qryparam = '';
      if (appData.prtid == 0) {
        qryparam = "DbName=" +
          appData.log_dbnm! +
          "&ref_no=" +
          appData.ordrefno.toString().trim() +
          "&tran_type=" +
          appData.ordqottype! +
          "&tran_type_id='GEN'" +
          //bukid.toString() +
          "&ac_id=" +
          appData.prtid.toString().trim() +
          "&chain_id=" +
          appData.chainid.toString().trim() +
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
            "&tax_before_scheme=" +
            (_txbfsch ? "1" : "0") +
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
            appData.saletype!.trim() +
            "&UserNm=" +
            appData.log_name! +
            "&tran_desc=" +
            appData.buknm! +
            "&sman_id=" +
            appData.log_smanid.toString().trim() +
            "&User_Type_Code=" +
            appData.log_type!.trim() +
            "&tot_sr_no=" +
            _noitems.toString().trim() +
            "&remark=" +
            _ordremark.trim() +
            "&cus_nm=" +
            appData.qotprtnm!.trim() +
            "&cus_addr=" +
            appData.qotprtadd!.trim() +
            "&cus_city=" +
            appData.qotprtcity!.trim() +
            "&cus_mobile=" +
            appData.qotprtmob!.trim() +
            "&cus_email=" +
            appData.qotprtemail!.trim() +
            "&cus_gstin=" +
            appData.qotprtgst!.trim() +
            "&retval=0";
      } else {
        qryparam = "DbName=" +
            appData.log_dbnm! +
            "&ref_no=" +
            appData.ordrefno.toString().trim() +
            "&tran_type=" +
            appData.ordqottype! +
            "&tran_type_id=" +
            bukid.toString() +
            "&ac_id=" +
            appData.prtid.toString().trim() +
            "&chain_id=" +
            appData.chainid.toString().trim() +
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
            "&tax_before_scheme=" +
            (_txbfsch ? "1" : "0") +
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
            appData.saletype!.trim() +
            "&UserNm=" +
            appData.log_name! +
            "&tran_desc=" +
            appData.buknm! +
            "&sman_id=" +
            appData.log_smanid.toString().trim() +
            "&User_Type_Code=" +
            appData.log_type!.trim() +
            "&Latitude=" +
            _lat.toString().trim() +
            "&Longitude=" +
            _lon.toString().trim() +
            "&tot_sr_no=" +
            _noitems.toString().trim() +
            "&payterm_disc_id=" +
            _myPayId.toString() +
            "&trade_disc_page=" +
            item.trade_disc_pcn.toString().trim() +
            "&trade_disc=" +
            item.trade_disc_amt.toString().trim() +
            "&turnover_disc_id=" +
            _turnoverid.toString().trim() +
            "&misc_disc_page=" +
            item.turnover_pcn.toString().trim() +
            "&misc_disc=" +
            item.turnover_rs.toString().trim() +
            "&dispatch_type_id=" +
            _myDispatchtype.toString().trim() +
            "&dispatch_rate_id=" +
            _frtid.toString().trim() +
            "&dispatch_amt=" +
            _frtrs.toString().trim() +
            "&assign_co_id=" +
            _assigncmpid.toString().trim() +
            "&remark=" +
            _ordremark.trim() +
            "&retval=0";
      }
      print(appData.baseurl.toString() + "Order_add?" + qryparam);
      //HttpStatus res = (await doitempost(appData.baseurl.toString() + "Order_add?" + qryparam)) as HttpStatus;
      var res = await doitempost(
          appData.baseurl.toString() + "Order_add?" + qryparam);
    }
    if (appData.ordqottype != 'QUOT') {

      var route =
      MaterialPageRoute(builder: (BuildContext context) => PartyTabBar());
      Navigator.of(context).push(route);
    } else {
      var route =
      MaterialPageRoute(builder: (BuildContext context) => Quotation());
      Navigator.of(context).push(route);
    }
  }
  Future<http.Response> doitempost(String ordurl) async {
    Map<String, String> headersMap = {'Content-Type': 'application/json'};
    Map<String, dynamic> userData = {'dummy': 'dummy'};
    var res = await http.post(Uri.parse(ordurl),
        body: json.encode(userData), headers: headersMap);
    print('Response status: ${res.statusCode}');
    return res;
    */ /*
      .then((http.Response response) {
          return response.statusCode;
      });*/ /*
  }*/
}
// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../singletons/AppData.dart';
import 'package:mdms_iosand/singletons/appsecure.dart';
import '../../order/add_order/model_item.dart';

class PreSingleItemController extends GetxController {
  ItemModel curitem = ItemModel();
  late String stkstr = '';
  var stkcolor = Colors.green;

  RxDouble ordqty = 0.0.obs;
  RxString ordqtystr = ''.obs;
  RxDouble itemnetamt = 0.0.obs;
  RxDouble itmrate = 0.0.obs;
  RxDouble itmnetrate = 0.0.obs;
  RxList<dynamic> prdimglist = [].obs;

  double stock = 0.0;
  bool showbox = false;
  bool showinr = false;
  bool showfre = false;
  bool hasdec = false;
  bool editrat = false;
  bool txbfsch = false;
  int rtwithtax = 0;

  RxInt ordbox = 0.obs;
  RxInt ordinr = 0.obs;
  RxDouble ordlos = 0.0.obs;
  RxDouble ordfre = 0.0.obs;

  RxDouble itmschp = 0.0.obs;
  RxDouble itmscha = 0.0.obs;
  RxDouble itmdisp = 0.0.obs;
  RxDouble itmdisa = 0.0.obs;
  bool schp = false;
  bool scha = false;
  bool disp = false;
  bool disa = false;

  final double _tradediscpcn = 0.0;
  final double _turnoverdiscpcn = 0.0;
  String _ordremark = '';
  String _myDispatchtype = '';
  double _frtrs = 0.0;
  int mrefno = 0;
  int _assigncmpid = 0;
  String _myassignto = '';

  void setcuritem(ItemModel value) async {
    curitem = value;
    rtwithtax = appSecure.rtwithtax!;
    editrat = appSecure.editrate!;
    txbfsch = appSecure.taxbeforescheme!;
    schp = appSecure.showsch!;
    scha = appSecure.showsch!;
    disp = appSecure.showdisc!;
    disa = appSecure.showdisc!;
    hasdec = curitem.decno! > 0 ? true : false;

    getstock();
    setOrdQty(curitem.ord_qty ?? 0);
    setNetRate();
    if (curitem.pkg! > 1) {
      setOrdQty(0);
    }

    showbox = curitem.pkg! > 1;
    showinr = curitem.inr_pkg! > 1;
    showfre = appSecure.showfree!;
    ordbox.value = curitem.ord_box_qty?? 0;
    ordinr.value = curitem.ord_inr_qty ?? 0;
    ordlos.value = curitem.ord_los_qty ?? 0;
    ordfre.value = curitem.ord_free_qty ?? 0;

    itmschp.value = curitem.ord_sch_page!;
    itmscha.value = curitem.ord_sch_amt!;
    itmdisp.value = curitem.ord_disc_page!;
    itmdisa.value = curitem.ord_disc_amt!;

    //print('loading images');
    if (curitem.item_image?.isNotEmpty == true) {
      prdimglist.add(curitem.item_image);
    }
    if (curitem.item_image2?.isNotEmpty == true) {
      prdimglist.add(curitem.item_image2);
    }
    if (curitem.item_image3?.isNotEmpty == true) {
      prdimglist.add(curitem.item_image3);
    }
    if (curitem.item_image4?.isNotEmpty == true) {
      prdimglist.add(curitem.item_image4);
    }
    //print(prdimglist.value.length);
  }

  String setBoxQty(int val) {
    ordbox.value = val;
    curitem.ord_box_qty = val;
    return ordbox.value.toString();
  }

  String setInrQty(int val) {
    ordinr.value = val;
    curitem.ord_inr_qty = val;
    return ordinr.value.toString();
  }

  String setLosQty(double val) {
    ordlos.value = val;
    curitem.ord_los_qty = val;
    return ordlos.value.toString();
  }

  String setFreQty(int val) {
    ordfre.value = val as double;
    curitem.ord_free_qty = val as double?;
    return ordfre.value.toString();
  }

  String setOrdQty(double val) {
    ordqty.value = val;
    curitem.ord_qty = val;
    ordqtystr.value = ordqty.toString().replaceAll('.00', '').replaceAll('.0', '');
    setItmNetAmt();
    return ordqty.toString();
  }

  void addOrdQty() async {
    double q = ordqty.value + 1;
    //print(q);
    if (q > stock) {
      q = stock;
    }
    setOrdQty(q);
    setItmNetAmt();
  }

  void remOrdQty() async {
    double q = ordqty.value > 1 ? ordqty.value - 1 : 0;
    setOrdQty(q);
    setItmNetAmt();
  }

  String setItmNetAmt() {
    NewItemTotal();
    itemnetamt.value = curitem.itemnet!;
    return itemnetamt.value.toStringAsFixed(2);
  }

  String setNetRate() {
    itmrate.value = curitem.rate ?? 0;
    itmnetrate.value = curitem.rate ?? 0;
    double itmnetrt = curitem.rate ?? 0;
    if (appSecure.rtwithtax == 1) {
      itmnetrt = (curitem.rate! + (curitem.rate! * 0.01 * curitem.gst_page!));
      itmnetrate.value = itmnetrt;
    }
    return itmnetrt.toStringAsFixed(curitem.decno! > 2 ? curitem.decno! : 2);
  }

  double get available => curitem.stock_qty! - curitem.unbilled_qty!;
  double get alloc_avail => curitem.allocated_qty! - curitem.allocated_pend_qty!;
  String get itmmrpstk => curitem.mrp_ref!.trim();
  String get stkavailablestr => stkavailable().toString();
  double getstock() {
    stock = stkavailable();
    return stock;
  }

  double stkavailable() {
    if (available > alloc_avail) {
      return available;
    } else {
      return alloc_avail;
    }
  }

  String getstkstr() {
    if (appSecure.showitemstock == false) {
      stkcolor = (available > 0 ? Colors.green : Colors.red);
      return available > 0 ? 'Stk-YES' : 'Stk-NA';
    } else {
      String stk = 'Stk-${available.toString().replaceAll('.0', '').trim()}';
      if (curitem.unbilled_qty!.toDouble() > 0) {
        stk += ' * ${curitem.unbilled_qty.toString().replaceAll('.0', '').trim()}';
      }
      return stk;
    }
  }

  String setSchP(double val) {
    itmschp.value = val;
    curitem.ord_sch_page = val;
    setItmNetAmt();
    return itmschp.value.toStringAsFixed(2);
  }

  String setSchA(double val) {
    itmscha.value = val;
    curitem.ord_sch_amt = val;
    setItmNetAmt();
    return itmscha.value.toStringAsFixed(2);
  }

  String setDisP(double val) {
    itmdisp.value = val;
    curitem.ord_disc_page = val;
    setItmNetAmt();
    return itmdisp.value.toStringAsFixed(2);
  }

  String setDisA(double val) {
    itmdisa.value = val;
    curitem.ord_disc_amt = val;
    setItmNetAmt();
    return itmdisa.value.toStringAsFixed(2);
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  void NewItemTotal() {
    double itmrt = curitem.rate!;
    double igstp = curitem.gst_page!;
    if (appSecure.rtwithtax == 1) {
      itmrt = itmrt / (1 + (igstp * 0.01));
    }
    double igross = roundDouble((curitem.ord_qty! * (itmrt / curitem.rate_per!)), 2);
    double schp = curitem.ord_sch_page ?? 0.0;
    double scha = curitem.ord_sch_amt ?? 0.0;
    scha = roundDouble((igross * 0.01 * schp), 2);
    itmscha.value = scha;
    double disp = curitem.ord_disc_page ?? 0.0;
    double disa = curitem.ord_disc_amt ?? 0.0;
    disa = roundDouble(((igross - scha) * 0.01 * disp), 2);
    itmdisa.value = disa;
    double igsta = roundDouble(((igross - scha - disa) * 0.01 * igstp), 2);
    if (txbfsch == true) {
      igsta = (igross * 0.01 * igstp);
    }
    double inet = roundDouble((igross - scha - disa + igsta), 2);
    curitem.itmgross = igross;
    curitem.ord_sch_amt = scha;
    curitem.ord_disc_amt = disa;
    curitem.gstamt = igsta;
    curitem.itemnet = inet;
    itemnetamt.value = inet;
    /*
    print('gross ' + curitem.itmgross.toString());
    print('sch rs ' + curitem.ord_sch_amt.toString());
    print('dis rs ' + curitem.ord_disc_amt.toString());
    print('gst %  ' + curitem.gst_page.toString());
    print('gst rs ' + curitem.gstamt.toString());
    print('trd disc' + curitem.trade_disc_pcn.toString());
    print('trd disc rs' + curitem.trade_disc_amt.toString());
    print('turn over pcn' + curitem.turnover_pcn.toString());
    print('turn over rs' + curitem.turnover_rs.toString());
    print('net amt' + curitem.itemnet.toString());
    print('net after calc itmtotal ' + inet.toStringAsFixed(2));
    print('net after calc itmtotal ' + curitem.itemnet!.toStringAsFixed(2));
     */
  }

  String getitmtotal() {
    double itmtrddiscrs = 0.0;
    double itmturnorverrs = 0.0;
    double itmtrddiscpcn = 0.0;
    double slbamt = (curitem.ord_qty! * (curitem.rate! / curitem.rate_per!));
    double slbqty = curitem.ord_qty!;

    //Scheme Slab Calculations
    String schmSlab = curitem.scheme_slab ?? '';
    //print(schm_slab);
    List<String> schmArr = schmSlab.split('|');
    //print('scheme array len is ' + schm_arr.length.toString());
    double schemepcn = 0.0;
    double schemers = 0.0;
    double schemeid = 0;
    double schemeperpcs = 0;
    String schscroll = '';
    for (int i = 0; i < schmArr.length; i++) {
      if (schmArr[i].trim().isNotEmpty) {
        List<String> schslab = schmArr[i].split(',');
        int? slbid = num.tryParse(schslab[0])?.toInt();
        String slbon = schslab[1].toString();
        var slbfrm = num.tryParse(schslab[2])?.toDouble();
        var slbupto = num.tryParse(schslab[3])?.toDouble();
        var slbpcn = num.tryParse(schslab[4])?.toDouble();
        var slbrs = num.tryParse(schslab[5])?.toDouble();
        var slbperpcs = num.tryParse(schslab[6])?.toDouble();
        if (slbon == "Q") {
          if (slbqty >= slbfrm! && slbqty <= slbupto!) {
            schemepcn = slbpcn!;
            schemeid = slbid! as double;
            schemeperpcs = slbperpcs!;
            if (slbrs! > 0) {
              schemers = (slbqty / slbperpcs) * slbrs;
            }
            schscroll = 'Scheme on Qty [${slbfrm.toString().trim()} - $slbupto----$slbpcn% , Rs.$slbrs]';
            break;
          }
        } else {
          if (slbamt >= slbfrm! && slbqty <= slbupto!) {
            schemepcn = slbpcn!;
            schemeid = slbid! as double;
            schemeperpcs = slbperpcs!;
            if (slbrs! > 0) {
              schemers = (slbamt / slbperpcs) * slbrs;
            }
            schscroll = 'Scheme on Amt [${slbfrm.toString().trim()} - $slbupto----$slbpcn% , Rs.$slbrs]';

            break;
          }
        }
      }
    }
    // Discount Slab check
    String discSlab = curitem.discount_slab ?? '';
    //print('disc slab is ' + disc_slab);
    double discslbpcn = 0.0;
    double discslbrs = 0.0;
    double discslbid = 0;
    double discslbperpcs = 0;
    String disscroll = '';

    if (discSlab.toString().trim().isNotEmpty) {
      List<String> discArr = discSlab.split('|');
      //print('disc array len is ' + disc_arr.length.toString());
      for (int i = 0; i < discArr.length; i++) {
        if (discArr[i].trim().isNotEmpty) {
          List<String> discslab = discArr[i].split(',');
          int? slbid = num.tryParse(discslab[0])?.toInt();
          String slbon = discslab[1].toString();
          var slbfrm = num.tryParse(discslab[2])?.toDouble();
          var slbupto = num.tryParse(discslab[3])?.toDouble();
          var slbpcn = num.tryParse(discslab[4])?.toDouble();
          var slbrs = num.tryParse(discslab[5])?.toDouble();
          var slbperpcs = num.tryParse(discslab[6])?.toDouble();
          if (slbon == "Q") {
            if (slbqty >= slbfrm! && slbqty <= slbupto!) {
              discslbpcn = slbpcn!;
              discslbrs = slbrs!;
              discslbid = slbid! as double;
              discslbperpcs = slbperpcs!;
              if (slbrs > 0) {
                discslbrs = (slbqty / slbperpcs) * slbrs;
              }
              disscroll = 'Discount on Qty [${slbfrm.toString().trim()} - $slbupto----$slbpcn% , Rs.$slbrs]';

              break;
            }
          } else {
            if (slbamt >= slbfrm! && slbqty <= slbupto!) {
              discslbpcn = slbpcn!;
              discslbid = slbid! as double;
              discslbrs = slbrs!;
              discslbperpcs = slbperpcs!;
              if (slbrs > 0) {
                discslbrs = (slbamt / slbperpcs) * slbrs;
              }
              disscroll = 'Discount on Amt [${slbfrm.toString().trim()} - $slbupto----$slbpcn% , Rs.$slbrs]';

              break;
            }
          }
        }
      }
    }

    double itmrt = curitem.rate!;
    double igstp = curitem.gst_page!;
    if (appSecure.rtwithtax == 1) {
      itmrt = itmrt / (1 + (igstp * 0.01));
    }
    double igross = roundDouble((curitem.ord_qty! * (itmrt / curitem.rate_per!)), 2);

    double schp = curitem.ord_sch_page ?? 0.0;
    double scha = curitem.ord_sch_amt ?? 0.0;
    if (schemepcn > 0 || schemers > 0) {
      schp = schemepcn;
      scha = schemers;
    }
    if (schp > 0) {
      scha = roundDouble((igross * 0.01 * schp), 2);
    }

    double disp = curitem.ord_disc_page ?? 0.0;
    double disa = curitem.ord_disc_amt ?? 0.0;
    if (discslbpcn > 0 || discslbrs > 0) {
      disp = discslbpcn;
      disa = discslbrs;
    }

    if (disp > 0) {
      disa = roundDouble(((igross - scha) * 0.01 * disp), 2);
    }

    // Trade Discount & Turn Over Discount
    if (curitem.disc_on_item == true) {
      itmtrddiscrs = 0;
      if (_tradediscpcn > 0) {
        itmtrddiscrs = roundDouble((igross - scha - disa) * 0.01 * _tradediscpcn, 2);
      }

      if (_turnoverdiscpcn > 0) {
        itmturnorverrs =
            roundDouble((igross - scha - disa - itmtrddiscrs) * 0.01 * _turnoverdiscpcn, 2);
      }
    }

    if (appData.commonorder == true) {
      _ordremark = curitem.ordremark.toString();
      if (curitem.disc_on_item == true) {
        if (mrefno > 0) {
          _myDispatchtype = curitem.dispatch_mode.toString().trim();
          if (_frtrs == 0) {
            _frtrs = curitem.frt_rs!;
            //_frtid = item.frt_id;
          }
          if (_assigncmpid == 0) {
            _assigncmpid = curitem.assigncoid ?? 0;
            _myassignto = curitem.assignconm ?? 'SELECT';
          }
        }
      }
    }

    double igsta =
        roundDouble(((igross - scha - disa - itmtrddiscrs - itmturnorverrs) * 0.01 * igstp), 2);

    if (txbfsch == true) {
      igsta = (igross * 0.01 * igstp);
    }

    double inet = roundDouble((igross - scha - disa - itmtrddiscrs - itmturnorverrs + igsta), 2);
    curitem.trade_disc_pcn = _tradediscpcn;
    curitem.trade_disc_amt = itmtrddiscrs;
    curitem.turnover_pcn = _turnoverdiscpcn;
    curitem.turnover_rs = itmturnorverrs;
    curitem.itmgross = igross;
    curitem.ord_sch_amt = scha;
    curitem.ord_disc_amt = disa;
    curitem.gstamt = igsta;
    curitem.itemnet = inet;
    /*
      print('gross ' + item.itmgross.toString());
      print('sch rs ' + item.ord_sch_amt.toString());
      print('dis rs ' + item.ord_disc_amt.toString());
      print('gst %  ' + item.gst_page.toString());
      print('gst rs ' + item.gstamt.toString());
      print('trd disc' + item.trade_disc_pcn.toString());
      print('trd disc rs' + item.trade_disc_amt.toString());
      print('turn over pcn' + item.turnover_pcn.toString());
      print('turn over rs' + item.turnover_rs.toString());
      print('net amt' + item.itemnet.toString());
       */
    itemnetamt.value = inet;
    print('net after calc itmtotal ${inet.toStringAsFixed(2)}');
    print('net after calc itmtotal ${curitem.itemnet!.toStringAsFixed(2)}');

    return inet.toStringAsFixed(2);
  }
}
// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ItemModel extends Equatable {
  //Define
  final int? tbl_id;
  final int? company_id;
  final String? company_nm;
  final int? item_cat_id;
  final String? item_cat_nm;
  final int? item_brand_id;
  final String? item_brand_nm;
  final int? item_id;
  final String? item_code;
  final String? item_nm;
  final int? mrp_id;
  final String? mrp_ref;
  final int? branch_id;
  final String? branch_nm;
  final int? branch_mrp_id;
  final double? pkg;
  final int? inr_pkg;
  final double? kg_per_pc;
  final double? rate_per;
  double? rate;
  final double? gst_page;
  final double? ex_gst_rate;
  final double? stock_qty;
  final int? stock_box_qty;
  final int? stock_inner_qty;
  final double? stock_loose_qty;
  final double? unbilled_qty;
  final String? uom;
  final int? decno;
  double? ord_qty;
  double? editordqty;
  double? gstamt = 0.0;
  double? itmgross = 0.0;
  double? itemnet = 0.0;
  final double? mxordamt;
  int? ord_box_qty;
  int? ord_inr_qty;
  double? ord_los_qty = 0.0;
  String? ratedesc;
  double? mst_sal_rate;
  double? ord_free_qty;
  double? ord_sch_page;
  double? ord_sch_amt;
  double? ord_disc_page;
  double? ord_disc_amt;
  bool? show_image;
  String? scheme_slab;
  String? discount_slab;
  bool? rate_editable;
  bool? disc_on_item;
  final String? item_scroll;
  int? trade_disc_id;
  double? trade_disc_pcn;
  double? trade_disc_amt;
  int? turnover_disc_id;
  double? turnover_pcn;
  double? turnover_rs;
  String? dispatch_mode;
  int? frt_id;
  double? frt_rt;
  double? frt_rs;
  int? assigncoid;
  String? assignconm;
  String? ordremark;
  String? cusnm;
  String? cusaddr;
  String? cuscity;
  String? cusmobile;
  String? cusemail;
  String? cusgstin;
  int? max_bill_qty;
  String? item_image;
  String? item_image2;
  String? item_image3;
  String? item_image4;
  String? item_image5;
  String? item_image6;
  String? item_image7;
  String? item_image8;
  String? item_image9;
  String? item_image10;
  bool? isRecommended;
  bool? isPopular;
  double? allocated_qty;
  double? allocated_pend_qty;
  String? alloc_period_from;
  String? alloc_period_upto;
  String? approved_status;
  double? billed_qty;
  String? feature;

  // Constructutor
  ItemModel(
      {this.tbl_id,
      this.company_id,
      this.company_nm,
      this.item_cat_id,
      this.item_cat_nm,
      this.item_brand_id,
      this.item_brand_nm,
      this.item_id,
      this.item_code,
      this.item_nm,
      this.mrp_id,
      this.mrp_ref,
      this.branch_id,
      this.branch_nm,
      this.branch_mrp_id,
      this.pkg,
      this.inr_pkg,
      this.kg_per_pc,
      this.rate_per,
      this.rate = 0.0,
      this.gst_page,
      this.ex_gst_rate,
      this.stock_qty,
      this.stock_box_qty,
      this.stock_inner_qty,
      this.stock_loose_qty,
      this.unbilled_qty,
      this.ord_qty,
      this.editordqty,
      this.uom,
      this.decno,
      this.gstamt,
      this.itmgross,
      this.itemnet,
      this.mxordamt,
      this.ord_box_qty,
      this.ord_inr_qty,
      this.ord_los_qty,
      this.ratedesc,
      this.mst_sal_rate,
      this.ord_free_qty,
      this.ord_sch_page,
      this.ord_sch_amt,
      this.ord_disc_page,
      this.ord_disc_amt,
      this.show_image,
      this.scheme_slab,
      this.discount_slab,
      this.rate_editable,
      this.disc_on_item,
      this.item_scroll,
      this.trade_disc_id,
      this.trade_disc_pcn,
      this.trade_disc_amt,
      this.turnover_disc_id,
      this.turnover_pcn,
      this.turnover_rs,
      this.dispatch_mode,
      this.frt_id,
      this.frt_rt,
      this.frt_rs,
      this.assigncoid,
      this.assignconm,
      this.ordremark,
      this.cusnm,
      this.cusaddr,
      this.cuscity,
      this.cusmobile,
      this.cusemail,
      this.cusgstin,
      this.max_bill_qty,
      this.item_image,
      this.item_image2,
      this.item_image3,
      this.item_image4,
      this.item_image5,
      this.item_image6,
      this.item_image7,
      this.item_image8,
      this.item_image9,
      this.item_image10,
      this.isRecommended = false,
      this.isPopular = false,
      this.allocated_qty,
      this.allocated_pend_qty,
      this.alloc_period_from,
      this.alloc_period_upto,
      this.approved_status,
      this.billed_qty,
      this.feature});

  //Maping
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      tbl_id: json['TBL_ID'],
      company_id: json['COMPANY_ID'],
      company_nm: json['COMPANY_NM'],
      item_cat_id: json['ITEM_CAT_ID'],
      item_cat_nm: json['ITEM_CAT_NM'],
      item_brand_id: json['ITEM_BRAND_ID'],
      item_brand_nm: json['ITEM_BRAND_NM'],
      item_id: json['ITEM_ID'],
      item_code: json['ITEM_CODE'],
      item_nm: json['ITEM_NM'],
      mrp_id: json['MRP_ID'],
      mrp_ref: json['MRP_REF'],
      branch_id: json['BRANCH_ID'],
      branch_nm: json['BRANCH_NM'],
      branch_mrp_id: json['BRANCH_MRP_ID'],
      pkg: json['PKG'], // > 1 Box Qty   3
      inr_pkg: json['INR_PKG'], // > 1 Inr 6
      kg_per_pc: json['KG_PER_PC'],
      rate_per: json['RATE_PER'],
      rate: json['RATE'] ?? 0.0,
      gst_page: json['GST_PAGE'],
      ex_gst_rate: json['EX_GST_RATE'],
      stock_qty: json['STOCK_QTY'],
      stock_box_qty: json['STOCK_BOX_QTY'],
      stock_inner_qty: json['STOCK_INNER_QTY'],
      stock_loose_qty: json['STOCK_LOOSE_QTY'],
      unbilled_qty: json['UNBILLED_QTY'],
      ord_qty: json['ORD_QTY'],
      editordqty: json['ORD_QTY'],
      uom: json['UOM'],
      decno: json['DEC_NO'] ?? 0,
      mxordamt: json['MAX_ORD_AMT'] ?? 0,
      ord_box_qty: json['ORD_BOX_QTY'] ?? 0,
      ord_inr_qty: json['ORD_INNER_QTY'] ?? 0,
      ord_los_qty: json['ORD_LOOSE_QTY'] ?? 0,
      ratedesc: json['RATE_DESC'] ?? '',
      mst_sal_rate: json['MST_SAL_RATE'] ?? 0,
      ord_free_qty: json['ORD_FREE_QTY'] ?? 0,
      ord_sch_page: json['ORD_SCH_PAGE'] ?? 0,
      ord_sch_amt: json['ORD_SCH_AMT'] ?? 0,
      ord_disc_page: json['ORD_DISC_PAGE'] ?? 0,
      ord_disc_amt: json['ORD_DISC_AMT'] ?? 0,
      show_image: json['SHOW_IMAGE'] ?? false,
      scheme_slab: json['SCH_SLAB'] ?? '',
      discount_slab: json['DISC_SLAB'] ?? '',
      rate_editable: json['RATE_EDITABLE_MDMS'] ?? false,
      disc_on_item: json['DISC_ON_ITEM'] ?? '',
      item_scroll: json['SCH_DISC_SCROLL'] ?? '',
      trade_disc_id: json['PAYTERM_DISC_ID'] ?? 0,
      trade_disc_pcn: json['ORD_TRADE_DISC_PAGE'] ?? 0,
      trade_disc_amt: json['ORD_TRADE_DISC_AMT'] ?? 0,
      turnover_disc_id: json['TURNOVER_DISC_ID'] ?? 0,
      turnover_pcn: json['ORD_MISC_DISC_PAGE'] ?? 0,
      turnover_rs: json['ORD_MISC_DISC_AMT'] ?? 0,
      dispatch_mode: json['DISPATCH_TYPE_ID'] ?? 'SELECT',
      frt_rs: json['DISPATCH_AMT'] ?? 0,
      assigncoid: json['ORDER_ASSIGN_CO_ID'] ?? 0,
      assignconm: json['ORDER_ASSIGN_CO_NM'] ?? '',
      frt_id: json['frt_id'] ?? 0,
      frt_rt: json['frt_rt'] ?? 0,
      ordremark: json['REMARK'] ?? ' ',
      cusnm: json['CUS_NM'] ?? ' ',
      cusaddr: json['CUS_ADDR'] ?? ' ',
      cuscity: json['CUS_CITY'] ?? ' ',
      cusmobile: json['CUS_MOBILE'] ?? ' ',
      cusemail: json['CUS_EMAIL'] ?? ' ',
      cusgstin: json['CUS_GSTTIN'] ?? ' ',
      max_bill_qty: json['MAX_BILL_QTY'] ?? ' ',
      item_image: json['ITEM_IMAGE'] ?? 'na',
      item_image2: json['ITEM_IMAGE2'] ?? 'na',
      item_image3: json['ITEM_IMAGE3'] ?? 'na',
      item_image4: json['ITEM_IMAGE4'] ?? 'na',
      item_image5: json['ITEM_IMAGE5'] ?? 'na',
      item_image6: json['ITEM_IMAGE6'] ?? 'na',
      item_image7: json['ITEM_IMAGE7'] ?? 'na',
      item_image8: json['ITEM_IMAGE8'] ?? 'na',
      item_image9: json['ITEM_IMAGE9'] ?? 'na',
      item_image10: json['ITEM_IMAGE10'] ?? 'na',
      isRecommended: false,
      isPopular: false,
      allocated_qty: json['ALLOCATED_QTY'] ?? 0.0,
      allocated_pend_qty: json['ALLOC_PEND_QTY'] ?? 0.0,
      alloc_period_from: json['ALLOC_PERIOD_FROM'] ?? '',
      alloc_period_upto: json['ALLOC_PERIOD_UPTO'] ?? '',
      approved_status: json['APPROVED_STATUS'] ?? '',
      billed_qty: json['BILLED_QTY'] ?? 0.0,
      feature: json['FEATURE'] ?? 'Not Available',
    );
  }

  @override
  List<Object?> get props => [
        tbl_id,
        company_id,
        company_nm,
        item_cat_id,
        item_cat_nm,
        item_brand_id,
        item_brand_nm,
        item_id,
        item_code,
        item_nm,
        mrp_id,
        mrp_ref,
        branch_id,
        branch_nm,
        branch_mrp_id,
        pkg,
        inr_pkg,
        kg_per_pc,
        rate_per,
        rate,
        gst_page,
        ex_gst_rate,
        stock_qty,
        stock_box_qty,
        stock_inner_qty,
        stock_loose_qty,
        unbilled_qty,
        uom,
        decno,
        ord_qty,
        editordqty,
        gstamt,
        itmgross,
        itemnet,
        mxordamt,
        ord_box_qty,
        ord_inr_qty,
        ord_los_qty,
        ratedesc,
        mst_sal_rate,
        ord_free_qty,
        ord_sch_page,
        ord_sch_amt,
        ord_disc_page,
        ord_disc_amt,
        show_image,
        scheme_slab,
        discount_slab,
        rate_editable,
        disc_on_item,
        item_scroll,
        trade_disc_id,
        trade_disc_pcn,
        trade_disc_amt,
        turnover_disc_id,
        turnover_pcn,
        turnover_rs,
        dispatch_mode,
        frt_id,
        frt_rt,
        frt_rs,
        assigncoid,
        assignconm,
        ordremark,
        cusnm,
        cusaddr,
        cuscity,
        cusmobile,
        cusemail,
        cusgstin,
        max_bill_qty,
        item_image,
        item_image2,
        item_image3,
        item_image4,
        item_image5,
        item_image6,
        item_image7,
        item_image8,
        item_image9,
        item_image10,
        isRecommended,
        isPopular,
        allocated_qty,
        allocated_pend_qty,
        alloc_period_from,
        alloc_period_upto,
        approved_status,
        billed_qty,
        feature
      ];
}

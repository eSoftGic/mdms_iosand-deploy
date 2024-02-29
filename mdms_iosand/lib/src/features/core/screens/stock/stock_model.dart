// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class StockModel extends Equatable {
  //Define
  final int tbl_id;
  final int item_id;
  final String company_nm;
  final String item_code;
  final String item_nm;
  final String mrp_ref;
  final String item_brand_nm;
  final String item_cat_nm;
  final String exp_dt;
  final double mrp_rs;
  final double cgst_tax_page;
  final double sgst_tax_page;
  final double addgst_tax_page;
  final String hsn_code;
  final double loose_qty;
  final double rate;
  final double amount;
  final double net_avail_qty;
  final double net_avail_amount;
  final String feature;
  final int reorder_level;
  final double kg_per_pc;
  final double pkg;
  final double inr_pkg;
  final String co_item_code;
  final double qty;
  final double kgs;
  final int box_qty;
  final int inner_qty;
  final double recon_diff_qty;
  final double recon_diff_amount;
  final String column_display;
  final bool show_image;
  final String item_image;
  final String item_image2;
  final String item_image3;
  final String item_image4;
  final String item_image5;
  final String item_image6;
  final String item_image7;
  final String item_image8;
  final String item_image9;
  final String item_image10;
  final bool isRecommended;
  final bool isPopular;

  // Constructutor
  const StockModel({
    required this.tbl_id,
    required this.item_id,
    required this.company_nm,
    required this.item_code,
    required this.item_nm,
    required this.mrp_ref,
    required this.item_brand_nm,
    required this.item_cat_nm,
    required this.exp_dt,
    required this.mrp_rs,
    required this.cgst_tax_page,
    required this.sgst_tax_page,
    required this.addgst_tax_page,
    required this.hsn_code,
    required this.loose_qty,
    required this.rate,
    required this.amount,
    required this.net_avail_qty,
    required this.net_avail_amount,
    required this.feature,
    required this.reorder_level,
    required this.kg_per_pc,
    required this.pkg,
    required this.inr_pkg,
    required this.co_item_code,
    required this.qty,
    required this.kgs,
    required this.box_qty,
    required this.inner_qty,
    required this.recon_diff_qty,
    required this.recon_diff_amount,
    required this.column_display,
    required this.show_image,
    required this.item_image,
    required this.item_image2,
    required this.item_image3,
    required this.item_image4,
    required this.item_image5,
    required this.item_image6,
    required this.item_image7,
    required this.item_image8,
    required this.item_image9,
    required this.item_image10,
    this.isRecommended = false,
    this.isPopular = false,
  });

  //Maping
  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      tbl_id: json['TBL_ID'],
      item_id: json['ID'],
      company_nm: json['COMPANY_NM'],
      item_code: json['ITEM_CODE'],
      item_nm: json['ITEM_NM'],
      mrp_ref: json['MRP_REF'],
      item_brand_nm: json['ITEM_BRAND_NM'],
      item_cat_nm: json['ITEM_CAT_NM'],
      exp_dt: json['EXP_DT'],
      mrp_rs: json['MRP_RS'],
      cgst_tax_page: json['CGST_TAX_PAGE'],
      sgst_tax_page: json['SGST_TAX_PAGE'],
      addgst_tax_page: json['ADDGST_TAX_PAGE'],
      hsn_code: json['HSN_CODE'],
      loose_qty: json['LOOSE_QTY'],
      rate: json['RATE'],
      amount: json['AMOUNT'],
      net_avail_qty: json['NET_AVAIL_QTY'],
      net_avail_amount: json['NET_AVAIL_AMOUNT'],
      feature: json['FEATURE'],
      reorder_level: json['REORDER_LEVEL'],
      kg_per_pc: json['KG_PER_PC'],
      pkg: json['PKG'],
      inr_pkg: json['INR_PKG'],
      co_item_code: json['CO_ITEM_CODE'],
      qty: json['QTY'],
      kgs: json['KGS'],
      box_qty: json['BOX_QTY'],
      inner_qty: json['INNER_QTY'],
      recon_diff_qty: json['RECON_DIFF_QTY'],
      recon_diff_amount: json['RECON_DIFF_AMOUNT'],
      column_display: json['COLUMN_DISPLAY'],
      show_image: json['SHOW_IMAGE'],
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
      isRecommended: json['TBL_ID'] <= 5 ? true : false,
      isPopular: json['TBL_ID'] > 10 ? true : false,
    );
  }

  @override
  List<Object?> get props => [
        tbl_id,
        item_id,
        company_nm,
        item_code,
        item_nm,
        mrp_ref,
        item_brand_nm,
        item_cat_nm,
        exp_dt,
        mrp_rs,
        cgst_tax_page,
        sgst_tax_page,
        addgst_tax_page,
        hsn_code,
        loose_qty,
        rate,
        amount,
        net_avail_qty,
        net_avail_amount,
        feature,
        reorder_level,
        kg_per_pc,
        pkg,
        inr_pkg,
        co_item_code,
        qty,
        kgs,
        box_qty,
        inner_qty,
        recon_diff_qty,
        recon_diff_amount,
        column_display,
        show_image,
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
        isPopular
      ];
}

// ignore_for_file: non_constant_identifier_names

class OrdHistoryModel {
  //Define
  final int? ref_no;
  final bool? no_order;
  final int? branch_id;
  final String? branch_nm;
  final int? sman_id;
  final String? sman_nm;
  final int? tran_type_id;
  final String? tran_desc;
  final String? company_sel;
  final String? tran_no;
  final String? tran_dt;
  final String? ord_dt;
  final double? net_amt;
  final int? ac_id;
  final String? ac_nm;
  final int? chain_id;
  final String? chain_area_nm;
  final String? billed;
  final String? bill_detail;
  final String? sale_type;
  final String? pdffilenm;
  final String? assign_co_nm;
  final String? ord_approval_status;
  final String? order_pdffilenm;
  final String? order_entry_dt;
  final String? item_nm;
  final String? mrp_ref;
  final int? box_qty;
  final int? inner_qty;
  final double? loose_qty;
  final double? qty;
  final double? rate;
  final double? amount;
  final double? free_qty;
  final double? sch_page;
  final double? sch_amt;
  final double? disc_page;
  final double? disc_amt;
  final double? trade_disc_page;
  final double? trade_disc;
  final double? misc_disc_page;
  final double? misc_disc_amt;
  final double? gst_page;
  final double? gst_amt;
  final double? tax_on_amt;
  final double? item_net;

  OrdHistoryModel(
      {this.ref_no,
      this.no_order,
      this.branch_id,
      this.branch_nm,
      this.sman_id,
      this.sman_nm,
      this.tran_type_id,
      this.tran_desc,
      this.company_sel,
      this.tran_no,
      this.tran_dt,
      this.ord_dt,
      this.net_amt,
      this.ac_id,
      this.ac_nm,
      this.chain_id,
      this.chain_area_nm,
      this.billed,
      this.bill_detail,
      this.sale_type,
      this.pdffilenm,
      this.assign_co_nm,
      this.ord_approval_status,
      this.order_pdffilenm,
      this.order_entry_dt,
      this.item_nm,
      this.mrp_ref,
      this.box_qty,
      this.inner_qty,
      this.loose_qty,
      this.qty,
      this.rate,
      this.amount,
      this.free_qty,
      this.sch_page,
      this.sch_amt,
      this.disc_page,
      this.disc_amt,
      this.trade_disc_page,
      this.trade_disc,
      this.misc_disc_page,
      this.misc_disc_amt,
      this.gst_page,
      this.gst_amt,
      this.tax_on_amt,
      this.item_net});

  //Maping
  factory OrdHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrdHistoryModel(
        ref_no: json['REF_NO'],
        no_order: json['NO_ORDER'],
        branch_id: json['BRANCH_ID'],
        branch_nm: json['BRANCH_NM'],
        sman_id: json['SMAN_ID'],
        sman_nm: json['SMAN_NM'],
        tran_type_id: json['TRAN_TYPE_ID'],
        tran_desc: json['TRAN_DESC'],
        company_sel: json['COMPANY_SEL'],
        tran_no: json['TRAN_NO'],
        tran_dt: json['TRAN_DT'],
        ord_dt: json['ORD_DT'],
        net_amt: json['NET_AMT'],
        ac_id: json['AC_ID'],
        ac_nm: json['AC_NM'],
        chain_id: json['CHAIN_ID'],
        chain_area_nm: json['CHAIN_AREA_NM'],
        billed: json['BILLED'],
        bill_detail: json['BILL_DETAIL'],
        sale_type: json['SALE_TYPE'],
        pdffilenm: json['PDFFILENM'],
        assign_co_nm: json['ASSIGN_CO_NM'],
        ord_approval_status: json['ORD_APPROVAL_STATUS'],
        order_pdffilenm: json['ORDER_PDFFILENM'],
        order_entry_dt: json['ORDER_ENTRY_DT'],
        item_nm: json['ITEM_NM'],
        mrp_ref: json['MRP_REF'],
        box_qty: json['BOX_QTY'],
        inner_qty: json['INNER_QTY'],
        loose_qty: json['LOOSE_QTY'],
        qty: json['QTY'],
        rate: json['RATE'],
        amount: json['AMOUNT'],
        free_qty: json['FREE_QTY'],
        sch_page: json['SCH_PAGE'],
        sch_amt: json['SCH_AMT'],
        disc_page: json['DISC_PAGE'],
        disc_amt: json['DISC_AMT'],
        trade_disc_page: json['TRADE_DISC_PAGE'],
        trade_disc: json['TRADE_DISC'],
        misc_disc_page: json['MISC_DISC_PAGE'],
        misc_disc_amt: json['MISC_DISC_AMT'],
        gst_page: json['GST_PAGE'],
        gst_amt: json['GST_AMT'],
        tax_on_amt: json['TAX_ON_AMT'],
        item_net: json['ITEM_NET']);
  }
}
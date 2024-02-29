// ignore_for_file: non_constant_identifier_names

class PreBookModel {
  PreBookModel(
      {this.tbl_id,
      this.ref_no,
      this.tran_type_id,
      this.tran_desc,
      this.company_sel,
      this.tran_no,
      this.tran_dt,
      this.ord_dt,
      this.net_amt,
      this.ac_id,
      this.ac_nm,
      this.billed,
      this.billdetails,
      this.chainid,
      this.chainareanm,
      this.saletype,
      this.billpdf,
      this.assignconm,
      this.approvalstatus,
      this.ordpdf,
      this.noorder,
      this.bill_asm_approval_status,
      this.bill_asm_approval_dt,
      this.bill_asm_approval_user,
      this.bill_account_approval_status,
      this.bill_account_approval_dt,
      this.bill_account_approval_user,
      this.bill_logistic_approval_status,
      this.bill_logistic_approval_dt,
      this.bill_logistic_approval_user});

  int? tbl_id;
  int? ref_no;
  int? tran_type_id;
  String? tran_desc;
  String? company_sel;
  String? tran_no;
  String? tran_dt;
  String? ord_dt;
  double? net_amt;
  int? ac_id;
  String? ac_nm;
  String? billed;
  String? billdetails;
  int? chainid;
  String? chainareanm;
  String? saletype;
  String? billpdf;
  String? assignconm;
  String? approvalstatus;
  String? ordpdf;
  String? noorder;
  String? bill_asm_approval_status;
  String? bill_asm_approval_dt;
  String? bill_asm_approval_user;
  String? bill_account_approval_status;
  String? bill_account_approval_dt;
  String? bill_account_approval_user;
  String? bill_logistic_approval_status;
  String? bill_logistic_approval_dt;
  String? bill_logistic_approval_user;

  //Maping
  factory PreBookModel.fromJson(Map<String, dynamic> json) {
    return PreBookModel(
        tbl_id: json['TBL_ID'],
        ref_no: json['REF_NO'],
        tran_type_id: json['TRAN_TYPE_ID'],
        tran_desc: json['TRAN_DESC'],
        company_sel: json['COMPANY_SEL'],
        tran_no: json['TRAN_NO'],
        tran_dt: json['TRAN_DT'],
        ord_dt: json['ORD_DT'],
        net_amt: json['NET_AMT'],
        ac_id: json['AC_ID'],
        ac_nm: json['AC_NM'],
        billed: json['BILLED'],
        billdetails: json['BILL_DETAIL'],
        chainid: json['CHAIN_ID'],
        chainareanm: json['CHAIN_AREA_NM'] ?? '',
        saletype: json['SALE_TYPE'],
        billpdf: json['PDFFILENM'] ?? '',
        assignconm: json['ASSIGN_CO_NM'] ?? '',
        approvalstatus: json['ORD_APPROVAL_STATUS'] ?? '',
        ordpdf: json['ORDER_PDFFILENM'] ?? '',
        noorder: json['NO_ORDER'] ?? '',
        bill_asm_approval_status: json['BILL_ASM_APPROVAL_STATUS'] ?? 'NA',
        bill_asm_approval_dt: json['BILL_ASM_APPROVAL_DT'] ?? 'NA',
        bill_asm_approval_user: json['BILL_ASM_APPROVAL_USER'] ?? 'NA',
        bill_account_approval_status: json['BILL_ACCOUNT_APPROVAL_STATUS'] ?? 'NA',
        bill_account_approval_dt: json['BILL_ACCOUNT_APPROVAL_DT'] ?? 'NA',
        bill_account_approval_user: json['BILL_ACCOUNT_APPROVAL_USER'] ?? 'NA',
        bill_logistic_approval_status: json['BILL_LOGISTIC_APPROVAL_STATUS'] ?? 'NA',
        bill_logistic_approval_dt: json['BILL_LOGISTIC_APPROVAL_DT'] ?? 'NA',
        bill_logistic_approval_user: json['BILL_LOGISTIC_APPROVAL_USER'] ?? 'NA');
  }

  Map<String, dynamic> toJson() => {
        'tbl_id': tbl_id,
        'ref_no': ref_no,
        'tran_type_id': tran_type_id,
        'tran_desc': tran_desc,
        'company_sel': company_sel,
        'tran_no': tran_no,
        'tran_dt': tran_dt,
        'ord_dt': ord_dt,
        'net_amt': net_amt,
        'ac_id': ac_id,
        'ac_nm': ac_nm,
        'billed': billed,
        'billdetails': billdetails,
        'chainid': chainid,
        'chainareanm': chainareanm,
        'saletype': saletype,
        'billpdf': billpdf,
        'assignconm': assignconm,
        'approvalstatus': approvalstatus,
        'ordpdf': ordpdf,
        'noorder': noorder,
        'bill_asm_approval_status': bill_asm_approval_status,
        'bill_asm_approval_dt': bill_asm_approval_dt,
        'bill_asm_approval_user': bill_asm_approval_user,
        'bill_account_approval_status': bill_account_approval_status,
        'bill_account_approval_dt': bill_account_approval_dt,
        'bill_account_approval_user': bill_account_approval_user,
        'bill_logistic_approval_status': bill_logistic_approval_status,
        'bill_logistic_approval_dt': bill_logistic_approval_dt,
        'bill_logistic_approval_user': bill_logistic_approval_user,
      };

  String toStringView() {
    return '$ac_nm'; // if you want to show id and speciality as string
  }
}
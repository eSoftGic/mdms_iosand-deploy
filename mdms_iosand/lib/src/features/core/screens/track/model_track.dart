// ignore_for_file: non_constant_identifier_names

class TrackModel {
  int? tbl_id;
  String? tran_type;
  int? ref_no;
  int? tran_type_id;
  String? tran_desc;
  String? tran_no;
  String? tran_dt;
  String? ord_dt;
  double? net_amt;
  int? ac_id;
  String? ac_nm;
  int? chain_id;
  String? chain_area_nm;
  String? billed;
  String? bill_tran_type;
  int? bill_ref_no;
  String? bill_tran_desc;
  String? bill_tran_no;
  String? bill_tran_dt;
  String? approval_tran_type;
  String? approval_type;
  String? approval_status;
  String? approval_date;
  String? user_nm;

  TrackModel(
      {this.tbl_id,
      this.tran_type,
      this.ref_no,
      this.tran_type_id,
      this.tran_desc,
      this.tran_no,
      this.tran_dt,
      this.ord_dt,
      this.net_amt,
      this.ac_id,
      this.ac_nm,
      this.chain_id,
      this.chain_area_nm,
      this.billed,
      this.bill_tran_type,
      this.bill_ref_no,
      this.bill_tran_desc,
      this.bill_tran_no,
      this.bill_tran_dt,
      this.approval_tran_type,
      this.approval_type,
      this.approval_status,
      this.approval_date,
      this.user_nm});

  TrackModel.fromJson(Map<String, dynamic> json) {
    tbl_id = json['TBL_ID'];
    tran_type = json['TRAN_TYPE'] ?? 'ORD';
    ref_no = json['REF_NO'] ?? 0;
    tran_type_id = json['TRAN_TYPE_ID'] ?? 0;
    tran_desc = json['TRAN_DESC'] ?? '';
    tran_no = json['TRAN_NO'] ?? '0';
    tran_dt = json['TRAN_DT'] ?? '';
    ord_dt = json['ORD_DT'] ?? '';
    net_amt = json['NET_AMT'] ?? 0;
    ac_id = json['AC_ID'] ?? 0;
    ac_nm = json['AC_NM'] ?? '';
    chain_id = json['CHAIN_ID'] ?? 0;
    chain_area_nm = json['CHAIN_AREA_NM'] ?? '';
    billed = json['BILLED'] ?? 'N';
    bill_tran_type = json['BILL_TRAN_TYPE'] ?? '';
    bill_ref_no = json['BILL_REF_NO'] ?? 0;
    bill_tran_desc = json['BILL_TRAN_DESC'] ?? '';
    bill_tran_no = json['BILL_TRAN_NO'] ?? '0';
    bill_tran_dt = '00:00:00'; // json['BILL_TRAN_DT'] ??
    approval_tran_type = json['APPROVAL_TRAN_TYPE'] ?? '';
    approval_type = json['APPROVAL_TYPE'] ?? 'ORD';
    approval_status = json['APPROVAL_STATUS'] ?? '';
    approval_date = json['APPROVAL_DATE'] ?? '';
    user_nm = json['USER_NM'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TBL_ID'] = tbl_id;
    data['TRAN_TYPE'] = tran_type;
    data['REF_NO'] = ref_no;
    data['TRAN_TYPE_ID'] = tran_type_id;
    data['TRAN_DESC'] = tran_desc;
    data['TRAN_NO'] = tran_no;
    data['TRAN_DT'] = tran_dt;
    data['ORD_DT'] = ord_dt;
    data['NET_AMT'] = net_amt;
    data['AC_ID'] = ac_id;
    data['AC_NM'] = ac_nm;

    data['CHAIN_ID'] = chain_id;
    data['CHAIN_AREA_NM'] = chain_area_nm;
    data['BILLED'] = billed;
    data['BILL_TRAN_TYPE'] = bill_tran_type;
    data['BILL_REF_NO'] = bill_ref_no;
    data['BILL_TRAN_DESC'] = bill_tran_desc;
    data['BILL_TRAN_NO'] = bill_tran_no;
    data['BILL_TRAN_DT'] = bill_tran_dt;
    data['APPROVAL_TRAN_TYPE'] = approval_tran_type;
    data['APPROVAL_TYPE'] = approval_type;
    data['APPROVAL_STATUS'] = approval_status;
    data['APPROVAL_DATE'] = approval_date;
    data['USER_NM'] = user_nm;

    return data;
  }
}
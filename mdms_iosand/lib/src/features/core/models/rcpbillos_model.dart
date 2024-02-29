class PrtRcpBills {
  //Define
  final int? acid;
  final String? acnm;
  final String? billchqch;
  final String? trandt;
  final String? duedt;
  final String? trandesc;
  final int? trantypeid;
  final String? trantype;
  final int? refno;
  final int? entryno;
  final String? tranno;
  final String? acyear;
  final String? smannm;
  final double? netamt;
  final double? rcvdamt;
  final int? pendday;
  final String? paymode;
  final String? overcrtype;
  final String? duedtcrdays;
  final String? remark;
  double? entryadjamt;
  bool? checked;

  // Constructutor
  PrtRcpBills(
      {this.acid,
      this.acnm,
      this.billchqch,
      this.trandt,
      this.duedt,
      this.trandesc,
      this.trantypeid,
      this.trantype,
      this.refno,
      this.entryno,
      this.tranno,
      this.acyear,
      this.smannm,
      this.netamt,
      this.rcvdamt,
      this.pendday,
      this.paymode,
      this.overcrtype,
      this.duedtcrdays,
      this.remark,
      this.entryadjamt,
      this.checked});

  //Maping
  factory PrtRcpBills.fromJson(Map<String, dynamic> json) {
    return PrtRcpBills(
        acid: json['AC_ID'],
        acnm: json['AC_NM'],
        billchqch: json['BILLCHQCH'],
        trandt: json['TRAN_DT'],
        duedt: json['DUE_DT'],
        trandesc: json['TRAN_DESC'],
        trantypeid: json['TRAN_TYPE_ID'],
        trantype: json['TRAN_TYPE'],
        refno: json['REF_NO'],
        entryno: json['ENTRY_NO'],
        tranno: json['TRAN_NO'],
        acyear: json['AC_YEAR'],
        smannm: json['SMAN_NM'],
        netamt: json['NET_AMT'],
        rcvdamt: json['RCVD_AMT'],
        pendday: json['PENDDAY'],
        paymode: json['PAY_MODE'],
        overcrtype: json['OVER_CR_TYPE'],
        duedtcrdays: json['DUE_DT_CR_DAYS'],
        remark: json['REMARK'],
        entryadjamt: json['ENTRY_ADJ_AMT'],
        checked: json['ENTRY_ADJ_AMT'] > 0 ? true : false);
  }
}

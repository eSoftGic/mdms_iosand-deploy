class PrtReceipt {
  //Define
  final int? refno;
  final int? vchrno;
  final String? vchrdt;
  final int? acid;
  final int? smanid;
  final int? acbankid;
  final String? acbank;
  final int? acbranchid;
  final String? acbranch;
  final String? chqno;
  final String? chqdt;
  final double? rcvdamt;
  final double? discamt;
  final String? descrem;
  final int? companyid;
  final bool? iscollectionac;
  final String? acnm;
  final String? cqmode;

  // Constructutor
  PrtReceipt(
      {this.refno,
      this.vchrno,
      this.vchrdt,
      this.acid,
      this.smanid,
      this.acbankid,
      this.acbank,
      this.acbranchid,
      this.acbranch,
      this.chqno,
      this.chqdt,
      this.rcvdamt,
      this.discamt,
      this.descrem,
      this.companyid,
      this.iscollectionac,
      this.acnm,
      this.cqmode});

  //Maping
  factory PrtReceipt.fromJson(Map<String, dynamic> json) {
    return PrtReceipt(
      refno: json['REF_NO'],
      vchrno: json['VCHR_NO'],
      vchrdt: json['VCHR_DT'],
      acid: json['AC_ID'],
      smanid: json['SMAN_ID'],
      acbankid: json['AC_BANK_ID'],
      acbank: json['AC_BANK'],
      acbranchid: json['AC_BRANCH_ID'],
      acbranch: json['AC_BRANCH'],
      chqno: json['CHQ_NO'],
      chqdt: json['CHQ_DT'],
      rcvdamt: json['RCVD_AMT'],
      discamt: json['DISC_AMT'],
      descrem: json['DESC_REM'],
      companyid: json['COMPANY_ID'],
      iscollectionac: json['IS_COLLECTION_AC'],
      acnm: json['AC_NM'],
      cqmode: (json['AC_BANK_ID'] == null || json['AC_BANK_ID'] == 0)
          ? "CASH"
          : "CHEQUE",
    );
  }
}

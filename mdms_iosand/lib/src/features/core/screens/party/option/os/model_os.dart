class PrtOs {
  //Define
  final int? acid;
  final String? accode;
  final String? acnm;
  final String? billchqch;
  final String? duedt;
  final double? netamt;
  final int? pendday;
  final double? rcvdamt;
  final String? trandesc;
  final String? trandt;
  final String? tranno;
  final double? penamt;
  final String? descrem;

  // Constructutor
  PrtOs(
      {this.acid,
      this.accode,
      this.acnm,
      this.billchqch,
      this.duedt,
      this.netamt,
      this.pendday,
      this.rcvdamt,
      this.trandesc,
      this.trandt,
      this.tranno,
      this.penamt,
      this.descrem});

  //Maping
  factory PrtOs.fromJson(Map<String, dynamic> json) {
    return PrtOs(
        acid: json['AC_ID'],
        accode: json['AC_CODe'],
        acnm: json['AC_NM'],
        billchqch: json['BILLCHQCH'],
        duedt: json['DUE_DT'],
        netamt: json['NET_AMT'],
        pendday: json['PENDDAY'],
        rcvdamt: json['RCVD_AMT'],
        trandesc: json['TRAN_DESC'],
        trandt: json['TRAN_DT'],
        tranno: json['TRAN_NO'],
        penamt: json['PENAMT'] ?? 0,
        descrem: json['REMARK']);
  }
}
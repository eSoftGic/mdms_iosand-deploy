class BookModel {
  //Define
  final String? trandesc;
  final int? trantypeid;
  final String? companysel;
  final String? taxretail;
  final int? crdays;
  final double? crrs;
  final int? crbills;
  final double? osamt;
  final int? osdays;
  final int? osbill;
  final double? maxordamt;
  final String? overcrtype;
  final String? todayorddet;

  BookModel(
      {this.trandesc,
      this.trantypeid,
      this.companysel,
      this.taxretail,
      this.crdays,
      this.crrs,
      this.crbills,
      this.osamt,
      this.osdays,
      this.osbill,
      this.maxordamt,
      this.overcrtype,
      this.todayorddet});

  //Maping
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      trandesc: json['TRAN_DESC'],
      trantypeid: json["TRAN_TYPE_ID"] ?? 0,
      companysel: json["COMPANY_SEL"],
      taxretail: json["TAX_RETAIL"],
      crdays: json["CR_DAYS"],
      crrs: json["CR_RS"],
      crbills: json["CR_BILLS"],
      osamt: json["OSAMT"],
      osdays: json["OSDAYS"],
      osbill: json["OSBILL"],
      maxordamt: json["MAX_ORD_AMT"],
      overcrtype: json["OVER_CR_TYPE"],
      todayorddet: json['TODAY_ORDER_DETAIL'],
    );
  }
}
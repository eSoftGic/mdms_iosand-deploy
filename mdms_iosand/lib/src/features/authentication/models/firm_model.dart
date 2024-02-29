class Firm {
  //Define
  final int? coid;
  final String? conm;
  final int? rtwithtax;
  final String? itmsearchmethod;
  final String? partysearchmethod;
  final int? noorderoption;

  Firm(
      {this.coid,
      this.conm,
      this.rtwithtax,
      this.itmsearchmethod,
      this.partysearchmethod,
      this.noorderoption});

  //Maping
  factory Firm.fromJson(Map<String, dynamic> json) {
    return Firm(
      coid: json['CO_ID'],
      conm: json["CO_NM"],
      rtwithtax: json["RATE_INCL_VAT"],
      itmsearchmethod: json['ITEM_SEARCH_METHOD'] ?? "CONTAINS",
      partysearchmethod: json['PARTY_SEARCH_METHOD'] ?? "CONTAINS",
      noorderoption: json['NO_ORDER_OPTION'] ?? 0,
    );
  }
}
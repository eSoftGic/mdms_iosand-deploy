class ChainModel {
  //Define
  final int? chainid;
  final int? acid;
  final String? acnm;
  final String? areanm;
  final String? addr;
  final int? distanckm;
  final String? gstin;
  final String? gstinregdt;
  final int? stateid;
  final String? saletype;

  ChainModel(
      {this.chainid,
      this.acid,
      this.acnm,
      this.areanm,
      this.addr,
      this.distanckm,
      this.gstin,
      this.gstinregdt,
      this.stateid,
      this.saletype});

  //Maping
  factory ChainModel.fromJson(Map<String, dynamic> json) {
    return ChainModel(
        chainid: json["CHAIN_ID"],
        acid: json["AC_ID"],
        acnm: json["AC_NM"],
        areanm: json["AREA_NM"],
        addr: json["ADDR"],
        distanckm: json["DISTANCE_KM"],
        gstin: json["GSTIN"],
        gstinregdt: json["GSTIN_REG_DT"],
        stateid: json["STATE_ID"],
        saletype: json["SALE_TYPE"]);
  }
}

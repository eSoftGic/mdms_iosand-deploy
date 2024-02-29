class AcYear {
  //Define
  final String? coyear;
  final String? codbnm;
  final String? acstdt;
  final String? acendt;
  final String? acmaxdt;

  // Constructutor
  AcYear({this.coyear, this.codbnm, this.acstdt, this.acendt, this.acmaxdt});
  //Maping
  factory AcYear.fromJson(Map<String, dynamic> json) {
    return AcYear(
        coyear: json['CoYear'],
        codbnm: json["CoDbNm"],
        acstdt: json['AcStDt'],
        acendt: json['AcEnDt'],
        acmaxdt: json['AcMaxDt']);
  }
}

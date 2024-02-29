class Transporter {
  //Define
  final int? transid;
  final String? transnm;
  // Constructutor
  Transporter({this.transid, this.transnm});
  //Maping
  factory Transporter.fromJson(Map<String, dynamic> json) {
    return Transporter(
        transid: json['TRANSPORTER_ID'], transnm: json["TRANSPORTER_NM"]);
  }
}

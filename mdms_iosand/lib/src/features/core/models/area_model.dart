class Area {
  //Define
  final int? areaid;
  final String? areanm;
  final String? areact;
  final int? areactid;
  // Constructutor
  Area({this.areaid, this.areanm, this.areact, this.areactid});
  //Maping
  factory Area.fromJson(Map<String, dynamic> json) {
    return Area(
        areaid: json['AREA_ID'],
        areanm: json["AREA_NM"],
        areact: json['CITY'],
        areactid: json['CITY_ID']);
  }
}

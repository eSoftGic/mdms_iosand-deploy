class Country {
  //Define
  final int? countryid;
  final String? countrynm;
  // Constructutor
  Country({this.countryid, this.countrynm});
  //Maping
  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
        countryid: json['COUNTRY_ID'], countrynm: json["COUNTRY_NM"]);
  }
}

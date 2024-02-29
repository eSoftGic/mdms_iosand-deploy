class BrandModel {
  //Define
  final String? brandnm;
  final int? brandid;
  final String? brandimage;
  BrandModel({this.brandnm, this.brandid, this.brandimage});

  //Maping
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      brandnm: json['BRAND_NM'],
      brandid: json["BRAND_ID"],
      brandimage: json["BRAND_IMAGE"] ?? "",
    );
  }
}
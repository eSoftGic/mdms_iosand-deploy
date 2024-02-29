class CompanyModel {
  //Define
  final String? companynm;
  final int? companyid;

  CompanyModel({this.companynm, this.companyid});

  //Maping
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      companynm: json['COMPANY_NM'],
      companyid: json["COMPANY_ID"],
    );
  }
}

class PrtUser {
  //Define
  final int? acid;
  final String? acnm;
  final String? mobileno;
  final String? beatnm;
  final int? branchid;
  final String? saletype;
  final bool? anychain;

  // Constructutor
  PrtUser(
      {this.acid,
        this.acnm,
        this.mobileno,
        this.beatnm,
        this.branchid,
        this.saletype,
        this.anychain});

  //Maping
  factory PrtUser.fromJson(Map<String, dynamic> json) {
    return PrtUser(
        acid: json['AC_ID'],
        acnm: json['AC_NM'],
        mobileno: json['MOBILE_NO'],
        beatnm: json['BEAT_NM'],
        branchid: json['BRANCH_ID'],
        saletype: json['SALE_TYPE'],
        anychain: json['ANY_CHAIN']);
  }
}
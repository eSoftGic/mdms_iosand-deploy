// ignore_for_file: non_constant_identifier_names
class PartyModel {
  //Define
  final int? ac_id;
  final String? ac_nm;
  final String? mobile;
  final String? beatnm;
  final int? branch_id;
  final String? sale_type;
  final bool? anychain;
  final String? classnm;
  final String? typenm;
  final String? addr;
  final String? routeSr;
  final String? ordstatus;
  final String? orddetail;
  final String? prt_image_url;
  final String? prt_lat;
  final String? prt_lon;

  // Constructutor
  PartyModel(
      {this.ac_id,
      this.ac_nm,
      this.mobile,
      this.beatnm,
      this.branch_id,
      this.sale_type,
      this.anychain,
      this.classnm,
      this.typenm,
      this.addr,
      this.routeSr,
      this.ordstatus,
      this.orddetail,
      this.prt_image_url,
      this.prt_lat,
      this.prt_lon});

  //Maping
  factory PartyModel.fromJson(Map<String, dynamic> json) {
    return PartyModel(
        ac_id: json['AC_ID'],
        ac_nm: json['AC_NM'],
        mobile: json['MOBILE_NO'],
        beatnm: json['BEAT_NM'],
        branch_id: json['BRANCH_ID'],
        sale_type: json['SALE_TYPE'],
        anychain: json['ANY_CHAIN'],
        classnm: json['AC_CLASS_NM'],
        typenm: json['AC_TYPE_NM'],
        addr: json['ADDR'],
        routeSr: json['ROUTE_SR'],
        ordstatus: json['ORDER_STATUS'],
        orddetail: json['ORDER_DETAIL'],
        prt_image_url: json['PARTY_IMAGE_URL'],
        prt_lat: '0.0',
        prt_lon: '0.0');
  }
}

class DrpDnModel {
  final int? ac_id;
  final String? ac_nm;
  final String? mobile;
  final String? beatnm;
  final String? prt_image_url;

  DrpDnModel(
      {this.ac_id, this.ac_nm, this.mobile, this.beatnm, this.prt_image_url});

  factory DrpDnModel.fromJson(Map<String, dynamic> json) {
    return DrpDnModel(
      ac_id: json["ac_id"] ?? 0,
      ac_nm: json["ac_nm"] ?? '',
      mobile: json["mobile_no"] ?? '',
      beatnm: json["beatnm"] ?? '',
      prt_image_url: json["prt_image_url"] ?? '',
    );
  }

  static List<DrpDnModel> fromJsonList(List list) {
    //if (list == null) return null;
    return list.map((item) => DrpDnModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$ac_id $ac_nm';
  }

  ///this method will prevent the override of toString
  bool userFilterByMobile(String filter) {
    return mobile.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(DrpDnModel model) {
    return ac_id == model.ac_id;
  }

  @override
  String toString() => ac_nm!;
}

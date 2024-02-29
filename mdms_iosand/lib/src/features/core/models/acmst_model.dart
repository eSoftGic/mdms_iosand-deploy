// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AcMstModel {
  int? acmstid;
  String? acmstname;
  String? acgrpname;
  int? acgrpid;
  String? acmstcode;
  double? acopn;
  String? crdbtype;
  String? statenm;
  String? statecd;
  int? stateid;
  String? countrynm;
  int? countryid;
  String? add1;
  String? add2;
  String? add3;
  String? add4;
  String? city;
  String? pincode;
  String? landline;
  String? mobileno;
  String? conPer;
  String? gsttin;
  String? gstDt;
  String? pan;
  String? drgLic;
  String? foodLic;
  String? emailId;
  bool? inactive;
  String? inactivereason;
  String? routeSr;
  double? gpslat;
  double? gpslon;
  String? transportnm;
  int? transportid;
  String? beatnam;
  int? beatid;
  String? classnam;
  int? classid;
  String? typenam;
  int? typeid;
  String? banknam;
  int? bankid;
  String? branchnam;
  int? branchid;
  String? paynam;
  int? payid;
  int? distancekm;
  DateTime? gstRegDt;
  String? areanam;
  int? areaid;
  bool? diifshippadd;
  String? ship_statenm;
  String? ship_statecd;
  int? ship_stateid;
  String? ship_add1;
  String? ship_city;
  String? ship_pincode;
  String? ship_landline;
  String? ship_mobileno;
  String? ship_emailId;
  String? ship_conPer;
  String? ship_gsttin;
  DateTime? ship_gstRegDt;
  String? shipgstDt;
  int? ship_distancekm;

  // Constructutor  // = DateTime(2017, 07, 01, 0, 0);
  AcMstModel(
      {this.acmstname,
      this.acmstid,
      this.acgrpname,
      this.acgrpid,
      this.acmstcode,
      this.acopn,
      this.crdbtype,
      this.statenm,
      this.statecd,
      this.stateid,
      this.countrynm,
      this.countryid,
      this.add1,
      this.add2,
      this.add3,
      this.add4,
      this.city,
      this.pincode,
      this.landline,
      this.mobileno,
      this.conPer,
      this.gsttin,
      this.gstDt,
      this.pan,
      this.drgLic,
      this.foodLic,
      this.emailId,
      this.inactive,
      this.inactivereason,
      this.routeSr,
      this.gpslat,
      this.gpslon,
      this.transportnm,
      this.transportid,
      this.beatnam,
      this.beatid,
      this.classnam,
      this.classid,
      this.typenam,
      this.typeid,
      this.banknam,
      this.bankid,
      this.branchnam,
      this.branchid,
      this.paynam,
      this.payid,
      this.distancekm,
      this.gstRegDt,
      this.areanam,
      this.areaid,
      this.diifshippadd,
      this.ship_statenm,
      this.ship_statecd,
      this.ship_stateid,
      this.ship_add1,
      this.ship_city,
      this.ship_pincode,
      this.ship_landline,
      this.ship_mobileno,
      this.ship_emailId,
      this.ship_conPer,
      this.ship_gsttin,
      this.ship_gstRegDt,
      this.ship_distancekm,
      this.shipgstDt});

  //Maping

  factory AcMstModel.fromJson(Map<String, dynamic> json) {
    return AcMstModel(
        acmstname: json['ac_nm'],
        acmstid: json['ac_id'],
        acgrpname: json['grp_nm'],
        acgrpid: json['grp_id'],
        acmstcode: json['ac_code'],
        acopn: json['open_bal'],
        crdbtype: json['open_bal_crdb'],
        statenm: json['state_nm'],
        statecd: json['state_code'],
        stateid: json['state_id'],
        countrynm: json['country_nm'],
        countryid: json['country_id'],
        add1: json['add_1'],
        add2: json['add_2'],
        add3: json['add_3'],
        add4: json['add_4'],
        city: json['city'],
        pincode: json['pin'],
        landline: json['phone_no'],
        mobileno: json['mobile_no'],
        conPer: json['contact_nm'],
        gsttin: json['gstin'],
        gstDt: json['gstin_reg_dt'],
        pan: json['pan_no'],
        drgLic: json['drug_lic_no'],
        foodLic: json['food_lic_no'],
        emailId: json['email_id'],
        inactivereason: json['inactive_reason'],
        routeSr: json['route_sr'],
        gpslat: json['latitude'],
        gpslon: json['longitude'],
        transportnm: json['transporter_nm'],
        transportid: json['transporter_id'],
        beatnam: json['beat_nm'],
        beatid: json['beat_id'],
        classnam: json['ac_class_nm'],
        classid: json['class_id'],
        typenam: json['ac_type_nm'],
        typeid: json['type_id'],
        banknam: json['ac_bank'],
        bankid: json['bank_id'],
        branchnam: json['ac_branch'],
        branchid: json['branch_id'],
        paynam: json['pay_mode_desc'],
        payid: json['pay_mode'],
        distancekm: json['distance_km'],
        inactive: false,
        areanam: json['area_nm'],
        areaid: json['area_id'],
        diifshippadd: false,
        ship_statenm: json['ship_statenm'],
        ship_statecd: json['ship_statecd'],
        ship_stateid: json['ship_state_id'],
        ship_add1: json['ship_addr'],
        ship_city: json['ship_city'],
        ship_pincode: json['ship_pin'],
        ship_landline: json['ship_phone_no'],
        ship_mobileno: json['ship_mobile_no'],
        ship_emailId: json['ship_email_id'],
        ship_conPer: json['ship_contact_nm'],
        ship_gsttin: json['ship_gstin'],
        shipgstDt: json['ship_gstin_reg_dt'],
        ship_distancekm: json['ship_distance_km']);
  }
}
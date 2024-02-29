// ignore_for_file: non_constant_identifier_names

class AcMstDetail {
  //Define
  final int? ac_id;
  final String? ac_nm;
  final String? mobile;
  final String? beatnm;
  final int? branch_id;
  final double? open_bal;
  final double? clos_bal;
  final String? add_1;
  final String? add_2;
  final String? add_3;
  final String? add_4;
  final String? city;
  final String? pin;
  final String? phone_no;
  final String? email_id;
  final String? pan_no;
  final String? contact_nm;
  final int? bank_id;
  final int? bank_branch_id;
  final String? bank_ac_no;
  final String? bank_nm;
  final String? ifc_code;
  final String? bank_branch;
  final String? bank_ac_nm;
  final String? transport_nm;
  final String? debitor_type;
  final String? gstin;
  final double? latitude;
  final double? longitude;
  final double? osamt;
  final int? osbill;
  final int? osdays;
  final double? closamt;
  final String? sale_type;
  final double? orderamt;
  final int? ordercnt;
  final bool? anychain;
  // Constructutor
  AcMstDetail(
      {this.ac_id,
      this.ac_nm,
      this.mobile,
      this.beatnm,
      this.branch_id,
      this.open_bal,
      this.clos_bal,
      this.add_1,
      this.add_2,
      this.add_3,
      this.add_4,
      this.city,
      this.pin,
      this.phone_no,
      this.email_id,
      this.pan_no,
      this.contact_nm,
      this.bank_id,
      this.bank_branch_id,
      this.bank_ac_no,
      this.bank_nm,
      this.ifc_code,
      this.bank_branch,
      this.bank_ac_nm,
      this.transport_nm,
      this.debitor_type,
      this.gstin,
      this.latitude,
      this.longitude,
      this.osamt,
      this.osbill,
      this.osdays,
      this.closamt,
      this.sale_type,
      this.orderamt,
      this.ordercnt,
      this.anychain});

  //Maping
  factory AcMstDetail.fromJson(Map<String, dynamic> json) {
    return AcMstDetail(
      ac_id: json['AC_ID'],
      ac_nm: json['AC_NM'],
      mobile: json['MOBILE_NO'] ?? '',
      beatnm: json['BEAT_NM'] ?? '',
      branch_id: json['BRANCH_ID'],
      open_bal: json['OPEN_BAL'] ?? 0,
      clos_bal: json['CLOS_BAL'] ?? 0,
      add_1: json['ADD_1'] ?? '',
      add_2: json['ADD_2'] ?? '',
      add_3: json['ADD_3'] ?? '',
      add_4: json['ADD_4'] ?? '',
      city: json['CITY'] ?? '',
      pin: json['PIN'] ?? '',
      phone_no: json['PHONE_NO'] ?? '',
      email_id: json['EMAIL_ID'] ?? '',
      pan_no: json['PAN_NO'] ?? '',
      contact_nm: json['CONTACT_NM'] ?? '',
      bank_id: json['BANK_ID'] ?? 0,
      bank_branch_id: json['BRANCH_ID'] ?? 0,
      bank_ac_no: json['BANK_AC_NO'] ?? '',
      bank_nm: json['BANK_NM'] ?? '',
      ifc_code: json['IFC_CODE'] ?? '',
      bank_branch: json['BANK_BRANCH'] ?? '',
      bank_ac_nm: json['BANK_AC_NM'] ?? '',
      transport_nm: json['TRANSPORT_NM'] ?? '',
      debitor_type: json['DEBITOR_TYPE'] ?? '',
      gstin: json['GSTIN'] ?? '',
      latitude: json['LATITUDE'] ?? 0,
      longitude: json['LONGITUDE'] ?? 0,
      osamt: json['OSAMT'] ?? 0,
      osbill: json['OSBILL'] ?? 0,
      osdays: json['OSDAYS'] ?? 0,
      closamt: json['CLOSAMT'] ?? 0,
      sale_type: json['SALE_TYPE'] ?? '',
      orderamt: json['ORDERAMT'] ?? 0,
      ordercnt: json['ORDERCNT'] ?? 0,
      anychain: json['ANY_CHAIN'] ?? false,
    );
  }
}
// ignore_for_file: non_constant_identifier_names

class AcMstLenModel {
  int? ac_nm_len;
  int? ac_code_len;
  int? add_1_len;
  int? add_2_len;
  int? add_3_len;
  int? add_4_len;
  int? city_len;
  int? pin_len;
  int? phone_no_len;
  int? mobile_no_len;
  int? contact_nm_len;
  int? pan_no_len;
  int? drug_lic_no_len;
  int? food_lic_no_len;
  int? email_id_len;

  AcMstLenModel(
      {this.ac_nm_len,
      this.ac_code_len,
      this.add_1_len,
      this.add_2_len,
      this.add_3_len,
      this.add_4_len,
      this.city_len,
      this.pin_len,
      this.phone_no_len,
      this.mobile_no_len,
      this.contact_nm_len,
      this.pan_no_len,
      this.drug_lic_no_len,
      this.food_lic_no_len,
      this.email_id_len});

  factory AcMstLenModel.fromJson(Map<String, dynamic> json) {
    return AcMstLenModel(
        ac_nm_len: json['ac_nm_len'],
        ac_code_len: json['ac_code_len'],
        add_1_len: json['add_1_len'],
        add_2_len: json['add_2_len'],
        add_3_len: json['add_3_len'],
        add_4_len: json['add_4_len'],
        city_len: json['city_len'],
        pin_len: json['pin_len'],
        phone_no_len: json['phone_no_len'],
        mobile_no_len: json['mobile_no_len'],
        contact_nm_len: json['contact_nm_len'],
        pan_no_len: json['pan_no_len'],
        drug_lic_no_len: json['drug_lic_no_len'],
        food_lic_no_len: json['food_lic_no_len'],
        email_id_len: json['email_id_len']);
  }
}

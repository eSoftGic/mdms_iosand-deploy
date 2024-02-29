class Bank {
  //Define
  final int? bankid;
  final String? banknm;
  // Constructutor
  Bank({this.bankid, this.banknm});
  //Maping
  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(bankid: json['AC_BANK_ID'], banknm: json["AC_BANK"]);
  }
}

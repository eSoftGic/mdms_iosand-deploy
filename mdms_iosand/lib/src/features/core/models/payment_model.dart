class Payment {
  //Define
  final String? payid;
  final String? paynm;
  // Constructutor
  Payment({this.payid, this.paynm});
  //Maping
  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(payid: json['SEL_ID'], paynm: json["SEL_NM"]);
  }
}

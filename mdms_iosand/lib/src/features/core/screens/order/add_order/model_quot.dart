class QotData {
  //Define
  final int? newrefno;
  // Constructutor
  QotData({this.newrefno});
  //Maping
  factory QotData.fromJson(Map<String, dynamic> json) {
    return QotData(newrefno: json['NEW_REF_NO']);
  }
}
class ClassModel {
  //Define
  final int? classid;
  final String? classnm;
  // Constructutor
  ClassModel({this.classid, this.classnm});
  //Maping
  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
        classid: json['AC_CLASS_ID'], classnm: json["AC_CLASS_NM"]);
  }
}

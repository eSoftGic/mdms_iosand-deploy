class TypeModel {
  //Define
  final int? typeid;
  final String? typenm;
  // Constructutor
  TypeModel({this.typeid, this.typenm});
  //Maping
  factory TypeModel.fromJson(Map<String, dynamic> json) {
    return TypeModel(
        typeid: json['AC_TYPE_ID'], typenm: json["AC_TYPE_NM"]);
  }
}

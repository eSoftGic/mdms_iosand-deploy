class GroupModel {
  //Define
  final int? grpid;
  final String? grpnm;
  // Constructutor
  GroupModel({this.grpid, this.grpnm});
  //Maping
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(grpid: json['GRP_ID'], grpnm: json["GRP_NM"]);
  }
}

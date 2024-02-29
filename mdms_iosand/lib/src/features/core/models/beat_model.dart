class Beat {
  //Define
  final int? beatid;
  final String? beatnm;
  // Constructutor
  Beat({this.beatid, this.beatnm});
  //Maping
  factory Beat.fromJson(Map<String, dynamic> json) {
    return Beat(beatid: json['BEAT_ID'], beatnm: json["BEAT_NM"]);
  }
}

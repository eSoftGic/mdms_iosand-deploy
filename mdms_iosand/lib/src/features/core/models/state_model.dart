class IndiaState {
  //Define
  final int? stateid;
  final String? statenm;
  final String? statecode;
  // Constructutor
  IndiaState({this.stateid, this.statenm, this.statecode});
  //Maping
  factory IndiaState.fromJson(Map<String, dynamic> json) {
    return IndiaState(
        stateid: json['STATE_ID'],
        statenm: json["STATE_NM"],
        statecode: json['STATE_CODE']);
  }
}

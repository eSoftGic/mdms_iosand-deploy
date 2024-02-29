// ignore_for_file: equal_keys_in_map

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String? phoneno;
  final String? deviceid;
  final String? fbauid;
  final String? email;
  final String? password;
  final String? username;
  final String? useruid;
  final String? baseurl;
  final String? defcomp;
  final String? defacyr;
  final String? defbrn;
  final String? defdmsdb;
  final String? userimage;
  final String? usertype;
  final String? userlstlogin;
  final String? appfor;
  final String? amcupto;

  /// Constructor
  const UserModel({
    this.id,
    required this.phoneno,
    required this.deviceid,
    this.fbauid,
    this.email,
    this.password,
    this.username,
    this.useruid,
    this.baseurl,
    this.defcomp,
    this.defacyr,
    this.defbrn,
    this.defdmsdb,
    this.userimage,
    this.usertype,
    this.userlstlogin,
    this.appfor,
    this.amcupto,
  });

  /// convert model to Json structure so that you can it to store data in Firesbase
  toJson() {
    return {
      "DeviceId": deviceid,
      "PhoneNo": phoneno,
      "FbaUid": fbauid,
      "Email": email,
      "Password": password,
      "UserName": username,
      "UserId": useruid,
      "BaseUrl": baseurl,
      "DefComp": defcomp,
      "DefAcYr": defacyr,
      "DefBrn": defbrn,
      "DefDmsDb": defdmsdb,
      "UserImage": userimage,
      "UserName": username,
      "UserType": usertype,
      "UserLstLogin": userlstlogin,
      "AppFor": appfor,
      "AmcUpto": amcupto,
    };
  }

  /// Map Json oriented document snapshot from Firebase to UserModel
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      deviceid: data["DeviceId"],
      fbauid: data["FbaUid"],
      phoneno: data["PhoneNo"],
      email: data["Email"],
      password: data["Password"],
      username: data["UserName"],
      useruid: data["UserId"],
      baseurl: data["BaseUrl"],
      defcomp: data["DefComp"],
      defacyr: data["DefAcYr"],
      defbrn: data["DefBrn"],
      defdmsdb: data["DefDmsDb"],
      userimage: data["UserImage"],
      usertype: data["UserType"],
      userlstlogin: data["UserLstLogin"],
      appfor: data["AppFor"],
      amcupto: data["AmcUpto"],
    );
  }
}
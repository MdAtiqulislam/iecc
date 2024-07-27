// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

import 'package:iecc/app/data/user_data_model.dart';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  final String? msg;
  final bool? status;
  final UserDataModel? data;

  UserInfoModel({
    this.msg,
    this.status,
    this.data,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : UserDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}


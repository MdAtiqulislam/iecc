// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'package:iecc/app/data/user_data_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? msg;
  final bool? status;
  final String? apiToken;
  final UserDataModel? data;

  LoginModel({
    this.msg,
    this.status,
    this.apiToken,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    msg: json["msg"],
    status: json["status"],
    apiToken: json["api_token"],
    data: json["data"] == null ? null : UserDataModel.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "api_token": apiToken,
    "data": data?.toJson(),
  };
}


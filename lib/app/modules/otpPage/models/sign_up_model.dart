// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

import '../../../data/user_data_model.dart';


SignUpModel signUpModelFromJson(String str) => SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  final String? msg;
  final bool? status;
  final String? apiToken;
  final UserDataModel? data;

  SignUpModel({
    this.msg,
    this.status,
    this.apiToken,
    this.data,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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



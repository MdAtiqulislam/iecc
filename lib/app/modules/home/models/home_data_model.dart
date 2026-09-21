// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:iecc/app/data/user_data_model.dart';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  final String? msg;
  final bool? status;
  final Data? data;

  HomeDataModel({
    this.msg,
    this.status,
    this.data,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final UserDataModel? userInfo;
  final int? unreadNotificationCount;
  final String? qFormLink;

  Data({
    this.userInfo,
    this.unreadNotificationCount,
    this.qFormLink,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userInfo: json["user_info"] == null ? null : UserDataModel.fromJson(json["user_info"]),
    unreadNotificationCount: json["unread_notification_count"],
    qFormLink: json["q_form_link"],
  );

  Map<String, dynamic> toJson() => {
    "user_info": userInfo?.toJson(),
    "unread_notification_count": unreadNotificationCount,
    "q_form_link": qFormLink,
  };
}

class UserInfo {
  final int? id;
  final dynamic avatar;
  final String? name;
  final String? email;
  final int? status;
  final int? agentInfoId;
  final int? officeId;
  final String? phone;
  final dynamic mobile;
  final int? country;
  final String? city;
  final String? sourceOccupation;

  UserInfo({
    this.id,
    this.avatar,
    this.name,
    this.email,
    this.status,
    this.agentInfoId,
    this.officeId,
    this.phone,
    this.mobile,
    this.country,
    this.city,
    this.sourceOccupation,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    avatar: json["avatar"],
    name: json["name"],
    email: json["email"],
    status: json["status"],
    agentInfoId: json["agent_info_id"],
    officeId: json["office_id"],
    phone: json["phone"],
    mobile: json["mobile"],
    country: json["country"],
    city: json["city"],
    sourceOccupation: json["source_occupation"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "avatar": avatar,
    "name": name,
    "email": email,
    "status": status,
    "agent_info_id": agentInfoId,
    "office_id": officeId,
    "phone": phone,
    "mobile": mobile,
    "country": country,
    "city": city,
    "source_occupation": sourceOccupation,
  };
}

// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

import 'dart:convert';

UserDataModel userDataModelFromJson(String str) => UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  final int? id;
  final String? avatar;
  final String? name;
  final String? email;
  final dynamic status;
  final int? agentInfoId;
  final dynamic officeId;
  final String? phone;
  final String? mobile;
  final dynamic country;
  final String? city;
  final dynamic sourceOccupation;
  final dynamic estimateEarning;
  final dynamic currency;
  final dynamic phoneCountryId;

  UserDataModel({
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
    this.estimateEarning,
    this.currency,
    this.phoneCountryId,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
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
    estimateEarning: json["estimate_earning"],
    currency: json["currency"],
    phoneCountryId: json["phone_country_id"],
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
    "estimate_earning": estimateEarning,
    "currency": currency,
    "phone_country_id": phoneCountryId,
  };
}

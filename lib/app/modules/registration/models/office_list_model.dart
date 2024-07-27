// To parse this JSON data, do
//
//     final officeListModel = officeListModelFromJson(jsonString);

import 'dart:convert';

OfficeListModel officeListModelFromJson(String str) => OfficeListModel.fromJson(json.decode(str));

String officeListModelToJson(OfficeListModel data) => json.encode(data.toJson());

class OfficeListModel {
  final String? msg;
  final bool? status;
  final List<SingleOffice>? data;

  OfficeListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory OfficeListModel.fromJson(Map<String, dynamic> json) => OfficeListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? [] : List<SingleOffice>.from(json["data"]!.map((x) => SingleOffice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleOffice {
  final int? id;
  final String? name;
  final String? address;
  final String? city;
  final dynamic parsedWorkingHour;
  final dynamic contactData;

  SingleOffice({
    this.id,
    this.name,
    this.address,
    this.city,
    this.parsedWorkingHour,
    this.contactData,
  });

  factory SingleOffice.fromJson(Map<String, dynamic> json) => SingleOffice(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    parsedWorkingHour: json["parsed_working_hour"],
    contactData: json["contact_data"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "city": city,
    "parsed_working_hour": parsedWorkingHour,
    "contact_data": contactData,
  };
}

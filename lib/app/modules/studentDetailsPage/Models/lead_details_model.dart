// To parse this JSON data, do
//
//     final leadDetailsModel = leadDetailsModelFromJson(jsonString);

import 'dart:convert';

LeadDetailsModel leadDetailsModelFromJson(String str) => LeadDetailsModel.fromJson(json.decode(str));

String leadDetailsModelToJson(LeadDetailsModel data) => json.encode(data.toJson());

class LeadDetailsModel {
  final String? msg;
  final bool? status;
  final LeadDetailsData? data;

  LeadDetailsModel({
    this.msg,
    this.status,
    this.data,
  });

  factory LeadDetailsModel.fromJson(Map<String, dynamic> json) => LeadDetailsModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : LeadDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class LeadDetailsData {
  final int? id;
  final String? givenName;
  final String? familyName;
  final String? email;
  final String? mobile;
  final dynamic referalNo;
  final SupervisorInfo? counsellorInfo;
  final SupervisorInfo? managerInfo;
  final List<AppliedUniversityModel>? totalApplied;

  LeadDetailsData({
    this.id,
    this.givenName,
    this.familyName,
    this.email,
    this.mobile,
    this.referalNo,
    this.counsellorInfo,
    this.managerInfo,
    this.totalApplied,
  });

  factory LeadDetailsData.fromJson(Map<String, dynamic> json) => LeadDetailsData(
    id: json["id"],
    givenName: json["given_name"],
    familyName: json["family_name"],
    email: json["email"],
    mobile: json["mobile"],
    referalNo: json["referal_no"],
    counsellorInfo: json["counselor"] == null ? null : SupervisorInfo.fromJson(json["counselor"]),
    managerInfo: json["manager"] == null ? null : SupervisorInfo.fromJson(json["manager"]),
    totalApplied: json["total_applied"] == null ? [] : List<AppliedUniversityModel>.from(json["total_applied"]!.map((x) => AppliedUniversityModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "given_name": givenName,
    "family_name": familyName,
    "email": email,
    "mobile": mobile,
    "referal_no": referalNo,
    "counselor": counsellorInfo?.toJson(),
    "manager": counsellorInfo?.toJson(),
    "total_applied": totalApplied == null ? [] : List<dynamic>.from(totalApplied!.map((x) => x.toJson())),
  };
}

class SupervisorInfo {
  final int? id;
  final String? name;
  final String? email;
  final dynamic phone;
  final dynamic mobile;

  SupervisorInfo({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.mobile,
  });

  factory SupervisorInfo.fromJson(Map<String, dynamic> json) => SupervisorInfo(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    mobile: json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "mobile": mobile,
  };
}

class AppliedUniversityModel {
  final int? id;
  final String? startDate;
  final int? country;
  final String? university;
  final String? level;
  final String? subject;
  final String? appStatus;
  final String? studentDecision;
  final dynamic depositPaid;
  final List<Offer>? offers;

  AppliedUniversityModel({
    this.id,
    this.startDate,
    this.country,
    this.university,
    this.level,
    this.subject,
    this.appStatus,
    this.depositPaid,
    this.offers,
    this.studentDecision
  });

  factory AppliedUniversityModel.fromJson(Map<String, dynamic> json) => AppliedUniversityModel(
    id: json["id"],
    startDate: json["start_date"],
    country: json["country"],
    university: json["university"],
    level: json["level"],
    subject: json["subject"],
    appStatus: json["app_status"],
    studentDecision: json["student_decision"],
    depositPaid: json["deposit_paid"],
    offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "start_date": startDate,
    "country": country,
    "university": university,
    "level": level,
    "subject": subject,
    "app_status": appStatus,
    "student_decision": studentDecision,
    "deposit_paid": depositPaid ,
    "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
  };
}

class Offer {
  final String? documentType;
  final dynamic purpose;
  final String? text;

  Offer({
    this.documentType,
    this.purpose,
    this.text,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    documentType: json["document_type"],
    purpose: json["purpose"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "document_type": documentType,
    "purpose": purpose,
    "text": text,
  };
}


// To parse this JSON data, do
//
//     final leadListModel = leadListModelFromJson(jsonString);

import 'dart:convert';

LeadListModel leadListModelFromJson(String str) => LeadListModel.fromJson(json.decode(str));

String leadListModelToJson(LeadListModel data) => json.encode(data.toJson());

class LeadListModel {
  final String? msg;
  final bool? status;
  final LeadListData? data;

  LeadListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory LeadListModel.fromJson(Map<String, dynamic> json) => LeadListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : LeadListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class LeadListData {
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? lastPage;
  final String? firstPageUrl;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final dynamic prevPageUrl;
  final String? path;
  final int? from;
  final int? to;
  final List<SingleLead>? data;

  LeadListData({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.firstPageUrl,
    this.lastPageUrl,
    this.nextPageUrl,
    this.prevPageUrl,
    this.path,
    this.from,
    this.to,
    this.data,
  });

  factory LeadListData.fromJson(Map<String, dynamic> json) => LeadListData(
    total: json["total"],
    perPage: json["per_page"],
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    firstPageUrl: json["first_page_url"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
    path: json["path"],
    from: json["from"],
    to: json["to"],
    data: json["data"] == null ? [] : List<SingleLead>.from(json["data"]!.map((x) => SingleLead.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "per_page": perPage,
    "current_page": currentPage,
    "last_page": lastPage,
    "first_page_url": firstPageUrl,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
    "path": path,
    "from": from,
    "to": to,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SingleLead {
  final int? id;
  final String? givenName;
  final String? familyName;
  final dynamic email;
  final dynamic mobile;
  final dynamic supervisorId;
  final dynamic gender;
  final dynamic notes;
  final dynamic nationalitiesId;
  final String? referalNo;
  final int? totalApplied;
  final int? totalOffer;
  final int? isJoined;
  final dynamic latestStartDate;
  final dynamic mobileCountryId;
  final dynamic saTaggingSourceId;
  final dynamic qForm;

  SingleLead({
    this.id,
    this.givenName,
    this.familyName,
    this.email,
    this.mobile,
    this.supervisorId,
    this.referalNo,
    this.totalApplied,
    this.totalOffer,
    this.isJoined,
    this.latestStartDate,
    this.gender,
    this.notes,
    this.nationalitiesId,
    this.mobileCountryId,
    this.saTaggingSourceId,
    this.qForm
  });

  factory SingleLead.fromJson(Map<String, dynamic> json) => SingleLead(
    id: json["id"],
    givenName: json["given_name"],
    familyName: json["family_name"],
    email: json["email"],
    mobile: json["mobile"],
    supervisorId: json["supervisor_id"],
    referalNo: json["referal_no"],
    totalApplied: json["total_applied"],
    totalOffer: json["total_offer"],
    isJoined: json["is_joined"],
    latestStartDate: json["latest_start_date"],
    gender: json["gender"],
    notes: json["notes"],
    nationalitiesId: json["nationalities_id"],
    mobileCountryId: json["mobile_country_id"],
    saTaggingSourceId: json["sa_tagging_source_id"],
    qForm: json["q_form"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "given_name": givenName,
    "family_name": familyName,
    "email": email,
    "mobile": mobile,
    "supervisor_id": supervisorId,
    "referal_no": referalNo,
    "total_applied": totalApplied,
    "total_offer": totalOffer,
    "is_joined": isJoined,
    "latest_start_date": latestStartDate,
    "gender": gender,
    "notes": notes,
    "nationalities_id": nationalitiesId,
    "mobile_country_id": mobileCountryId,
    "sa_tagging_source_id": saTaggingSourceId,
    "q_form": qForm,
  };
}


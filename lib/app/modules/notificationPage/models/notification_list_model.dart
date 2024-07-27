// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
  final String? msg;
  final bool? status;
  final NotificationData? data;

  NotificationListModel({
    this.msg,
    this.status,
    this.data,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
    msg: json["msg"],
    status: json["status"],
    data: json["data"] == null ? null : NotificationData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "status": status,
    "data": data?.toJson(),
  };
}

class NotificationData {
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
  final List<SingleNotificationModel>? data;

  NotificationData({
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

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
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
    data: json["data"] == null ? [] : List<SingleNotificationModel>.from(json["data"]!.map((x) => SingleNotificationModel.fromJson(x))),
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

class SingleNotificationModel {
  final int? id;
  final String? classType;
  final String? message;
  final dynamic readAt;

  SingleNotificationModel({
    this.id,
    this.classType,
    this.message,
    this.readAt,
  });

  factory SingleNotificationModel.fromJson(Map<String, dynamic> json) => SingleNotificationModel(
    id: json["id"],
    classType: json["class_type"],
    message: json["message"],
    readAt: json["read_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "class_type": classType,
    "message": message,
    "read_at": readAt,
  };
}

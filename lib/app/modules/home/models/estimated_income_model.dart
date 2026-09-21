// To parse this JSON data, do
//
//     final estimatedIncomeModel = estimatedIncomeModelFromJson(jsonString);

import 'dart:convert';

EstimatedIncomeModel estimatedIncomeModelFromJson(String str) => EstimatedIncomeModel.fromJson(json.decode(str));

String estimatedIncomeModelToJson(EstimatedIncomeModel data) => json.encode(data.toJson());

class EstimatedIncomeModel {
  final String? msg;
  final int? estimatedIncome;
  final int? totalLead;
  final int? leadHasOffer;
  final bool? status;

  EstimatedIncomeModel({
    this.msg,
    this.estimatedIncome,
    this.totalLead,
    this.leadHasOffer,
    this.status,
  });

  factory EstimatedIncomeModel.fromJson(Map<String, dynamic> json) => EstimatedIncomeModel(
    msg: json["msg"],
    estimatedIncome: json["estimated_income"],
    totalLead: json["total_lead"],
    leadHasOffer: json["lead_has_offer"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "msg": msg,
    "estimated_income": estimatedIncome,
    "total_lead": totalLead,
    "lead_has_offer": leadHasOffer,
    "status": status,
  };
}

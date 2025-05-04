import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlanModel {
  final String planId;
  final String planImage;
  final String planName;
  final String planRange;
  final String planDays;
  final String planProfit;
  final String planInvest;

  PlanModel({
    required this.planId,
    required this.planImage,
    required this.planName,
    required this.planRange,
    required this.planDays,
    required this.planProfit,
    required this.planInvest
  });

  Map<String, dynamic> toMap() {
    return {
      'planImage': planImage,
      'planName': planName,
      'planRange': planRange,
      'planDays': planDays,
      'planProfit': planProfit,
      'planInvest': planInvest
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map, String id) {
    return PlanModel(
      planId: id,
      planImage: map['planImage'],
      planName: map['planName'],
      planRange: map['planRange'],
      planDays: map['planDays'],
      planProfit: map['planProfit'],
      planInvest: map['planInvest'],
    );
  }

  Future<void> savePlanData() async {
    try {
      await FirebaseFirestore.instance.collection('plans').add(toMap());
    } catch (e) {
      if (kDebugMode) {
        print('Error saving plans data: $e');
      }
    }
  }

}
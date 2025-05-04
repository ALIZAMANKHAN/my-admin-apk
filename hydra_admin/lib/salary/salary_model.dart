import 'package:cloud_firestore/cloud_firestore.dart';

class SalaryModel {
  final String documentId;
  final String bankName;
  final String holderName;
  final String accountNumber;
  final String refCode;
  final double totalInvest;
  final String status;
  final String remarks;

  SalaryModel({
    required this.documentId,
    required this.bankName,
    required this.holderName,
    required this.accountNumber,
    required this.refCode,
    required this.totalInvest,
    required this.status,
    required this.remarks,
  });

  // Factory constructor for creating a WithdrawModel from Firestore data.
  factory SalaryModel.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    final documentId = document.id;
    return SalaryModel(
      documentId: documentId,
      bankName: data['bankName'] ?? '',
      holderName: data['holderName'] ?? '',
      accountNumber: data['accountNumber'] ?? '',
      refCode: data['refCode'] ?? '',
      totalInvest: data['totalInvest'] ?? 0.0,
      status: data['status'] ?? '',
      remarks: data['remarks'] ?? '',
    );
  }
}
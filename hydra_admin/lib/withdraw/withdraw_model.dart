import 'package:cloud_firestore/cloud_firestore.dart';

class WithdrawModel {
  final String documentId;
  final String bankName;
  final String holderName;
  final String accountNumber;
  final double amount;
  final double payAmount;
  final String status;
  final String remarks;

  WithdrawModel({
    required this.documentId,
    required this.bankName,
    required this.holderName,
    required this.accountNumber,
    required this.amount,
    required this.payAmount,
    required this.status,
    required this.remarks,
  });

  // Factory constructor for creating a WithdrawModel from Firestore data.
  factory WithdrawModel.fromDocument(DocumentSnapshot document) {
    final data = document.data() as Map<String, dynamic>;
    final documentId = document.id;
    return WithdrawModel(
      documentId: documentId,
      bankName: data['bankName'] ?? '',
      holderName: data['holderName'] ?? '',
      accountNumber: data['accountNumber'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      payAmount: (data['payAmount'] ?? 0.0).toDouble(),
      status: data['status'] ?? '',
      remarks: data['remarks'] ?? '',
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class DepositModel {
  final String id;
  final String accountNumber;
  final double amount;
  final String bankName;
  final String holderName;
  final String imagePath;
  double returnDeposit;
  bool isApproved;
  final String refNumber;
  final String status;
  final String remarks;
  final String uid;

  DepositModel({
    required this.id,
    required this.accountNumber,
    required this.amount,
    required this.bankName,
    required this.holderName,
    required this.imagePath,
    this.returnDeposit = 0.0,
    this.isApproved = false,
    required this.refNumber,
    required this.status,
    required this.remarks,
    required this.uid,
  });

  // Constructor to create a DepositModel from a Firestore DocumentSnapshot
  factory DepositModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return DepositModel(
      id: snapshot.id,
      accountNumber: data['accountNumber'] ?? '',
      amount: (data['amount'] ?? 0.0).toDouble(),
      bankName: data['bankName'] ?? '',
      holderName: data['holderName'] ?? '',
      imagePath: data['imagePath'] ?? '',
      refNumber: data['refNumber'] ?? '',
      status: data['status'] ?? '',
      remarks: data['remarks'] ?? '',
      uid: data['uid'] ?? '',
    );
  }
}
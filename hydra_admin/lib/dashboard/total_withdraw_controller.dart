import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../withdraw/withdraw_model.dart';

class TotalWithdrawController extends GetxController {

  RxDouble totalWithdraw = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  void init() {
    listenToWithdraws();
  }

  void listenToWithdraws() {
    FirebaseFirestore.instance.collection('withdraws').snapshots().listen((querySnapshot) {
      // Convert the query snapshot to a list of WithdrawModel
      final withdraws = querySnapshot.docs.map((doc) => WithdrawModel.fromDocument(doc)).toList();

      // Calculate the total withdraw amount
      totalWithdraw.value = withdraws.map((withdraw) => withdraw.amount).fold(0, (a, b) => a + b);

      // Update the total withdraw in Firestore
      updateTotalWithdrawInFirestore();
    });
  }

  Future<void> updateTotalWithdrawInFirestore() async {
    // Get a reference to the Firestore document where you want to store the total withdraw
    final documentReference = FirebaseFirestore.instance.collection('totalWithdraw').doc('total');

    try {
      await documentReference.set({'totalWithdraw': totalWithdraw.value}, SetOptions(merge: true));
    } catch (error) {
      // Handle errors, e.g., log them
      if (kDebugMode) {
        print('Error updating total withdraw in Firestore: $error');
      }
    }
  }
}
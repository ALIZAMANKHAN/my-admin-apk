import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../deposit/deposit_model.dart';

class TotalDepositController extends GetxController {

  RxDouble totalDeposit = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAndCalculateTotalDeposit();
  }

  // Method to calculate the total deposit amount
  void calculateTotalDeposit(List<DepositModel> deposits) {
    double total = 0.0;
    for (var deposit in deposits) {
      total += deposit.amount;
    }
    totalDeposit.value = total;
  }

  // Method to fetch deposits from Firestore and calculate the total
  Future<void> fetchAndCalculateTotalDeposit() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection('deposits').get();
      final deposits = querySnapshot.docs.map((doc) => DepositModel.fromSnapshot(doc)).toList();
      calculateTotalDeposit(deposits);

      // Store the total deposit in Firestore (replace 'totalDepositCollection' with the appropriate Firestore collection reference)
      await FirebaseFirestore.instance.collection('totalDeposit').doc('total').set({
        'totalDeposit': totalDeposit.value,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
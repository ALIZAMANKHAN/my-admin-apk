import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hydra_admin/dashboard/total_deposit_controller.dart';
import 'package:hydra_admin/dashboard/total_withdraw_controller.dart';

class TotalProfitController extends GetxController {

  RxDouble totalProfit = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    listenToTotalDepositAndTotalWithdraw();
  }

  void listenToTotalDepositAndTotalWithdraw() {
    final totalDepositController = Get.find<TotalDepositController>();
    final totalWithdrawController = Get.put(TotalWithdrawController());

    ever(totalDepositController.totalDeposit, (_) {
      // Calculate the total profit by subtracting total withdraw from total deposit
      totalProfit.value = totalDepositController.totalDeposit.value - totalWithdrawController.totalWithdraw.value;

      // Update the total profit in Firestore
      updateTotalProfitInFirestore();
    });

    ever(totalWithdrawController.totalWithdraw, (_) {
      // Calculate the total profit by subtracting total withdraw from total deposit
      totalProfit.value = totalDepositController.totalDeposit.value - totalWithdrawController.totalWithdraw.value;

      // Update the total profit in Firestore
      updateTotalProfitInFirestore();
    });
  }

  Future<void> updateTotalProfitInFirestore() async {
    final documentReference = FirebaseFirestore.instance.collection('totalProfit').doc('total');

    try {
      await documentReference.set({'totalProfit': totalProfit.value}, SetOptions(merge: true));
    } catch (error) {
      // Handle errors, e.g., log them
      if (kDebugMode) {
        print('Error updating total profit in Firestore: $error');
      }
    }
  }
}
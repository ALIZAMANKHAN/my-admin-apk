import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hydra_admin/withdraw/withdraw_model.dart';

class WithdrawController extends GetxController {

  RxList<WithdrawModel> withdraws = <WithdrawModel>[].obs;

  Future<void> fetchWithdraws() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('withdraws').get();

    withdraws.assignAll(
      snapshot.docs.map(
            (doc) => WithdrawModel.fromDocument(doc), // Pass the document to the factory constructor.
      ),
    );
  }

  Future<void> approveWithdraw(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('withdraws').doc(documentId).update({'status': 'Approved'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> rejectWithdraw(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('withdraws')
          .doc(documentId)
          .update({'status': 'Rejected'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> deleteWithdraw(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('withdraws')
          .doc(documentId)
          .delete();
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting document: $error');
      }
    }
  }

  Future<void> remarks(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('withdraws')
          .doc(documentId)
          .update({'remarks': 'Contact to Customer Services'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating remarks: $error');
      }
    }
  }

  Future<void> confirm(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('withdraws')
          .doc(documentId)
          .update({'remarks': 'Confirmed'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating remarks: $error');
      }
    }
  }

}
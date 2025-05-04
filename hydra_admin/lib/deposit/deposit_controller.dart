import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';

import 'deposit_model.dart';

class DepositController extends GetxController {

  TextEditingController returnDeposit = TextEditingController();

  var deposits = <DepositModel>[].obs;

  Future<void> fetchDeposits() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('deposits')
          .get();

      final box = GetStorage();

      deposits.value = querySnapshot.docs
          .map((doc) {
        final deposit = DepositModel.fromSnapshot(doc);
        // Retrieve the approval status from local storage using the deposit's id
        final isApproved = box.read<bool>('deposit_${deposit.id}_isApproved') ?? false;
        deposit.isApproved = isApproved;
        return deposit;
      })
          .toList();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching deposits: $e');
      }
    }
  }

  void approveDeposit(int index) async {
    try {
      final deposit = deposits[index];

      // Check if the deposit is already approved
      if (deposit.isApproved) {
        return; // Do nothing if it's already approved
      }

      // Calculate the new return deposit value
      final double newReturnDeposit = double.tryParse(returnDeposit.text) ?? 0.0;

      // Reference to the user's document in the 'users' collection
      final userQuerySnapshot = await FirebaseFirestore.instance.collection('users').get();

      if (userQuerySnapshot.docs.isNotEmpty) {
        final userId = deposit.uid; // Assuming DepositModel has a uid property

        // Reference to the 'returns' collection
        final returnsCollectionRef = FirebaseFirestore.instance.collection('returns');

        // Reference to the user's document in the 'returns' collection
        final returnDocRef = returnsCollectionRef.doc(userId);

        // Retrieve the existing return deposit value
        final returnDoc = await returnDocRef.get();
        final existingReturnDeposit = returnDoc.exists ? returnDoc.data()!['returnDeposit'] ?? 0.0 : 0.0;

        // Calculate the total return deposit value (existing + new)
        final totalReturnDeposit = existingReturnDeposit + newReturnDeposit;

        // Update the 'returnDeposit' value in the 'returns' document
        await returnDocRef.set({
          'returnDeposit': totalReturnDeposit,
          'approved': true,
        });

        // Update the 'isApproved' property in the DepositModel
        deposit.isApproved = true;

        // Store the approval status in local storage using the deposit's id
        final box = GetStorage();
        box.write('deposit_${deposit.id}_isApproved', true);

        // Update the list of deposits
        deposits[index] = deposit; // Update the list

        returnDeposit.clear();

        approveStatus(deposit.id);
        confirm(deposit.id);

        Get.snackbar(
          'Return',
          'Returned Successfully',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }

  Future<void> approveStatus(String id) async {
    try {
      await FirebaseFirestore.instance.collection('deposits').doc(id).update({'status': 'Approved'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> rejectDeposit(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(documentId)
          .update({'status': 'Rejected'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> deleteDeposit(String documentId, String imagePath) async {
    try {
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(documentId)
          .delete();
      // Delete the image from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(imagePath);
      await storageRef.delete();
    } catch (error) {
      if (kDebugMode) {
        print('Error deleting document: $error');
      }
    }
  }

  Future<void> remarks(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(documentId)
          .update({'remarks': 'Contact to Customer Services'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating remarks: $error');
      }
    }
  }

  Future<void> confirm(String id) async {
    try {
      await FirebaseFirestore.instance
          .collection('deposits')
          .doc(id)
          .update({'remarks': 'Confirmed'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating remarks: $error');
      }
    }
  }

}
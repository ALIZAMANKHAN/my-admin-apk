import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hydra_admin/salary/salary_model.dart';

class SalaryController extends GetxController {

  RxList<SalaryModel> salary = <SalaryModel>[].obs;

  Future<void> fetchSalary() async {
    final QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('salary').get();

    salary.assignAll(
      snapshot.docs.map(
            (doc) => SalaryModel.fromDocument(doc), // Pass the document to the factory constructor.
      ),
    );
  }

  Future<void> approveSalary(String documentId) async {
    try {
      await FirebaseFirestore.instance.collection('salary').doc(documentId).update({'status': 'Approved'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> rejectSalary(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('salary')
          .doc(documentId)
          .update({'status': 'Rejected'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating status: $error');
      }
    }
  }

  Future<void> deleteSalary(String documentId) async {
    try {
      await FirebaseFirestore.instance
          .collection('salary')
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
          .collection('salary')
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
          .collection('salary')
          .doc(documentId)
          .update({'remarks': 'Confirmed'});
    } catch (error) {
      if (kDebugMode) {
        print('Error updating remarks: $error');
      }
    }
  }

}
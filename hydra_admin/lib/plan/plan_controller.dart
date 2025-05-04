import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:hydra_admin/plan/plan_model.dart';

class PlanController extends GetxController{

  RxList<PlanModel> plansList = <PlanModel>[].obs;
  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxString selectedImagePath = ''.obs;

  final nameController = TextEditingController();
  final planRangeController = TextEditingController();
  final planDaysController = TextEditingController();
  final planProfitController = TextEditingController();
  final planInvestController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPlans();
  }

  Future<void> fetchPlans() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('plans').get();
      final List<PlanModel> plans = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PlanModel.fromMap(data, doc.id);
      }).toList();
      plansList.assignAll(plans);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching plans: $e');
      }
    }
  }

  Future<void> deletePlan(String planId, String planImage) async {
    try {
      await FirebaseFirestore.instance.collection('plans').doc(planId).delete();
      plansList.removeWhere((plan) => plan.planId == planId);

      // Delete the image from Firebase Storage
      final storageRef = FirebaseStorage.instance.refFromURL(planImage);
      await storageRef.delete();

      fetchPlans();
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting plan: $e');
      }
    }
  }

  void pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      Get.snackbar(
          'Error',
          'No Image Selected',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white
      );
    }
  }

  void savePlan() async {
    String planName = nameController.text;
    String planRange = planRangeController.text;
    String planDays = planDaysController.text;
    String planProfit = planProfitController.text;
    String planInvest = planInvestController.text;
    String planImage = selectedImagePath.value;

    // Create a reference to the Firebase Storage location where the image will be uploaded.
    final firebase_storage.Reference storageReference =
    firebase_storage.FirebaseStorage.instance.ref('plans/$planName-${DateTime.now().millisecondsSinceEpoch}.png');

    try {
      // Upload the image to Firebase Storage.
      await storageReference.putFile(File(planImage));

      // Create a DepositData object with the image URL obtained from Firebase Storage.
      String imageUrl = await storageReference.getDownloadURL();
      PlanModel planModel = PlanModel(
        planId: '',
        planImage: imageUrl,
        planName: planName,
        planRange: planRange,
        planDays: planDays,
        planProfit: planProfit,
        planInvest: planInvest
      );

      // Save the DepositData object to Firestore.
      await planModel.savePlanData();

      fetchPlans();
      resetState();

    } catch (e) {
      if (kDebugMode) {
        print('Error saving plan: $e');
      }
    }
  }

  void submit() async {
    try {
      if (formKey.currentState!.validate()) {
        loading.value = true;
        savePlan();
        Get.snackbar(
          'Add',
          'Plan Added Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void resetState() {
    nameController.clear();
    planRangeController.clear();
    planDaysController.clear();
    planProfitController.clear();
    planInvestController.clear();
    selectedImagePath.value = '';
    loading.value = false;
  }

}
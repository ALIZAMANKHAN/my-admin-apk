import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  RxBool loading = false.obs;
  RxBool isVisible = true.obs;

  void togglePassword() {
    isVisible.value = !isVisible.value;
  }

  Future<void> login() async {
    try {
      if (formKey.currentState!.validate()) {
        loading.value = true;

        // Retrieve user data from Firestore
        final DocumentSnapshot<Map<String, dynamic>> userData =
        await _firestore.collection('admin').doc('admin').get();

        if (userData.exists) {
          final username = userData.get('userName');
          final password = userData.get('password');

          // Check if username and password match
          if (username == userNameController.text &&
              password == passwordController.text) {
            // Sign in anonymously
            final UserCredential userCredential =
            await _auth.signInAnonymously();

            if (userCredential.user != null) {
              // Login successful, navigate to dashboard
              Get.offNamed('/dashboard');
              Get.snackbar(
                'Login',
                'Login Successfully',
                snackPosition: SnackPosition.BOTTOM,
                colorText: Colors.white,
                backgroundColor: Colors.green,
              );
            }
          } else {
            // Invalid credentials
            showErrorSnackbar('Invalid Credentials');
          }
        } else {
          // User data not found in Firestore
          showErrorSnackbar('User data not found');
        }
      }
    } catch (e) {
      showErrorSnackbar(e.toString());
    } finally {
      loading.value = false;
    }
  }

  void showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

}
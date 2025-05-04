import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashController extends GetxController {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    checkAuthentication();
  }

  void checkAuthentication() {

    Future.delayed(const Duration(seconds: 3), () {
      _auth.authStateChanges().listen((User? user) {

        if (user != null) {
          Get.offNamed('/dashboard');
        } else {
          Get.offNamed('/login');
        }
      });
    });
  }
}
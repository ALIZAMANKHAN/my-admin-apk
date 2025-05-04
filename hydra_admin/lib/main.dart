import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:hydra_admin/splash/splash_controller.dart';
import 'package:hydra_admin/login/login_controller.dart';
import 'package:hydra_admin/deposit/deposit_controller.dart';
import 'package:hydra_admin/withdraw/withdraw_controller.dart';
import 'package:hydra_admin/dashboard/total_deposit_controller.dart';
import 'package:hydra_admin/dashboard/total_profit_controller.dart';
import 'package:hydra_admin/dashboard/total_withdraw_controller.dart';
import 'package:hydra_admin/plan/plan_controller.dart';
import 'package:hydra_admin/link/link_controller.dart';
import 'package:hydra_admin/whatsapp/whatsapp_controller.dart';
import 'package:hydra_admin/service/service_controller.dart';
import 'package:hydra_admin/bank/bank_controller.dart';
import 'package:hydra_admin/salary/salary_controller.dart';

import 'package:hydra_admin/splash/splash_view.dart';
import 'package:hydra_admin/login/login_view.dart';
import 'package:hydra_admin/dashboard/dashboard_view.dart';
import 'package:hydra_admin/deposit/deposit_view.dart';
import 'package:hydra_admin/withdraw/withdraw_view.dart';
import 'package:hydra_admin/plan/plan_view.dart';
import 'package:hydra_admin/link/link_view.dart';
import 'package:hydra_admin/whatsapp/whatsapp_view.dart';
import 'package:hydra_admin/service/service_view.dart';
import 'package:hydra_admin/bank/bank_view.dart';
import 'package:hydra_admin/salary/salary_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HydraAdmin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),

      initialBinding: BindingsBuilder(() {
        Get.put(SplashController());
        Get.put(LoginController());
        Get.put(DepositController());
        Get.put(TotalDepositController());
        Get.put(TotalProfitController());
        Get.put(TotalWithdrawController());
        Get.put(WithdrawController());
        Get.put(PlanController());
        Get.put(LinkController());
        Get.put(WhatsappController());
        Get.put(ServiceController());
        Get.put(BankController());
        Get.put(SalaryController());
      }),

      initialRoute: '/splash',
      getPages: [
        GetPage(name: '/splash', page: () => const SplashView()),
        GetPage(name: '/login', page: () => const LoginView()),
        GetPage(name: '/dashboard', page: () => const DashboardView()),
        GetPage(name: '/deposit', page: () => const DepositView()),
        GetPage(name: '/withdraw', page: () => const WithdrawView()),
        GetPage(name: '/plan', page: () => const PlanView()),
        GetPage(name: '/link', page: () => const LinkView()),
        GetPage(name: '/whatsapp', page: () => const WhatsappView()),
        GetPage(name: '/service', page: () => const ServiceView()),
        GetPage(name: '/bank', page: () => const BankView()),
        GetPage(name: '/salary', page: () => const SalaryView()),
      ],

    );
  }
}
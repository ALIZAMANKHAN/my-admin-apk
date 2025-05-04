import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hydra_admin/dashboard/total_deposit_controller.dart';
import 'package:hydra_admin/dashboard/total_profit_controller.dart';
import 'package:hydra_admin/dashboard/total_withdraw_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  TotalDepositController totalDepositController = Get.find<TotalDepositController>();
  TotalWithdrawController totalWithdrawController = Get.find<TotalWithdrawController>();
  TotalProfitController totalProfitController = Get.find<TotalProfitController>();

  @override
  void initState() {
    super.initState();
    totalDepositController.totalDeposit.value;
    totalWithdrawController.totalWithdraw.value;
    totalProfitController.totalProfit.value;
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            'Dashboard',
          style: TextStyle(
            fontFamily: 'Medium'
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              totalDepositController.totalDeposit.value;
              totalWithdrawController.totalWithdraw.value;
              totalProfitController.totalProfit.value;
            }, icon: const Icon(Icons.refresh, size: 30),
            tooltip: 'Refresh',
          )
        ],
      ),
      sideBar: SideBar(
        backgroundColor: Colors.teal,
        textStyle: const TextStyle(
            color: Colors.white,
          fontFamily: 'Medium'
        ),
        items: const [
          AdminMenuItem(
            title: 'Add Plan',
            route: '/plan',
            icon: Icons.list_alt,
          ),
          AdminMenuItem(
            title: 'App Link',
            route: '/link',
            icon: Icons.link,
          ),
          AdminMenuItem(
            title: 'WhatsApp Link',
            route: '/whatsapp',
            icon: FontAwesomeIcons.whatsapp,
          ),
          AdminMenuItem(
            title: 'Customer Service',
            route: '/service',
            icon: Icons.group,
          ),
          AdminMenuItem(
            title: 'Bank Service',
            route: '/bank',
            icon: Icons.account_balance,
          ),
          AdminMenuItem(
            title: 'Deposit Details',
            route: '/deposit',
            icon: Icons.payments,
          ),
          AdminMenuItem(
            title: 'Withdraw Details',
            route: '/withdraw',
            icon: Icons.payment,
          ),
          AdminMenuItem(
            title: 'Salary Details',
            route: '/salary',
            icon: Icons.money,
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            Get.toNamed(item.route!);
          }
        },
        header: Container(
          height: 50,
          width: double.infinity,
          color: Colors.orange,
          child: const Center(
            child: Text(
              'HydraAdmin',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Medium'
              ),
            ),
          ),
        ),
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.orange,
          child: const Center(
            child: Text(
              '@Creators',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Medium'
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/dashboard.png',
                width: 280,
                height: 280,
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Center(
                child: Text(
                  'Total Deposit\n${totalDepositController.totalDeposit.value.toString()} PKR',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontFamily: 'Medium'
                  ),
                ),
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Center(
                child: Text(
                  'Total Withdraw\n${totalWithdrawController.totalWithdraw.value.toString()} PKR',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontFamily: 'Medium'
                  ),
                ),
              ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(() => Center(
                child: Text(
                  'Total Profit\n${totalProfitController.totalProfit.value.toString()} PKR',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.teal,
                      fontFamily: 'Medium'
                  ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
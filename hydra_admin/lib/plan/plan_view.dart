import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:hydra_admin/plan/plan_controller.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {

  PlanController planController = Get.find<PlanController>();

  @override
  void initState() {
    super.initState();
    planController.resetState();
    planController.fetchPlans();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add Plan',
          style: TextStyle(fontFamily: 'Medium'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: planController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                        controller: planController.nameController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Plan Name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            labelText: 'Plan Name',
                            labelStyle: const TextStyle(fontFamily: 'Medium')
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        controller: planController.planRangeController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Plan Range';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            labelText: 'Plan Range in PKR',
                            labelStyle: const TextStyle(fontFamily: 'Medium')
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        controller: planController.planDaysController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Plan Day';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            labelText: 'Plan Day',
                            labelStyle: const TextStyle(fontFamily: 'Medium')
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        controller: planController.planProfitController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Plan Profit';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            labelText: 'Plan Profit in %',
                            labelStyle: const TextStyle(fontFamily: 'Medium')
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        controller: planController.planInvestController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Plan Invest';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                            labelText: 'Plan Invest in PKR',
                            labelStyle: const TextStyle(fontFamily: 'Medium')
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => InkWell(
                          child: Container(
                            height: 160,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2, color: Colors.teal),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (planController
                                    .selectedImagePath.value.isEmpty)
                                  const Text(
                                    'Upload Image',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Medium',
                                      color: Colors.orange,
                                    ),
                                  ),
                                planController.selectedImagePath.value.isEmpty ?
                                Image.asset(
                                  'assets/images/payment.png',
                                  width: 100,
                                  height: 100,
                                )
                                    : Image.file(
                                  File(planController.selectedImagePath.value),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            planController.pickImageFromGallery();
                          },
                        )
                        ),
                        SizedBox(
                          width: 160,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                planController.submit();
                              },
                              child: Obx(() => planController.loading.value ?
                              const CircularProgressIndicator(strokeWidth: 3, color: Colors.teal)
                                  : const Text(
                                'Add',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: 'Medium'),
                              ))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Obx(() => ListView.builder(
                shrinkWrap: true,
                itemCount: planController.plansList.length,
                itemBuilder: (context, index) {
                  final plan = planController.plansList[index];
                  return ListTile(
                    title: Text(
                      plan.planName,
                      style: const TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 15,
                        color: Colors.teal
                      ),
                    ),
                    subtitle: Text(
                      '${plan.planRange} PKR\n'
                          '${plan.planDays} Day\n'
                          '${plan.planProfit}%\n'
                          '${plan.planInvest} PKR',
                      style: const TextStyle(
                          fontFamily: 'Medium',
                          fontSize: 12,
                      ),
                    ),
                    leading: Image.network(plan.planImage),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.orange,
                        size: 35,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Delete Plan',
                                style: TextStyle(fontFamily: 'Medium'),
                              ),
                              content: const Text(
                                'Are you sure you want to delete this plan?',
                                style: TextStyle(fontFamily: 'Medium'),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(fontFamily: 'Medium'),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    planController.deletePlan(plan.planId, plan.planImage);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(fontFamily: 'Medium'),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
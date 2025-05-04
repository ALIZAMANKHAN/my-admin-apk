import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hydra_admin/salary/salary_controller.dart';

class SalaryView extends StatefulWidget {
  const SalaryView({super.key});

  @override
  State<SalaryView> createState() => _SalaryViewState();
}

class _SalaryViewState extends State<SalaryView> {

  SalaryController salaryController = Get.find<SalaryController>();

  @override
  void initState() {
    super.initState();
    salaryController.fetchSalary();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            'Salary Details',
          style: TextStyle(
            fontFamily: 'Medium'
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              salaryController.fetchSalary();
            }, icon: const Icon(Icons.refresh, size: 30),
            tooltip: 'Refresh',
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() => salaryController.salary.isEmpty ?
      const Center(child: Text(
        'No Salary Yet.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.orange,
          fontFamily: 'Medium'
        ),
      )
      )
          : ListView.builder(
        itemCount: salaryController.salary.length,
        itemBuilder: (context, index) {
          final salary = salaryController.salary[index];
          final documentId = salary.documentId;
          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.teal,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank Name : ${salary.bankName}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Holder Name : ${salary.holderName}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Account Number : ${salary.accountNumber}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Referral Code : ${salary.refCode}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Teams Invest : ${salary.totalInvest.toString()} PKR',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Status : ${salary.status}',
                  style: const TextStyle(color: Colors.orange, fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 95,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            if (salary.status == 'Pending' || salary.status == 'Rejected') {
                              await salaryController.approveSalary(documentId);
                              await salaryController.confirm(documentId);
                              Get.snackbar(
                                  'Approve',
                                  'Approved Successfully',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green
                              );
                            } else {
                              Get.snackbar(
                                  'Error',
                                  'Salary is already approved',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.red
                              );
                            }
                          }catch(e){
                            Get.snackbar(
                                'Error',
                                e.toString(),
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red
                            );
                          }
                        },
                        child: const Text(
                          'Approve',
                          style: TextStyle(
                              fontSize: 10,
                            fontFamily: 'Medium',
                            color: Colors.teal
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            if (salary.status == 'Pending') {
                              await salaryController.rejectSalary(documentId);
                              await salaryController.remarks(documentId);
                              Get.snackbar(
                                'Reject',
                                'Rejected Successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.green,
                              );
                            } else {
                              Get.snackbar(
                                'Error',
                                'Salary is already approved or rejected',
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
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
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Reject',
                          style: TextStyle(
                              fontSize: 9,
                            fontFamily: 'Medium',
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await salaryController.deleteSalary(documentId);
                            Get.snackbar(
                              'Delete',
                              'Deleted Successfully',
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                              backgroundColor: Colors.green,
                            );
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              e.toString(),
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text(
                          'Delete',
                          style: TextStyle(
                              fontSize: 9,
                            fontFamily: 'Medium',
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.copy, size: 35, color: Colors.teal),
                      onPressed: () {
                        String dataToCopy =
                            'Bank Name : ${salary.bankName}\n'
                            'Account Number : ${salary.accountNumber}\n'
                            'Holder Name : ${salary.holderName}';
                        Clipboard.setData(ClipboardData(text: dataToCopy));
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:hydra_admin/withdraw/withdraw_controller.dart';

class WithdrawView extends StatefulWidget {
  const WithdrawView({super.key});

  @override
  State<WithdrawView> createState() => _WithdrawViewState();
}

class _WithdrawViewState extends State<WithdrawView> {

  WithdrawController withdrawController = Get.find<WithdrawController>();

  @override
  void initState() {
    super.initState();
    // Fetch deposits when the view is initialized
    withdrawController.fetchWithdraws();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            'Withdraw Details',
          style: TextStyle(
            fontFamily: 'Medium'
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              withdrawController.fetchWithdraws();
            }, icon: const Icon(Icons.refresh, size: 30),
            tooltip: 'Refresh',
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() => withdrawController.withdraws.isEmpty ?
      const Center(child: Text(
        'No Withdraw Yet.',
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Medium',
          color: Colors.orange,
        ),
      )
      )
          : ListView.builder(
        itemCount: withdrawController.withdraws.length,
        itemBuilder: (context, index) {
          final withdraw = withdrawController.withdraws[index];
          final documentId = withdraw.documentId;
          return Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.teal, width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank Name : ${withdraw.bankName}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Holder Name : ${withdraw.holderName}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Account Number : ${withdraw.accountNumber}',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Amount : ${withdraw.amount.toString()} PKR',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Payable Amount : ${withdraw.payAmount.toString()} PKR',
                  style: const TextStyle(fontFamily: 'Medium'),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('Status : ${withdraw.status}',
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
                            if (withdraw.status == 'Pending' || withdraw.status == 'Rejected') {
                              await withdrawController.approveWithdraw(documentId);
                              await withdrawController.confirm(documentId);
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
                                  'Withdraw is already approved',
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
                            fontFamily: 'Medium'
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
                            if (withdraw.status == 'Pending') {
                              await withdrawController.rejectWithdraw(documentId);
                              await withdrawController.remarks(documentId);
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
                                'Withdraw is already approved or rejected',
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
                            await withdrawController.deleteWithdraw(documentId);
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
                            'Bank Name : ${withdraw.bankName}\n'
                            'Account Number : ${withdraw.accountNumber}\n'
                            'Holder Name : ${withdraw.holderName}\n'
                            'Payable Amount : ${withdraw.payAmount} Rs.';
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
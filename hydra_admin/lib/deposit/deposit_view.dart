import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'deposit_controller.dart';

class DepositView extends StatefulWidget {
  const DepositView({super.key});

  @override
  State<DepositView> createState() => _DepositViewState();
}

class _DepositViewState extends State<DepositView> {

  DepositController depositController = Get.find<DepositController>();

  @override
  void initState() {
    super.initState();
    // Fetch deposits when the view is initialized
    depositController.fetchDeposits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
            'Deposit Details',
          style: TextStyle(
            fontFamily: 'Medium'
          ),
        ),
        actions: [
          IconButton(
            onPressed: (){
              depositController.fetchDeposits();
            }, icon: const Icon(Icons.refresh, size: 30),
            tooltip: 'Refresh',
          )
        ],
        centerTitle: true,
      ),
      body: Obx(() => depositController.deposits.isEmpty ?
      const Center(child: Text(
        'No Deposit Yet.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.orange,
          fontFamily: 'Medium'
        ),
      )
      )
          : ListView.builder(
        itemCount: depositController.deposits.length,
        itemBuilder: (context, index) {
          final deposit = depositController.deposits[index];
          final documentId = deposit.id;
          return Card(
            shadowColor: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Open a zoomed-in view of the image when tapped
                      Get.to(() => PhotoView(
                        imageProvider: NetworkImage(deposit.imagePath),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered * 2,
                      ));
                    },
                    child: Image.network(
                      deposit.imagePath,
                      height: 100,
                      width: 330,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    width: 332,
                    height: 135,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Colors.teal),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Bank Name : ${deposit.bankName}', style: const TextStyle(fontFamily: 'Medium')),
                        Text('Holder Name : ${deposit.holderName}', style: const TextStyle(fontFamily: 'Medium')),
                        Text('Account Number : ${deposit.accountNumber}', style: const TextStyle(fontFamily: 'Medium')),
                        Text('Ref#/TID : ${deposit.refNumber}', style: const TextStyle(fontFamily: 'Medium')),
                        Text('Amount : ${deposit.amount.toString()} PKR', style: const TextStyle(fontFamily: 'Medium')),
                        Text('Status : ${deposit.status}', style: const TextStyle(color: Colors.orange, fontFamily: 'Medium')),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: depositController.returnDeposit,
                            style: const TextStyle(fontFamily: 'Medium'),
                            decoration: InputDecoration(
                                labelText: 'Return Deposit in PKR',
                                labelStyle: const TextStyle(fontFamily: 'Medium'),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 111,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: deposit.isApproved
                                      ? null // Button is disabled when isApproved is true
                                      : () {
                                    final returnDepositValue = depositController.returnDeposit.text;
                                    if (returnDepositValue.isEmpty) {
                                      // Show an error snackbar if the field is empty
                                      Get.snackbar(
                                        'Error',
                                        'Please enter return deposit',
                                        snackPosition: SnackPosition.BOTTOM,
                                        colorText: Colors.white,
                                        backgroundColor: Colors.red,
                                      );
                                    } else {
                                      // Proceed to approve the deposit
                                      try {
                                        depositController.approveDeposit(index);
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
                                  },
                                  child: Text(
                                    deposit.isApproved ? 'Approved' : 'Approve',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Medium'
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      if (deposit.status == 'Pending') {
                                        await depositController.rejectDeposit(documentId);
                                        await depositController.remarks(documentId);
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
                                          'Deposit is already approved or rejected',
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
                                        fontSize: 12,
                                        fontFamily: 'Medium',
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await depositController.deleteDeposit(documentId, deposit.imagePath);
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
                                        fontSize: 12,
                                        fontFamily: 'Medium',
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          );
        },
      )
      ),
    );
  }
}
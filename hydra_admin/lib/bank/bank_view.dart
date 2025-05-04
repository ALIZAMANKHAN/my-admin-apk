import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bank_controller.dart';

import 'bank_model.dart';

class BankView extends StatefulWidget {
  const BankView({super.key});

  @override
  State<BankView> createState() => _BankViewState();
}

class _BankViewState extends State<BankView> {

  BankController bankController = Get.find<BankController>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Bank Service',
            style: TextStyle(fontFamily: 'Medium'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontFamily: 'Medium'),
                        controller: bankNameController,
                        decoration: InputDecoration(
                            labelText: 'Bank Name',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter bank name';
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontFamily: 'Medium'),
                        controller: accountHolderNameController,
                        decoration: InputDecoration(
                            labelText: 'Account Holder Name',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter account holder name';
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontFamily: 'Medium'),
                        controller: accountNumberController,
                        decoration: InputDecoration(
                            labelText: 'Account Number',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter account number';
                          }else{
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            try{
                              if(formKey.currentState!.validate()){
                                final bank = BankModel(
                                  id: '',
                                  bankName: bankNameController.text,
                                  accountHolderName: accountHolderNameController.text,
                                  accountNumber: accountNumberController.text,
                                );
                                bankController.addBank(bank);
                                // Clear the input fields after successfully adding a bank
                                bankNameController.clear();
                                accountHolderNameController.clear();
                                accountNumberController.clear();
                                Get.snackbar(
                                    'Add',
                                    'Added Successfully',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.green
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
                            'Add',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Medium',
                              color: Colors.teal
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            try{
                              if(formKey.currentState!.validate()){
                                final bank = BankModel(
                                  id: bankController.bankList[0].id,
                                  bankName: bankNameController.text,
                                  accountHolderName: accountHolderNameController.text,
                                  accountNumber: accountNumberController.text,
                                );
                                bankController.updateBank(bank);
                                // Clear the input fields after successfully updating a bank
                                bankNameController.clear();
                                accountHolderNameController.clear();
                                accountNumberController.clear();
                                Get.snackbar(
                                    'Update',
                                    'Updated Successfully',
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.white,
                                    backgroundColor: Colors.green
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
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Medium',
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            try{
                              bankController.deleteBanks();
                              Get.snackbar(
                                  'Delete',
                                  'Deleted Successfully',
                                  snackPosition: SnackPosition.BOTTOM,
                                  colorText: Colors.white,
                                  backgroundColor: Colors.green
                              );
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
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
                          ),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Medium',
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 330,
                  height: 160,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Obx(() => ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: bankController.bankList.length,
                    itemBuilder: (context, index) {
                      final bank = bankController.bankList[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bank Name',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontFamily: 'Medium'
                            ),
                          ),
                          Text(
                            bank.bankName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                                fontFamily: 'Medium'
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Account Holder Name',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontFamily: 'Medium'
                            ),
                          ),
                          Text(
                            bank.accountHolderName,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                                fontFamily: 'Medium'
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Account Number',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontFamily: 'Medium'
                            ),
                          ),
                          Text(
                            bank.accountNumber,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                                fontFamily: 'Medium'
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
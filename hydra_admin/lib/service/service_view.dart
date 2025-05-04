import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hydra_admin/service/service_controller.dart';

import 'package:hydra_admin/service/service_model.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {

  ServiceController serviceController = Get.find<ServiceController>();

  @override
  void initState() {
    super.initState();
    serviceController.fetchData();
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController serviceLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Customer Service',
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
                        keyboardType: TextInputType.phone,
                        controller: serviceLinkController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        decoration: InputDecoration(
                            labelText: 'WhatsApp Number',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter whatsapp number';
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
                                final link = ServiceModel(
                                  id: '',
                                  whatsappLink: serviceLinkController.text,
                                );
                                serviceController.addLink(link);
                                // Clear the input fields after successfully adding a bank
                                serviceLinkController.clear();
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
                          }, child: const Text(
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
                                final link = ServiceModel(
                                  id: serviceController.whatsappLink[0].id,
                                  whatsappLink: serviceLinkController.text,
                                );
                                serviceController.updateLink(link);
                                // Clear the input fields after successfully updating a bank
                                serviceLinkController.clear();
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
                              serviceController.deleteLink();
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
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal, width: 2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Obx(() => ListView.builder(
                    padding: const EdgeInsets.all(5),
                    itemCount: serviceController.whatsappLink.length,
                    itemBuilder: (context, index) {
                      final link = serviceController.whatsappLink[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'WhatsApp Number',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontFamily: 'Medium'
                            ),
                          ),
                          Text(
                            link.whatsappLink,
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hydra_admin/whatsapp/whatsapp_controller.dart';

import 'package:hydra_admin/whatsapp/whatsapp_model.dart';

class WhatsappView extends StatefulWidget {
  const WhatsappView({super.key});

  @override
  State<WhatsappView> createState() => _WhatsappViewState();
}

class _WhatsappViewState extends State<WhatsappView> {

  WhatsappController whatsappController = Get.find<WhatsappController>();

  @override
  void initState() {
    super.initState();
    whatsappController.fetchData();
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController whatsappLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('WhatsApp Link',
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
                        keyboardType: TextInputType.url,
                        controller: whatsappLinkController,
                        style: const TextStyle(fontFamily: 'Medium'),
                        decoration: InputDecoration(
                            labelText: 'WhatsApp Link',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter whatsapp link';
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
                                final link = WhatsappModel(
                                  id: '',
                                  whatsappLink: whatsappLinkController.text,
                                );
                                whatsappController.addLink(link);
                                // Clear the input fields after successfully adding a bank
                                whatsappLinkController.clear();
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
                                final link = WhatsappModel(
                                  id: whatsappController.whatsappLink[0].id,
                                  whatsappLink: whatsappLinkController.text,
                                );
                                whatsappController.updateLink(link);
                                // Clear the input fields after successfully updating a bank
                                whatsappLinkController.clear();
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
                              whatsappController.deleteLink();
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
                    itemCount: whatsappController.whatsappLink.length,
                    itemBuilder: (context, index) {
                      final link = whatsappController.whatsappLink[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'WhatsApp Link',
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
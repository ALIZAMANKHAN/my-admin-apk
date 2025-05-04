import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'link_controller.dart';

import 'link_model.dart';

class LinkView extends StatefulWidget {
  const LinkView({super.key});

  @override
  State<LinkView> createState() => _LinkViewState();
}

class _LinkViewState extends State<LinkView> {

  LinkController linkController = Get.find<LinkController>();

  @override
  void initState() {
    super.initState();
    linkController.fetchData();
  }

  final formKey = GlobalKey<FormState>();

  final TextEditingController appLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('App Link',
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
                        style: const TextStyle(fontFamily: 'Medium'),
                        controller: appLinkController,
                        decoration: InputDecoration(
                            labelText: 'App Link',
                            labelStyle: const TextStyle(fontFamily: 'Medium'),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter app link';
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
                                final link = LinkModel(
                                  id: '',
                                  appLink: appLinkController.text,
                                );
                                linkController.addLink(link);
                                // Clear the input fields after successfully adding a bank
                                appLinkController.clear();
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
                                final link = LinkModel(
                                  id: linkController.appLink[0].id,
                                  appLink: appLinkController.text,
                                );
                                linkController.updateLink(link);
                                // Clear the input fields after successfully updating a bank
                                appLinkController.clear();
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
                              linkController.deleteLink();
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
                    itemCount: linkController.appLink.length,
                    itemBuilder: (context, index) {
                      final link = linkController.appLink[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'App Link',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.teal,
                                fontFamily: 'Medium'
                            ),
                          ),
                          Text(
                            link.appLink,
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
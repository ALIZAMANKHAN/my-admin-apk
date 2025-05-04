import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hydra_admin/service/service_model.dart';

class ServiceController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<ServiceModel> whatsappLink = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final QuerySnapshot snapshot = await _firestore.collection('service').get();
    whatsappLink.assignAll(
      snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ServiceModel(
          id: doc.id,
          whatsappLink: data['whatsappLink'],
        );
      }).toList(),
    );
  }

  void addLink(ServiceModel link) async {
    await _firestore.collection('service').add({
      'whatsappLink': link.whatsappLink,
    });
    fetchData();
  }

  void updateLink(ServiceModel link) async {
    await _firestore.collection('service').doc(link.id).update({
      'whatsappLink': link.whatsappLink,
    });
    fetchData();
  }

  void deleteLink() async {
    final QuerySnapshot snapshot = await _firestore.collection('service').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await _firestore.collection('service').doc(doc.id).delete();
    }
    fetchData();
  }

}
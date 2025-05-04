import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hydra_admin/whatsapp/whatsapp_model.dart';

class WhatsappController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<WhatsappModel> whatsappLink = <WhatsappModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final QuerySnapshot snapshot = await _firestore.collection('whatsapp').get();
    whatsappLink.assignAll(
      snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return WhatsappModel(
          id: doc.id,
          whatsappLink: data['whatsappLink'],
        );
      }).toList(),
    );
  }

  void addLink(WhatsappModel link) async {
    await _firestore.collection('whatsapp').add({
      'whatsappLink': link.whatsappLink,
    });
    fetchData();
  }

  void updateLink(WhatsappModel link) async {
    await _firestore.collection('whatsapp').doc(link.id).update({
      'whatsappLink': link.whatsappLink,
    });
    fetchData();
  }

  void deleteLink() async {
    final QuerySnapshot snapshot = await _firestore.collection('whatsapp').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await _firestore.collection('whatsapp').doc(doc.id).delete();
    }
    fetchData();
  }

}
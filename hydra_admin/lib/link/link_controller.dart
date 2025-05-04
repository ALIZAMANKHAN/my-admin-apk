import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'link_model.dart';

class LinkController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<LinkModel> appLink = <LinkModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final QuerySnapshot snapshot = await _firestore.collection('links').get();
    appLink.assignAll(
      snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LinkModel(
          id: doc.id,
          appLink: data['appLink'],
        );
      }).toList(),
    );
  }

  void addLink(LinkModel link) async {
    await _firestore.collection('links').add({
      'appLink': link.appLink,
    });
    fetchData();
  }

  void updateLink(LinkModel link) async {
    await _firestore.collection('links').doc(link.id).update({
      'appLink': link.appLink,
    });
    fetchData();
  }

  void deleteLink() async {
    final QuerySnapshot snapshot = await _firestore.collection('links').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await _firestore.collection('links').doc(doc.id).delete();
    }
    fetchData();
  }

}
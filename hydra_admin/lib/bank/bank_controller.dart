import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'bank_model.dart';

class BankController extends GetxController {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<BankModel> bankList = <BankModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    final QuerySnapshot snapshot = await _firestore.collection('banks').get();
    bankList.assignAll(
      snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return BankModel(
          id: doc.id,
          bankName: data['bankName'],
          accountHolderName: data['accountHolderName'],
          accountNumber: data['accountNumber'],
        );
      }).toList(),
    );
  }

  void addBank(BankModel bank) async {
    await _firestore.collection('banks').add({
      'bankName': bank.bankName,
      'accountHolderName': bank.accountHolderName,
      'accountNumber': bank.accountNumber,
    });
    fetchData();
  }

  void updateBank(BankModel bank) async {
    await _firestore.collection('banks').doc(bank.id).update({
      'bankName': bank.bankName,
      'accountHolderName': bank.accountHolderName,
      'accountNumber': bank.accountNumber,
    });
    fetchData();
  }

  void deleteBanks() async {
    final QuerySnapshot snapshot = await _firestore.collection('banks').get();
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      await _firestore.collection('banks').doc(doc.id).delete();
    }
    fetchData();
  }

}
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/amount_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';

class AmountDatabase {
  Stream<List<AmountModel>> getAmounts() {
    return clientRef
        .doc(clientIdNotifier.value)
        .collection('amount')
        .orderBy('dateTime',descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return AmountModel(
          amount: data['amount'],
          dateTime: data['dateTime'],
        );
      }).toList();
    });
  }

  Future<void> addAmounts(AmountModel amountModel) async {
    clientRef
        .doc(clientIdNotifier.value)
        .collection('amount')
        .doc(amountModel.dateTime.toDate().toString())
        .set({
      'amount': amountModel.amount,
      'dateTime': amountModel.dateTime,
    });
  }

  Future<void> deleteAmount(AmountModel amountModel) async {
    clientRef
        .doc(clientIdNotifier.value)
        .collection('amount')
        .doc(amountModel.dateTime.toDate().toString())
        .delete();
  }
}

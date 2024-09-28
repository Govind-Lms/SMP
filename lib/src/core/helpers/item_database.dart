import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/item_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';

class ItemDatabase {
  Stream<List<Item>> getItems() {
    return clientRef
        .doc(clientIdNotifier.value)
        .collection('vouchers')
        .doc(voucherIdNotifier.value)
        .collection('items')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Item(
          packageType: data['packageType'] ?? '',
          itemName: data['itemName'],
          itemId: data['itemId'],
          itemTotal: data['itemTotal'],
          price: data['price'],
          quantity: data['quantity'],
          timestamp: data['timestamp'],
        );
      }).toList();
    });
  }

  Future<void> addItems(Item item) async {
    return clientRef
        .doc(clientIdNotifier.value)
        .collection('vouchers')
        .doc(voucherIdNotifier.value).collection('items').doc(item.itemId).set({
      'itemName': item.itemName,
      'itemId': item.itemId,
      'itemTotal': item.itemTotal,
      'price': item.price,
      'quantity': item.quantity,
      'timestamp': item.timestamp,
      'packageType' : item.packageType,
    });
  }

  Future<void> updateItems(Item item) async {
    return itemRef.doc(item.itemId).update({
      'itemName': item.itemName,
      'itemTotal': item.itemTotal,
      'price': item.price,
      'quantity': item.quantity,
      'packageType' : item.packageType,
    });
  }

  Future<void> deleteItems(Item item) async {
    return itemRef.doc(item.itemId).delete();
  }
}

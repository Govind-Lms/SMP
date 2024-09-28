import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String itemId;
  final String itemName;
  final int price;
  final int quantity;
  final int itemTotal;
  final Timestamp timestamp;
  final String packageType;
  Item(
      {required this.itemId,
      required this.packageType, 
      required this.itemName,
      required this.price,
      required this.quantity,
      required this.itemTotal,
      required this.timestamp});
  
  factory Item.fromDocument(doc) {
    return Item(
      packageType: doc['packageType'] ?? '',
      itemId: doc['itemId'],
      itemName: doc['itemName'],
      price: doc['price'],
      quantity: doc['quantity'],
      itemTotal: doc['itemTotal'],
      timestamp: doc['timestamp']);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class VoucherModel{
  final String voucherId;
  final int totalAmt;
  final int totalQty;
  final Timestamp dateTime;
  
  VoucherModel({required this.voucherId, required this.totalAmt, required this.totalQty, required this.dateTime});

  factory VoucherModel.fromDocument(Map<String, dynamic> document) {
    final doc = document;
    return VoucherModel(
      voucherId: doc['voucherId'],
      totalAmt: doc['totalAmt'],
      totalQty: doc['totalQty'],
      dateTime: doc['dateTime'],
    );
  }
  
}
import 'package:cloud_firestore/cloud_firestore.dart';

class AmountModel{
  final int amount;
  final Timestamp dateTime;

  AmountModel({required this.amount,required this.dateTime});

  factory AmountModel.fromDocument(Map<String,dynamic> doc){
    return AmountModel(
      amount: doc['amount'],
      dateTime: doc['dateTime'],
    );
  }
}
// import 'package:hive/hive.dart';
// part "client_model.g.dart";


class ClientModel{
  final String name;
  final String phoneNo;
  final String id;
  final String? totalAmt;

  ClientModel({required this.name, required this.phoneNo,required this.id,this.totalAmt});

  factory ClientModel.fromDocument(Map<String, dynamic> document) {
    final doc = document;
    return ClientModel(
      name: doc['name'],
      phoneNo: doc['phoneNo'],
      id: doc['id'],
      totalAmt: doc['totalAmt'] ?? '0',
    );
  }
}

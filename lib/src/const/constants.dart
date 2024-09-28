import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';


int totalAmtGlobal = 0;
int totalQtyGlobal = 0;

nav(context, widget) => Navigator.of(context).push(MaterialPageRoute(builder: (_)=> widget));
navPop(context) => Navigator.of(context).pop(true);



class AppColor {
  static const Color primaryColor = Color(0xff3A1078);
  static const Color secondaryColor = Color(0xff4E31AA);
  static const Color firstColor = Color(0xff2F58CD);
  static const Color secondColor = Color(0xff3795BD);
}


final clientRef = FirebaseFirestore.instance.collection('clients');
final voucherRef = FirebaseFirestore.instance.collection('clients').doc(clientIdNotifier.value).collection('vouchers');
final itemRef = FirebaseFirestore.instance.collection('clients').doc(clientIdNotifier.value).collection('vouchers').doc(voucherIdNotifier.value).collection("items");
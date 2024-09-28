import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class DateFormatWidget extends StatelessWidget {
  final Timestamp dateTime;
  final bool? getMinute;
  const DateFormatWidget({super.key, required this.dateTime, this.getMinute});

  @override
  Widget build(BuildContext context) {
    final minute = dateTime.toDate().minute;
    final hour = dateTime.toDate().hour;

    minuteFunction(){
      if(minute >=0 && minute <=9){
        return "0$minute";
      }
      else{
        return minute;
      }
    }

    amPmFunction(){
      if( hour>=0 && hour <=12){
        return "AM";
      }
      else{
        return "PM";
      }
    }
    return Text(
      getMinute == false
          ? "${dateTime.toDate().day}/${dateTime.toDate().month}/${dateTime.toDate().year}"
          : "Date : ${dateTime.toDate().day}/${dateTime.toDate().month}/${dateTime.toDate().year}\n"
          "${dateTime.toDate().hour}:${minuteFunction()} ${amPmFunction()}",
      style: Style.twelve.copyWith(fontStyle: FontStyle.italic),
    );
  }
}

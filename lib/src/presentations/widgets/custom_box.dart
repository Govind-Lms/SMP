import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class CustomBox extends StatelessWidget {
  final String boxName;
  final String boxDetails;
  final VoidCallback? onTap;
  final Color? color;
  const CustomBox({super.key, required this.boxName, required this.boxDetails,  this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color ?? Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        width: MediaQuery.sizeOf(context).width/2,
        height: MediaQuery.sizeOf(context).height/10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(boxName,style: Style.fourteenBold.copyWith(color: Colors.white),),
            Text(boxDetails,style: Style.fourteen.copyWith(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
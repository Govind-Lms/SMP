import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';

class RealAmountPart extends StatelessWidget {
  final int totalAmt;
  const RealAmountPart({super.key, required this.totalAmt});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      margin: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total Amount',style: Style.fourteenBold.copyWith(color: Colors.white)),
          ValueListenableBuilder(
            valueListenable: subtractedAmtNotifier,
            builder: (context,subtractedAmt,child) {
              return Text("$totalAmt",style: Style.fourteenBold.copyWith(color: Colors.white));
            }
          ),
        ],
      ),
    );
  }
}

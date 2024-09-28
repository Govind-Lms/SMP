import 'package:flutter/material.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';

class BottomNavPart extends StatelessWidget {
  final VoidCallback onTap;
  const BottomNavPart({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: generatedNotifier,
      builder: (context,value,child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
             margin: const EdgeInsets.all(20),
            height: kToolbarHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.firstColor,
            ),
            child: Center(child: 
              value==false 
                ? Text('Generate Total',style: Style.fourteenBold.copyWith(color: Colors.white),)
                : Text('Save',style: Style.fourteenBold.copyWith(color: Colors.white),)
            ),
          ),
        );
      }
    );
  }
}
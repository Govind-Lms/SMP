import 'package:flutter/material.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';

class ButtonsPart extends StatelessWidget {
  final VoidCallback onGenerateImage;
  const ButtonsPart({super.key, required this.onGenerateImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              navPop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.red,
              ),
              child: Center(
                child: Text(
                  'Exit',
                  style: Style.fourteenBold.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          InkWell(
            onTap: onGenerateImage,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColor.firstColor),
              child: Center(
                child: Text('Generate Image',
                    style: Style.fourteenBold.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

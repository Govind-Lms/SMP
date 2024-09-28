import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class OwnerPart extends StatelessWidget {
  const OwnerPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SMP Shop',
          style: Style.twelveBold,
        ),
        Text(
          '09*********',
          style: Style.twelveBold,
        ),
        Text(
          'Mandalay, Myanmar',
          style: Style.twelveBold,
        ),
      ],
    );
  }
}

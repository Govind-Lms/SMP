import 'package:flutter/material.dart';
import 'package:smp/src/const/style.dart';

class HeaderPart extends StatelessWidget {
  final String name;
  final String id;
  const HeaderPart({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            id,
            style: Style.fourteen,
          ),
          Text(
            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
            style: Style.fourteen,
          )
        ],
      ),
    );
  }
}
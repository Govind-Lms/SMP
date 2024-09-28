import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';

class AddClientScreen extends StatefulWidget {
  const AddClientScreen({super.key});

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final clientId = Random().nextInt(100000000).toString();

    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: MediaQuery.sizeOf(context).height - kToolbarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width / 4,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: AppColor.firstColor,
              ),
            ),
          ),

          const Gap(20),

          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              "Add Clients",
              style: Style.sixteenBold,
            ),
          ),

          const Gap(20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Name",
                  labelStyle: Style.fourteen,
                  hintStyle: Style.fourteen,
                  suffixIcon: const Icon(Iconsax.user_octagon),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onChanged: (value) {
                  nameController.text = value;
                }),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
              controller: phoneNoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Phone Number",
                labelStyle: Style.fourteen,
                hintStyle: Style.fourteen,
                suffixIcon: const Icon(Iconsax.mobile),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onChanged: (value) => phoneNoController.text = value,
            ),
          ),

          // const Spacer(),
          InkWell(
            onTap: () {
              final clientModel = ClientModel(
                id: clientId,
                name: nameController.text,
                phoneNo: phoneNoController.text,
              );
              BlocProvider.of<ClientBloc>(context).add(AddClient(clientModel));
              navPop(context);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: kToolbarHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Center(
                child: Text("Add",
                    style: Style.sixteen.copyWith(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

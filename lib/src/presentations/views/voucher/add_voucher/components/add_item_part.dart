import 'dart:math';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smp/src/const/constants.dart';

import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';

import '../../../../../core/models/item_model.dart';

class AddItemPart extends StatelessWidget {

  const AddItemPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            builder: (context) => const AddItemBottomSheet(),
          );
        },
        child: Text("Add Items",
            style: Style.fourteenBold.copyWith(color: AppColor.firstColor)),
      ),
    );
  }
}

class AddItemBottomSheet extends StatefulWidget {

  const AddItemBottomSheet({super.key});

  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  String itemName = '';
  int price = 0;
  int quantity = 0;
  int itemTotal = 0;

  String packageType = 'Dz';
  List<String> list = ['Dz','Pkg'];

  @override
  void initState() {
    super.initState();
     // Generate the voucher ID once when the screen is first created
    if (itemIdNotifier.value.isEmpty) {
      itemIdNotifier.value = Random().nextInt(99999).toString();
    }
  }

  @override
  void dispose() {
    // Reset the value when the screen is disposed (when user leaves the screen)
    itemIdNotifier.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      margin: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0),
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
          Container(
            margin: const EdgeInsets.all(10.0),
            child: Text('Add Items', style: Style.eighteenBold),
          ),
          const SizedBox(height: 10.0),
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              validator: (val) => val!.isEmpty ? "Enter Item Name" : null,
              onChanged: (value) => itemName = value,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: "Item Name",
                labelStyle: Style.fourteen,
                hintStyle: Style.fourteen,
                suffixIcon: const Icon(Iconsax.box_tick),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (val) => val!.isEmpty ? "Enter Item Price" : null,
              onChanged: (value) => price = int.parse(value),
              decoration: InputDecoration(
                hintText: "Item Price",
                labelStyle: Style.fourteen,
                hintStyle: Style.fourteen,
                suffixIcon: const Icon(Iconsax.dollar_circle),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (val) =>
                        val!.isEmpty ? "Enter Item Quantity" : null,
                    onChanged: (value) => quantity = int.parse(value),
                    decoration: InputDecoration(
                      hintText: "Item Qty",
                      labelStyle: Style.fourteen,
                      hintStyle: Style.fourteen,
                      suffixIcon: const Icon(Iconsax.box_tick),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomDropdown<String>(
                    items: list,
                    initialItem: list[0],
                    onChanged: (value) {
                      packageType = value!;
                    },
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 60.0,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColor.firstColor,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(4, 4),
                  blurRadius: 6.0,
                  color: Colors.black26,
                )
              ],
            ),
            child: ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColor.firstColor),
                
              ),
              onPressed: () {
                if (itemName.trim().isEmpty ||
                    price.bitLength == 0 ||
                    quantity.bitLength == 0) {
                      debugPrint("empty");

                } else {
                  
                  itemTotal = price * quantity;

                  

                  final item = Item(
                    itemId: itemIdNotifier.value,
                    itemTotal: itemTotal,
                    itemName: itemName,
                    price: price,
                    quantity: quantity,
                    timestamp: Timestamp.now(),
                    packageType: packageType,
                  );


                  BlocProvider.of<ItemBloc>(context).add(AddItem(item));
                  navPop(context);
                }
              },
              child: Text('ADD', style: Style.fourteen.copyWith(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

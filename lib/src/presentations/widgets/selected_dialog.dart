import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';
import 'package:smp/src/presentations/views/voucher/add_voucher/components/edit_item_part.dart';

import '../../core/models/item_model.dart';

class SelectedDialog extends StatelessWidget {
  final Item item;
  const SelectedDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                showMaterialModalBottomSheet(context: context, builder: (context) {
                  return EditItemPart(item: item);
                },);
              },
              child: const Text('Edit'),
            ),
           

            TextButton(
              onPressed: () async {
                BlocProvider.of<ItemBloc>(context).add(DeleteItem(item));
                navPop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}

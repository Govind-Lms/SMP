import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';
import 'package:smp/src/presentations/widgets/divider.dart';

import '../../../../../core/models/item_model.dart';

class DescriptionPart extends StatelessWidget {
  final ClientModel clientModel;
  const DescriptionPart({super.key, required this.clientModel});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemBloc, ItemState>(
      listener: (context, state) {
        if(state is ItemAddedSuccess){
          BlocProvider.of<ItemBloc>(context).add(LoadItem());
        }
      },
      child: BlocBuilder<ItemBloc, ItemState>(
        bloc: ItemBloc()..add(LoadItem()),
        builder: (context, state) {
          if (state is ItemSuccess) {
            int totalAmt = 0;
            int totalQty = 0;
            final items = state.items;

            for (Item i in items) {
              totalAmt = i.itemTotal + totalAmt;
              totalQty = i.quantity + totalQty;
            }
            totalAmtGlobal = totalAmt;
            totalQtyGlobal = totalQty;

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Amount", style: Style.twelveBold),
                    Text(totalAmt.toString(), style: Style.twelve)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Qty", style: Style.twelveBold),
                    Text(totalQty.toString(), style: Style.twelve)
                  ],
                ),
                const DividerWidget(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Client Name", style: Style.twelveBold),
                    Text(clientModel.name.toString(), style: Style.twelve)
                  ],
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

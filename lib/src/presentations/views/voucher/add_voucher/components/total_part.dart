import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';

import '../../../../../core/models/item_model.dart';

class TotalPart extends StatelessWidget {
  const TotalPart({super.key});

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

            return Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount", style: Style.fourteenBold),
                        Text(totalAmt.toString(), style: Style.fourteen)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Qty", style: Style.fourteenBold),
                        Text(totalQty.toString(), style: Style.fourteen)
                      ],
                    ),
                  ],
                ));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

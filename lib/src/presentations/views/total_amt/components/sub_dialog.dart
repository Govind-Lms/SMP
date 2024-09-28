import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/amount_model.dart';
import 'package:smp/src/core/state_management/amount/amount_bloc.dart';
import 'package:smp/src/presentations/widgets/textfield_widget.dart';

class SubDialog extends StatelessWidget {
  const SubDialog({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController amountController = TextEditingController();
    return Dialog(
      child: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFieldWidget(
              controller: amountController,
              name: 'Amount',
              icon: Icons.numbers,
              keyboardType: TextInputType.number,
            ),
            InkWell(
              
              onTap: () {
                var amountString = amountController.text;
                final amountModel = AmountModel(
                  dateTime: Timestamp.now(),
                  amount: int.parse(amountString),
                );
                BlocProvider.of<AmountBloc>(context).add(AddAmount(amountModel: amountModel));
                navPop(context);
              },
              child: Container(
                width: 100,
                height: kToolbarHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.firstColor,
                ),
                child: Center(
                  child: Text(
                    "Subtract",
                    style: Style.twelve.copyWith(color: Colors.white)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

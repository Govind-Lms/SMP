import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/models/voucher_model.dart';
import 'package:smp/src/core/state_management/voucher/voucher_bloc.dart';
import 'package:smp/src/presentations/views/total_amt/total_amt_screen.dart';
import 'package:smp/src/presentations/widgets/custom_box.dart';

class TotalAmtBox extends StatelessWidget {
  final ClientModel clientModel;
  const TotalAmtBox({super.key, required this.clientModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherBloc, VoucherState>(
      bloc: VoucherBloc()..add(LoadVouchers()),
      builder: (context, state) {
        if (state is VoucherInitial) {
          return CustomBox(
            onTap: () {},
            boxName: 'Total Amount',
            boxDetails: '0 Ks',
            color: AppColor.firstColor,
          );
        } else if (state is VoucherLoading) {
          return CustomBox(
            onTap: () {},
            boxName: 'Total Amount',
            boxDetails: '0 Ks',
            color: AppColor.firstColor,
          );
        } else if (state is VoucherSuccess) {
          int totalAmt = 0;
          final vouchers = state.vouchers;
    
          for (VoucherModel i in vouchers) {
            totalAmt = i.totalAmt + totalAmt;
          }
    
          return CustomBox(
            onTap: () {
              nav(
                  context,
                  TotalAmtScreen(
                    totalAmt: totalAmt,
                    clientmodel: clientModel,
                  ));
            },
            boxName: 'Subtracted Amt',
            boxDetails: '${clientModel.totalAmt} Ks',
            color: AppColor.firstColor,
          );
        } else {
          return CustomBox(
            onTap: () {},
            boxName: 'Total Amount',
            boxDetails: 'Error',
            color: AppColor.firstColor,
          );
        }
      },
    );
  }
}

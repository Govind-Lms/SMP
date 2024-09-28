import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';
import 'package:smp/src/presentations/views/total_amt/components/real_amount_part.dart';
import 'package:smp/src/presentations/views/total_amt/components/sub_amount_part.dart';
import 'package:smp/src/presentations/views/total_amt/components/sub_dialog.dart';
import 'package:smp/src/presentations/widgets/divider.dart';

class TotalAmtScreen extends StatelessWidget {
  final ClientModel clientmodel;
  final int totalAmt;
  const TotalAmtScreen({super.key, required this.totalAmt, required this.clientmodel});

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async{ 
        final clientModel = ClientModel(
          id: clientmodel.id,
          name: clientmodel.name,
          phoneNo: clientmodel.phoneNo,
          totalAmt: "${totalAmt - subtractedAmtNotifier.value}",
        );
        BlocProvider.of<ClientBloc>(context).add(UpdateClientAmount(clientModel));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Total Amt')),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  RealAmountPart(totalAmt: totalAmt),
                  const SubAmountPart(),
                  
                ],
              ),
            ),
            
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Column(
                  children: [
                    DividerWidget(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('Updated Total Amount', style: Style.fourteenBold),
                    //     ValueListenableBuilder<int>(
                    //       valueListenable: subtractedAmtNotifier,
                    //       builder: (context, subtractedAmt, child) {
                    //         print(subtractedAmt);
                    //         return Text(
                    //           "${totalAmt - subtractedAmt}",
                    //           style: Style.fourteenBold,
                    //         );
                    //       },
                    //     ),
      
                    //   ],
                    // ),
                    Gap(kToolbarHeight),
                  ],
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const SubDialog();
              },
            );
          },
          child: const Icon(Iconsax.minus),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/presentations/views/client/components/total_amt_box.dart';
import 'package:smp/src/presentations/views/client/components/voucher_screen.dart';
import 'package:smp/src/presentations/views/voucher/add_voucher/create_voucher.dart';
import 'package:smp/src/presentations/widgets/custom_box.dart';

class OnClickClient extends StatelessWidget {
  final ClientModel clientModel;
  final String index;

  const OnClickClient(
      {super.key, required this.index, required this.clientModel});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(clientModel.name.toUpperCase(), style: Style.sixteenBold),
              centerTitle: true,
              floating: false,
              pinned: true,
              // expandedHeight: 200.0,
              // flexibleSpace: FlexibleSpaceBar(
              //   background: Hero(
              //     tag: 'client$index',
              //     child: Center(
              //       child: Container(
              //         margin: const EdgeInsets.all(20.0),
              //         width: MediaQuery.sizeOf(context).width,
              //         decoration: BoxDecoration(
              //           color: AppColor.secondColor,
              //           borderRadius: BorderRadius.circular(10.0),
              //         ),
              //         child: ClipRRect(
              //           borderRadius: BorderRadius.circular(10.0),
              //           child: Image.asset(
              //             'assets/icons/client.png',
              //             fit: BoxFit.scaleDown,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  FittedBox(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TotalAmtBox(clientModel: clientModel),
                          
                          CustomBox(
                            color: Colors.green,
                            onTap: () {
                              clientIdNotifier.value = clientModel.id;
                              nav(context,
                                  NewInvoiceScreen(clientModel: clientModel));
                            },
                            boxName: 'Create',
                            boxDetails: 'Create Voucher',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Voucher History",style: Style.fourteenBold,)),
                  VoucherScreen(clientModel: clientModel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

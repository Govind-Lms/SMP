
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/models/voucher_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/voucher/voucher_bloc.dart';
import 'package:smp/src/presentations/views/voucher/add_voucher/components/add_voucher_components.dart';
import 'package:smp/src/presentations/widgets/custom_app_bar.dart';

import '../ticket/ticket_screen.dart';

class NewInvoiceScreen extends StatefulWidget {
  final ClientModel clientModel;
  const NewInvoiceScreen({super.key, required this.clientModel});

  @override
  State<NewInvoiceScreen> createState() => _NewInvoiceScreenState();
}

class _NewInvoiceScreenState extends State<NewInvoiceScreen> {
  
    @override
  void initState() {
    super.initState();
    
    // Reset the notifier when initializing to ensure clean state on re-entry
    generatedNotifier.value = false;
    
    // Generate the voucher ID once when the screen is first created
    if (voucherIdNotifier.value.isEmpty) {
      voucherIdNotifier.value = Random().nextInt(99999).toString();
    }
  }

  @override
  void dispose() {
    // Reset the value when the screen is disposed (when user leaves the screen)
    generatedNotifier.value = false;
    voucherIdNotifier.value = '';
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final clientModel = widget.clientModel;
    return Scaffold(
      appBar: const CustomAppBar(title: "Create Invoice",centerTitle: true),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            HeaderPart(name: clientModel.name, id: voucherIdNotifier.value,),
            const ItemsPart(),
            const AddItemPart(),

            ValueListenableBuilder(
              valueListenable: generatedNotifier,
              builder: (context, value, child) {

                if(value==true) {
                  return const Column(
                    children: [
                      TotalPart(),
                    ],
                  );
                }
                else {
                  return const SizedBox.shrink();
                }
              },
            ),




            
          ]))
        ],
      ),
      bottomNavigationBar: BottomNavPart(
        onTap: (){
          if(generatedNotifier.value == true){
            final voucherModel = VoucherModel(
              dateTime: Timestamp.now(),
              totalAmt: totalAmtGlobal,
              totalQty: totalQtyGlobal,
              voucherId: voucherIdNotifier.value,
            );
            BlocProvider.of<VoucherBloc>(context).add(AddVoucher(voucherModel));
            nav(context,  TicketPage(
              clientModel : widget.clientModel,
            ));
          } else{
            generatedNotifier.value = true;

          }
        },
      ),
    );
  }

}
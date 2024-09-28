import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/presentations/views/voucher/add_voucher/components/header_part.dart';
import 'package:smp/src/presentations/views/voucher/add_voucher/components/total_part.dart';
import 'package:smp/src/presentations/views/voucher/ticket/ticket_screen.dart';
import 'package:smp/src/presentations/views/voucher/view_voucher/components/view_item.dart';
import 'package:smp/src/presentations/widgets/custom_app_bar.dart';

class ViewVoucherScreen extends StatefulWidget {
  final ClientModel clientModel;
  const ViewVoucherScreen({super.key, required this.clientModel});

  @override
  State<ViewVoucherScreen> createState() => _ViewVoucherScreenState();
}

class _ViewVoucherScreenState extends State<ViewVoucherScreen> {
  
  @override
  void dispose() {
    voucherIdNotifier.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientModel = widget.clientModel;
    return Scaffold(
      appBar: const CustomAppBar(title: "Voucher View",centerTitle: true),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            HeaderPart(name: clientModel.name,id: voucherIdNotifier.value,),
            const ViewItemsPart(),
            const TotalPart(),
          ]))
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: IconButton(
          icon: const Icon(Iconsax.next),
          onPressed: () async {
           
            nav(context,  TicketPage(clientModel: clientModel,));
          }
        ),
      ),
    
    );
  }

}
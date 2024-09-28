import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/voucher/voucher_bloc.dart';
import 'package:smp/src/presentations/views/voucher/conditions/empty_voucher_screen.dart';
import 'package:smp/src/presentations/views/voucher/view_voucher/view_voucher.dart';

class VoucherScreen extends StatelessWidget {
  final ClientModel clientModel;
  const VoucherScreen({super.key, required this.clientModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherBloc, VoucherState>(
      bloc: VoucherBloc()..add(LoadVouchers()),
      builder: (context, state) {
        if (state is VoucherLoading) {
          return const Center(child: CircularProgressIndicator.adaptive(),);
        } else if (state is VoucherInitial) {
          return const Center(child: CircularProgressIndicator.adaptive(),);
        } else if (state is VoucherSuccess) {
          final vouchers = state.vouchers;

          if (vouchers.isEmpty) {
            return const EmptyVoucherScreen();
          } else {
            
            return Wrap(
              children: List.generate(
                vouchers.length,
                (index) {
                  final voucherModel = vouchers[index];
                  final timestamp = voucherModel.dateTime;
                  return InkWell(
                    onTap: () {
                      
                      voucherIdNotifier.value = voucherModel.voucherId;
                      nav(context, ViewVoucherScreen(clientModel: clientModel));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                        top: 20.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 100.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(3, 3),
                            blurRadius: 6.0,
                            color: Colors.black12,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10.0),
                          Container(
                            width: MediaQuery.of(context).size.width * .15,
                            height: MediaQuery.of(context).size.width * .15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: AppColor.secondColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/icons/invoice.png',
                                width: MediaQuery.of(context).size.width * .1,
                                height: MediaQuery.of(context).size.width * .1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${timestamp.toDate().day}/${timestamp.toDate().month}/${timestamp.toDate().year}',
                                style: Style.sixteen.copyWith(
                                  fontSize:
                                      MediaQuery.of(context).size.width * .04,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Text(
                                voucherModel.voucherId,
                                style: Style.fourteen.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width * .04,
                                    color:
                                        const Color.fromARGB(255, 58, 45, 45)),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Total Cost',
                                  style: Style.sixteenBold.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width * .04,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  '${voucherModel.totalAmt}',
                                  style: Style.sixteen.copyWith(
                                    fontSize:
                                        MediaQuery.of(context).size.width * .04,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        } else {
          return const Text("Error");
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/models/amount_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/amount/amount_bloc.dart';
import 'package:smp/src/presentations/widgets/date_format.dart';

class SubAmountPart extends StatelessWidget {
  const SubAmountPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.sizeOf(context).height-200,
      margin: const EdgeInsets.all(10),
      child: BlocListener<AmountBloc, AmountState>(
        bloc: AmountBloc()..add(LoadAmount()),
        listener: (context, state) {
          if(state is AmountAdded){
            BlocProvider.of<AmountBloc>(context).add(LoadAmount());
          }
        },
        child: BlocBuilder<AmountBloc, AmountState>(
          bloc: AmountBloc()..add(LoadAmount()),
          builder: (context, state) {
            if (state is AmountInitial) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is AmountLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is AmountSuccess) {
              int subTotal = 0;
              final amountList = state.amountList;
    
              for (AmountModel i in amountList) {
                subTotal = i.amount + subTotal;
              }
              subtractedAmtNotifier.value = subTotal;

              
              if (amountList.isNotEmpty) {
                return Wrap(
                  children: List.generate(amountList.length, (index){
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal : 10),
                      title: Text(
                        'Sub Amount',
                        style: Style.twelveBold,
                      ),
                      subtitle: DateFormatWidget(dateTime: amountList[index].dateTime,getMinute: true,),
                      trailing: Text(
                        "-${amountList[index].amount}",
                        style: Style.twelveBold,
                      ),
                    );
                  })
                );
              } else {
                return ListTile(
                      // contentPadding: const EdgeInsets.symmetric(horizontal : 10),
                      title: Text(
                        'Sub Amount',
                        style: Style.twelveBold,
                      ),
                      trailing: Text(
                        "0",
                        style: Style.twelveBold,
                      ),
                    );
              }
            } else {
              return Text(state.props.toString());
            }
          },
        ),
      ),
    );
  }
}

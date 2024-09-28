import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/client_model.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';
import 'package:smp/src/presentations/views/client/client_screen.dart';
import 'package:smp/src/presentations/widgets/custom_box.dart';

class OptionsPart extends StatelessWidget {
  const OptionsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2/1.3),
      delegate: SliverChildListDelegate([
        BlocBuilder<ClientBloc, ClientState>(
          bloc: ClientBloc()..add(LoadClient()),
          builder: (context, state) {
            if(state is ClientLoading){
              return const CustomBox(
                boxName: 'Total Clients',
                boxDetails: "0 Clients",
                color: AppColor.firstColor,
              );
            }
            else if(state is ClientInitial){
              return const CustomBox(
                boxName: 'Total Clients',
                boxDetails: "0 Clients",
                color: AppColor.firstColor,
              );
            }
            else if (state is ClientSuccess) {
              final list = state.clientList;
              return CustomBox(
                boxName: 'Total Clients',
                boxDetails: list.length.toString(),
                color: AppColor.firstColor,
                onTap: () {
                  nav(context, const ClientScreen());
                },
              );
            } else {
              return const CustomBox(
                boxName: 'Total Clients',
                boxDetails: "0 Clients",
                color: AppColor.firstColor,
              );
            }
          },
        ),
        BlocBuilder<ClientBloc, ClientState>(
          bloc: ClientBloc()..add(LoadClient()),
          builder: (context, state) {
            if(state is ClientInitial){
              return const CustomBox(
                boxName: 'Total Amount',
                boxDetails: "Initializing",
                color: Colors.green,
              );
            }
            else if(state is ClientLoading){
              return const CustomBox(
                boxName: 'Total Amount',
                boxDetails: "Loading",
                color: Colors.green,
              );
            }
            else if (state is ClientSuccess) {
              int total = 0;
              final list = state.clientList;
              if(list.isNotEmpty){
                final clients = state.clientList;
                for(ClientModel i in clients){
                  total = total + int.parse(i.totalAmt!);
                }
                return CustomBox(
                  boxName: 'Overall Amount',
                  boxDetails: "$total Ks",
                  color: Colors.green,
                );
              }else{
                return const CustomBox(
                  boxName: 'Total Amount',
                  boxDetails: "0 Ks",
                  color: Colors.green,
                );
              }
            } 
            else {
              return const CustomBox(
                boxName: 'Total Amount',
                boxDetails: "Error",
                color: Colors.green,
              );
            }
          },
        ),
      ]),
    );
  }
}

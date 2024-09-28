import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';
import 'package:smp/src/presentations/views/client/details/on_click_client.dart';

class RecentClientsPart extends StatelessWidget {
  const RecentClientsPart({super.key});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<ClientBloc, ClientState>(
        bloc: ClientBloc()..add(LoadClient()),
        builder: (context, state) {
          if (state is ClientInitial) {
            return const Text("Initial");
          } else if (state is ClientLoading) {
            return const Text("Loading");
          } else if (state is ClientSuccess) {
            final clientList = state.clientList;
            if (clientList.isNotEmpty) {
              return Wrap(
                children: List.generate(clientList.length < 5 ? clientList.length : 5, (index) {
                  final clientModel = clientList[index];
                  return ListTile(
                    onTap: () {
                      clientIdNotifier.value = clientList[index].id;
                      nav(
                        context,
                        OnClickClient(
                          clientModel: clientModel,
                          index: index.toString(),
                        ),
                      );
                    },
                    leading: Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: AppColor.secondColor,
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/icons/client.png',
                          width: 50.0,
                          height: 50.0,
                        ),
                      ),
                    ),
                    title: Text(clientModel.name, style: Style.sixteen),
                    subtitle: Text(clientModel.phoneNo,style: Style.fourteen),
                    trailing: StreamBuilder(
                      stream: clientRef
                          .doc(clientModel.id)
                          .collection('vouchers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            '''Total
${snapshot.data!.docs.length}''',
                            style: Style.sixteen,
                            textDirection: TextDirection.rtl,
                          );
                        } else {
                          return Text(
                            '''Total
0''',
                            style: Style.sixteen,
                            textDirection: TextDirection.rtl,
                          );
                        }
                      },
                    ),
                  );
                },),
              );
              
            } else {
              return const Text("No Clients");
            }
          } else {
            return Text(state.props.toString());
          }
        },
      ),
    );
  }
}

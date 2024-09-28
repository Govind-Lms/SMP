import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';
import 'package:smp/src/core/state_management/client/client_bloc.dart';
import 'package:smp/src/presentations/views/client/details/on_click_client.dart';
import 'package:smp/src/presentations/views/client/components/add_client.dart';
import 'package:smp/src/const/constants.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/presentations/widgets/custom_app_bar.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({super.key});

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "Clients",centerTitle: true),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showMaterialModalBottomSheet(
                context: context,
                shape: const BeveledRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                builder: (context) {
                  return const AddClientScreen();
                });
          },
        ),
        body: BlocBuilder<ClientBloc, ClientState>(
          bloc: ClientBloc()..add(LoadClient()),
          builder: (context, state) {
            if (state is ClientInitial) {
              return const Text("Initial");
            } else if (state is ClientLoading) {
              return const Text("Loading");
            } else if (state is ClientSuccess) {
              final clientList = state.clientList;
              if (clientList.isNotEmpty) {
                return ListView.builder(
                  itemCount: clientList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final clientModel = clientList[index];
                    return ListTile(
                      onTap: () {
                        clientIdNotifier.value= clientList[index].id;
                        nav(
                          context,
                          OnClickClient(
                            clientModel: clientModel,
                            index: index.toString(),
                          ),
                        );
                      },
                      leading: Hero(
                        tag: 'client$index',
                        child: Container(
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
                      ),
                      title: Text(clientModel.name, style: Style.sixteen),
                      subtitle: Text(
                        clientModel.phoneNo,
                        style: Style.fourteen.copyWith(
                            color: const Color.fromARGB(255, 58, 45, 45)),
                      ),
                      // trailing: StreamBuilder(
                      //   stream: clientRef
                      //       .doc(clientModel.id)
                      //       .collection('vouchers')
                      //       .snapshots(),
                      //   builder: (context, snapshot) {
                      //     if (snapshot.hasData) {
                      //       return Text(
                      //         '${snapshot.data!.docs.length}',
                      //         style: Style.eighteen,
                      //       );
                      //     } else {
                      //       return Text(
                      //         '0',
                      //         style: Style.eighteen,
                      //       );
                      //     }
                      //   },
                      // ),
                      trailing: Text(
                        'Total Amt\n'
                        '${clientModel.totalAmt}',
                        style: Style.fourteen,
                        textDirection: TextDirection.rtl,
                      ),
                    );
                  },
                );
              } else {
                return const Text("No Clients");
              }
            } else {
              return Text(state.props.toString());
            }
          },
        ));
  }
}

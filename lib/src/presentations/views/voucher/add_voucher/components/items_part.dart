import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/const/style.dart';
import 'package:smp/src/core/state_management/item/item_bloc.dart';
import 'package:smp/src/presentations/widgets/selected_dialog.dart';

class ItemsPart extends StatelessWidget {
  const ItemsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.all(20.0),
        child: BlocListener<ItemBloc, ItemState>(
          listener: (context, state) {
            if (state is ItemAddedSuccess) {
              BlocProvider.of<ItemBloc>(context).add(LoadItem());
            }
          },
          child: BlocBuilder<ItemBloc, ItemState>(
            bloc: ItemBloc()..add(LoadItem()),
            builder: (context, state) {
              if (state is ItemInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ItemLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ItemSuccess) {
                final items = state.items;

                return DataTable(
                  showCheckboxColumn: false,
                  columnSpacing: 20,
                  dataTextStyle: Style.twelve,
                  headingTextStyle: Style.twelveBold,
                  columns: const [
                    DataColumn(
                        label: Text(
                      'Name',
                    )),
                    DataColumn(
                        numeric: true,
                        label: Text(
                          'Price',
                        )),
                    DataColumn(
                        label: Text(
                      'Qty',
                    )),
                    DataColumn(
                        numeric: true,
                        label: Text(
                          'Total',
                        )),
                  ],
                  rows: List.generate(
                    items.length,
                    (index) {
                      final item = items[index];
                      return DataRow(
                        onSelectChanged: (value) {
                          showDialog(context: context, builder: (context) {
                            return SelectedDialog(item: item);
                          },);
                        },
                        cells: [
                          DataCell(Text(
                            item.itemName,
                          )),
                          DataCell(Text(
                            item.price.toString(),
                          )),
                          DataCell(Text(
                            "${item.quantity} *${item.packageType}",
                          )),
                          DataCell(Text(
                            item.itemTotal.toString(),
                          )),
                        ],
                      );
                    },
                  ),
                );
              } else if (state is ItemError) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}

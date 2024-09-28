import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smp/src/core/helpers/amount_database.dart';
import 'package:smp/src/core/models/amount_model.dart';

part 'amount_event.dart';
part 'amount_state.dart';

class AmountBloc extends Bloc<AmountEvent, AmountState> {
  AmountBloc() : super(AmountInitial()) {
    on<LoadAmount>(loadAmounts);
    on<AddAmount>(addAmounts);
  }
  final _databaseService = AmountDatabase();

  Future<void> loadAmounts(LoadAmount event, state) async {
    try {
      emit(AmountLoading());
      _databaseService.getAmounts().listen((amounts){
        emit(AmountSuccess(amountList: amounts));
      });
    } catch (e) {
      emit( const AmountError('Failed to load Amounts'));
    }
  }


  Future<void> addAmounts(AddAmount event, state) async {
    try {
      emit(AmountLoading());
      await _databaseService.addAmounts(event.amountModel);
      emit(AmountAdded());
    } catch (e) {
      emit(const AmountError("Error in adding Amount info"));
    }
  }
}

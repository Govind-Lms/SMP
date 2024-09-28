import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smp/src/core/helpers/voucher_database.dart';
import 'package:smp/src/core/models/voucher_model.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  VoucherBloc() : super(VoucherInitial()) {
    on<LoadVouchers>(loadVouchers);
    on<AddVoucher>(addVouchers);
    on<DeleteVoucher>(deleteVouchers);
  }

  final _databaseService = VoucherDatabase();

  Future<void> loadVouchers(LoadVouchers event, state)async{
     try {
      emit(VoucherLoading());
      _databaseService.getVouchers().listen((vouchers){
        emit(VoucherSuccess(vouchers: vouchers));
      });

    } catch (e) {
      emit(const VoucherError('Failed to load vouchers'));
    }
  }

  Future<void> addVouchers(AddVoucher event, state)async{
     try {
      emit(VoucherLoading());
      await _databaseService.addVouchers(event.voucherModel);
    } catch (e) {
      emit(const VoucherError('Failed to add vouchers'));
    }
  }

  Future<void> deleteVouchers(DeleteVoucher event, state)async{
     try {
      emit(VoucherLoading());
      await _databaseService.deleteVoucher(event.voucherModel);
    } catch (e) {
      emit(const VoucherError('Failed to delete vouchers'));
    }
  }
}

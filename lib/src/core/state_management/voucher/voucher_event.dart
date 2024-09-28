part of 'voucher_bloc.dart';

sealed class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object> get props => [];
}

final class LoadVouchers extends VoucherEvent{
  @override
  List<Object> get props => [];
}

final class AddVoucher extends VoucherEvent{
  final VoucherModel voucherModel;

  const AddVoucher(this.voucherModel);
  @override
  List<Object> get props => [voucherModel];
}


final class DeleteVoucher extends VoucherEvent{
  final VoucherModel voucherModel;

  const DeleteVoucher(this.voucherModel);
  @override
  List<Object> get props => [voucherModel];
}

final class UpdateVoucher extends VoucherEvent{
  final VoucherModel voucherModel;

  const UpdateVoucher(this.voucherModel);
  @override
  List<Object> get props => [voucherModel];
}
part of 'voucher_bloc.dart';

sealed class VoucherState extends Equatable {
  final List<VoucherModel>? vouchers;
  const VoucherState({this.vouchers});
  
  @override
  List<Object?> get props => [];
}

final class VoucherInitial extends VoucherState {
  VoucherInitial() : super(vouchers: []);
  @override
  List<Object?> get props => [];
}

final class VoucherLoading extends VoucherState {
  VoucherLoading() : super(vouchers: []);
  @override
  List<Object?> get props => [];
}

final class VoucherSuccess extends VoucherState {
  @override
  final List<VoucherModel> vouchers;

  const VoucherSuccess({required this.vouchers});
  @override
  List<Object?> get props => [vouchers];
}

final class VoucherError extends VoucherState {
  final String errorMessage;
  const VoucherError(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}


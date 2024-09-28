part of 'amount_bloc.dart';

sealed class AmountState extends Equatable {
  final List<AmountModel>? amountList;
  const AmountState({this.amountList});
  
  @override
  List<Object?> get props => [amountList];
}

final class AmountInitial extends AmountState {
  AmountInitial() : super(amountList: []);
  @override
  List<Object?> get props => [];
}

final class AmountLoading extends AmountState {
  AmountLoading() : super(amountList: []);
  @override
  List<Object?> get props => [];
}


final class AmountAdded extends AmountState {
  AmountAdded() : super(amountList: []);
  @override
  List<Object?> get props => [];
}

final class AmountSuccess extends AmountState {
  final List<AmountModel> amountList;
  const AmountSuccess({required this.amountList});
    @override
  List<Object?> get props => [amountList];
}

final class AmountError extends AmountState {
  final String errorMessage;
  const AmountError( this.errorMessage);
      @override
  List<Object?> get props => [errorMessage];
}


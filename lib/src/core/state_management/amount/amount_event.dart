part of 'amount_bloc.dart';

sealed class AmountEvent extends Equatable {
  const AmountEvent();

  @override
  List<Object> get props => [];
}

final class LoadAmount extends AmountEvent{
  @override
  List<Object> get props => [];
}


final class AddAmount extends AmountEvent{
  final AmountModel amountModel;

  const AddAmount({required this.amountModel});
  @override
  List<Object> get props => [amountModel];
}


final class UpdateAmount extends AmountEvent{
  final AmountModel amountModel;

  const UpdateAmount({required this.amountModel});
  @override
  List<Object> get props => [amountModel];
}



final class DeleteAmount extends AmountEvent{
  final AmountModel amountModel;

  const DeleteAmount({required this.amountModel});
  @override
  List<Object> get props => [amountModel];
}

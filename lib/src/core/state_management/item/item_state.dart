part of 'item_bloc.dart';

sealed class ItemState extends Equatable {
  final List<Item>? items;

  const ItemState({this.items});
  
  @override
  List<Object?> get props => [];
}

final class ItemInitial extends ItemState {
  ItemInitial() : super(items: []);

  @override
  List<Object?> get props => [];
}
final class ItemLoading extends ItemState {
   ItemLoading() : super(items: []);

  @override
  List<Object?> get props => [];
}
final class ItemSuccess extends ItemState {
   final List<Item> items;

  const ItemSuccess({required this.items});
  @override
  List<Object?> get props => [items];
}

final class ItemAddedSuccess extends ItemState {
  const ItemAddedSuccess();
  @override
  List<Object?> get props => [];
}

final class ItemError extends ItemState {
   final String errorMessage;

  const ItemError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

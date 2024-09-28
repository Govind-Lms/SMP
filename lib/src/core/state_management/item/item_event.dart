part of 'item_bloc.dart';

sealed class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}


final class LoadItem extends ItemEvent{
  @override
  List<Object> get props => [];
}

final class AddItem extends ItemEvent{
  final Item item;
  const AddItem( this.item);
  @override
  List<Object> get props => [item];
}

final class UpdateItem extends ItemEvent{
  final Item item;
  const UpdateItem(this.item);
  @override
  List<Object> get props => [item];
}

final class DeleteItem extends ItemEvent{
  final Item item;
  const DeleteItem( this.item);
  @override
  List<Object> get props => [item];
}
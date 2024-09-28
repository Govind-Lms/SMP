part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}


final class LoadClient extends ClientEvent{
  @override
  List<Object> get props => [];
}

final class AddClient extends ClientEvent{
  final ClientModel clientModel;
  const AddClient(this.clientModel);
  @override
  List<Object> get props => [clientModel];
}

final class UpdateClient extends ClientEvent{
  final ClientModel clientModel;
  const UpdateClient(this.clientModel);
  @override
  List<Object> get props => [clientModel];
}

final class DeleteClient extends ClientEvent{
  final ClientModel clientModel;
  const DeleteClient(this.clientModel);
  @override
  List<Object> get props => [clientModel];
}



final class UpdateClientAmount extends ClientEvent{
  final ClientModel clientModel;
  const UpdateClientAmount(this.clientModel);
  @override
  List<Object> get props => [clientModel];
}


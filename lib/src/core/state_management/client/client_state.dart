part of 'client_bloc.dart';

sealed class ClientState extends Equatable {
  final List<ClientModel>? clientList;
  const ClientState({this.clientList});
  
  @override
  List<Object?> get props => [];
}

final class ClientInitial extends ClientState {
  ClientInitial(): super(clientList: []);
  @override
  List<Object?> get props => [];
}

final class ClientLoading extends ClientState{
  ClientLoading(): super(clientList: []);
  @override
  List<Object?> get props => [];
  
}

final class ClientSuccess extends ClientState{

  final List<ClientModel> clientList;

  const ClientSuccess({required this.clientList});
  @override
  List<Object?> get props => [clientList];
}

final class ClientError extends ClientState{
  final String errorMessage;
  const ClientError(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}



final class ClientTotalUpdated extends ClientState{
  const ClientTotalUpdated();
  @override
  List<Object> get props => [];
}

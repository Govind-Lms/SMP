import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smp/src/core/helpers/client_database.dart';
import 'package:smp/src/core/models/client_model.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ClientBloc() : super(ClientInitial()) {
    on<LoadClient>(loadClients);
    on<AddClient>(addClients);
    on<UpdateClientAmount>(updateClientAmount);
  }

  final _databaseService = ClientDatabase();





  Future<void> loadClients(LoadClient event, state) async {
    try {
      emit(ClientLoading());
      _databaseService.getClients().listen((clients){
        emit(ClientSuccess(clientList:clients));
      });
    } catch (e) {
      emit(const ClientError('Failed to load clients'));
    }
  }


  Future<void> addClients(AddClient event, state) async {
    try {
      emit(ClientLoading());
      await _databaseService.addClient(event.clientModel);
    } catch (e) {
      emit(const ClientError("Error in adding Client info"));
    }
  }


  Future<void> updateClientAmount(UpdateClientAmount event, state) async {
    try {
      emit(ClientLoading());
      await _databaseService.updateClientAmount(event.clientModel);
      emit(const ClientTotalUpdated());
    } catch (e) {
      emit(const ClientError("Error in adding Client info"));
    }
  }

}



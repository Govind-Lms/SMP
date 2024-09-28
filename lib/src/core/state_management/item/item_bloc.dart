import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smp/src/core/helpers/item_database.dart';
import 'package:smp/src/core/models/item_model.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial()) {
    on<LoadItem>(loadItems);
    on<AddItem>(addItems);
    on<UpdateItem>(updateItems);
    on<DeleteItem>(deleteItems);
  }

  final _databaseService = ItemDatabase();

  Future<void> loadItems(LoadItem event,state) async{
    try{
      emit(ItemLoading());
      _databaseService.getItems().listen((items){
        emit(ItemSuccess(items: items));
      });
    }
    catch(e){
      emit(const ItemError("Error loading items"));
    }
  }


  Future<void> addItems(AddItem event,state) async{
    try{
      emit(ItemLoading());
      await _databaseService.addItems(event.item);
      emit(const ItemAddedSuccess());
    }
    catch(e){
      emit(const ItemError("Error loading items"));
    }
  }

  Future<void> updateItems(UpdateItem event,state) async{
    try{
      emit(ItemLoading());
      await _databaseService.updateItems(event.item);
    }
    catch(e){
      emit(const ItemError("Error loading items"));
    }
  }

  Future<void> deleteItems(DeleteItem event,state) async{
    try{
      emit(ItemLoading());
      await _databaseService.deleteItems(event.item);
    }
    catch(e){
      emit(const ItemError("Error loading items"));
    }
  }

  


}


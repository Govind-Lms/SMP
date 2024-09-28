import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/client_model.dart';

class ClientDatabase{
  
  Stream<List<ClientModel>> getClients() {
    return clientRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return ClientModel(
          name: data['name'],
          phoneNo: data['phoneNo'],
          id: data['id'],
          totalAmt: data['totalAmt'] ?? '0',
        );
      }).toList();
    });
  }

  
  Future<void> addClient(ClientModel clientModel)async{
    await clientRef
        .doc(clientModel.id)
        .set({
      'name': clientModel.name,
      'phoneNo': clientModel.phoneNo,
      'id': clientModel.id,
    });
  }
  
  Future<void> deleteClient(ClientModel clientModel)async{
    await clientRef.doc(clientModel.id).delete();
  }
  
  Future<void> updateClient(ClientModel clientModel)async{
    await clientRef
        .doc(clientModel.id)
        .update({
      'name': clientModel.name,
      'phoneNo': clientModel.phoneNo,
    });
  }

  Future<void> updateClientAmount(ClientModel clientModel)async{
    await clientRef.doc(clientModel.id).update({
      'totalAmt': clientModel.totalAmt
    });
  }
}
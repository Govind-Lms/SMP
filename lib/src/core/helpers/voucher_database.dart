import 'package:smp/src/const/constants.dart';
import 'package:smp/src/core/models/voucher_model.dart';
import 'package:smp/src/core/notifiers/id_notifiers.dart';

class VoucherDatabase{

  Stream<List<VoucherModel>> getVouchers() {
    return clientRef.doc(clientIdNotifier.value).collection('vouchers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return VoucherModel(
          voucherId: data['voucherId'],
          totalAmt: data['totalAmt'],
          totalQty: data['totalQty'],
          dateTime: data['dateTime'],
        );
      }).toList();
    });
  }

  Future<void> addVouchers(VoucherModel voucherModel) async{
    return  voucherRef.doc(voucherModel.voucherId).set({
      'dateTime' : voucherModel.dateTime,
      'totalAmt' : voucherModel.totalAmt,
      'totalQty' : voucherModel.totalQty,
      'voucherId': voucherModel.voucherId,
    });
  }
  Future<void> updateVouchers(VoucherModel voucherModel) async{
    return  voucherRef.doc(voucherModel.voucherId).set({
      'dateTime' : voucherModel.dateTime,
      'totalAmt' : voucherModel.totalAmt,
      'totalQty' : voucherModel.totalQty,
    });
  }
  Future<void> deleteVoucher(VoucherModel voucherModel) async{
    return  voucherRef.doc(voucherModel.voucherId).delete();
  }
  
}
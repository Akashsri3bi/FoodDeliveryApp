import 'package:food/models/voucher_model.dart';

abstract class BaseVoucherRepository {
  Future<bool> searchVoucher(String code);
  Stream<List<Voucher>> getVouchers();
}

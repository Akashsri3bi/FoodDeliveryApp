import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food/models/voucher_model.dart';
import 'package:food/repositories/vouvher/voucher_repository.dart';

part 'voucher_event.dart';
part 'voucher_state.dart';

class VoucherBloc extends Bloc<VoucherEvent, VoucherState> {
  final VoucherRepository _voucherRepository;
  StreamSubscription? _voucherSubscription;

  VoucherBloc({required VoucherRepository voucherRepository})
      : _voucherRepository = voucherRepository,
        super(VoucherLoading()) {
    on<LoadVouchers>(_onLoadVouchers);
    on<UpdateVouchers>(_onUpdateVouchers);
    on<SelectVouchers>(_onSelectVouchers);
  }

  void _onLoadVouchers(LoadVouchers event, Emitter<VoucherState> emit) {
    _voucherSubscription?.cancel();
    _voucherSubscription = _voucherRepository.getVouchers().listen((vouchers) {
      add(UpdateVouchers(vouchers: vouchers));
    });
  }

  void _onUpdateVouchers(UpdateVouchers event, Emitter<VoucherState> emit) {
    emit(
      VoucherLoaded(vouchers: event.vouchers),
    );
  }

  void _onSelectVouchers(SelectVouchers event, Emitter<VoucherState> emit) {
    emit(
      VoucherSelected(voucher: event.voucher),
    );
  }
}

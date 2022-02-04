import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food/bloc/voucher/voucher_bloc.dart';
import 'package:food/models/basket_model.dart';
import 'package:food/models/delivery_time_model.dart';
import 'package:food/models/menu_item_model.dart';
import 'package:food/models/voucher_model.dart';

part 'basket_event.dart';
part 'basket_state.dart';

class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final VoucherBloc _voucherBloc;
  late StreamSubscription _voucherSubscription;
  BasketBloc({required VoucherBloc voucherBloc})
      : _voucherBloc = voucherBloc,
        super(BasketLoading());

  @override
  Stream<BasketState> mapEventToState(BasketEvent event) async* {
    if (event is StartBasket) {
      yield* _mapStartBasketToState();
    } else if (event is AddItem) {
      yield* _mapAddItemToState(event, state);
    } else if (event is RemoveItem) {
      yield* _mapRemoveItemToState(event, state);
    } else if (event is RemoveAllItem) {
      yield* _mapRemoveAllItemToState(event, state);
    } else if (event is ToggleSwitch) {
      yield* _mapToggleSwitchToState(event, state);
    } else if (event is ApplyVoucher) {
      yield* _mapApplyVoucherToState(event, state);
    } else if (event is SelectDeliveryTime) {
      yield* _mapSelectDeliveryTimeToState(event, state);
    }

    _voucherSubscription = _voucherBloc.stream.listen((state) {
      if (state is VoucherSelected) {
        add(ApplyVoucher(state.voucher));
      }
    });
  }

  Stream<BasketState> _mapRemoveAllItemToState(
    RemoveAllItem event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
          basket: state.basket.copyWith(
            items: List.from(state.basket.items)
              ..removeWhere((item) => item == event.item),
          ),
        );
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapApplyVoucherToState(
    ApplyVoucher event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(voucher: event.voucher));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapSelectDeliveryTimeToState(
    SelectDeliveryTime event,
    BasketState state,
  ) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(deliveryTime: event.deliveryTime));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapStartBasketToState() async* {
    yield BasketLoading();
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      yield const BasketLoaded(basket: Basket());
    } catch (_) {}
  }

  Stream<BasketState> _mapAddItemToState(
      AddItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
                items: List.from(state.basket.items)..add(event.item)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapRemoveItemToState(
      RemoveItem event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
                items: List.from(state.basket.items)..remove(event.item)));
      } catch (_) {}
    }
  }

  Stream<BasketState> _mapToggleSwitchToState(
      ToggleSwitch event, BasketState state) async* {
    if (state is BasketLoaded) {
      try {
        yield BasketLoaded(
            basket: state.basket.copyWith(
          cutlery: !state.basket.cutlery,
        ));
      } catch (_) {}
    }
  }
}

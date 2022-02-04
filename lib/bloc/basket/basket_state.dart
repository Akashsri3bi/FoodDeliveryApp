part of 'basket_bloc.dart';

abstract class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

class BasketLoading extends BasketState {
  @override
  List<Object> get props => [];
}

class BasketLoaded extends BasketState {
  final Basket basket;

  const BasketLoaded({required this.basket});

  @override
  List<Object> get props => [basket];
}

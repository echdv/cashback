part of 'basket_bloc.dart';

abstract class BasketState {
  const BasketState();
}

class BasketInitial extends BasketState {}

class SuccessOrderCreateState extends BasketState {
  final OrderModel orderModel;

  SuccessOrderCreateState({required this.orderModel});
}

class SuccessOrderCreate1State extends BasketState {}

class OrderCreateLoadingState extends BasketState {}

class OrderCreateErrorState extends BasketState {
  final CatchException error;

  OrderCreateErrorState({required this.error});
}

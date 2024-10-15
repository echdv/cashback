
part of 'basket_bloc.dart';

abstract class BasketEvent {
  const BasketEvent();
}

class OrderCreateEvent extends BasketEvent {
  final String id;
  final String cashback;

  OrderCreateEvent({
    required this.id,
    required this.cashback,
  });
}

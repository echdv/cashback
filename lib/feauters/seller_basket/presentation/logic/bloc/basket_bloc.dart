import 'package:cashback/feauters/seller_basket/data/models/order_model.dart';
import 'package:cashback/feauters/seller_basket/domain/use_case/basket_use_case.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'basket_event.dart';
part 'basket_state.dart';

@injectable
class BasketBloc extends Bloc<BasketEvent, BasketState> {
  final BasketUseCase useCase;
  BasketBloc(this.useCase) : super(BasketInitial()) {
    on<OrderCreateEvent>((event, emit) async {
      emit(OrderCreateLoadingState());

      await useCase
          .postOrder(event.id, event.cashback)
          .then((orderModel) =>
              emit(SuccessOrderCreateState(orderModel: orderModel)))
          .then((value) => emit(SuccessOrderCreate1State()))
          .onError((error, stackTrace) => emit(OrderCreateErrorState(
              error: CatchException.convertException(error))));
    });
  }
}

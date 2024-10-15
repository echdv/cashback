import 'package:cashback/feauters/balance/data/models/sale_info_model.dart';
import 'package:cashback/feauters/balance/data/models/sale_model.dart';
import 'package:cashback/feauters/balance/domain/use_case/sale_use_case.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'sale_event.dart';
part 'sale_state.dart';

@injectable
class SaleBloc extends Bloc<SaleEvent, SaleState> {
  final SaleUseCase useCase;

  SaleBloc(this.useCase) : super(SaleInitial()) {
    on<SaleEvent>((event, emit) {});

    on<GetSaleEvent>((event, emit) async {
      if (event.isFirstCall) {
        emit(SaleLoadingState());
      }

      await useCase
          .getSale(event.page)
          .then((saleModel) => emit(SaleLoadedState(saleModel: saleModel)))
          .onError((error, stackTrace) => emit(
              SaleErrorSate(error: CatchException.convertException(error))));
    });

    on<GetSaleInfoEvent>((event, emit) async {
      emit(SaleLoadingState());

      await useCase
          .getSaleInfo(event.date)
          .then((value) => emit(SaleInfoLoadedState(saleInfoModel: value)))
          .onError((error, stackTrace) => emit(
              SaleErrorSate(error: CatchException.convertException(error))));
    });
  }
}

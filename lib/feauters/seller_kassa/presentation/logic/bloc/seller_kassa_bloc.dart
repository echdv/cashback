import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_date_model.dart';
import 'package:cashback/feauters/seller_kassa/data/model/seller_kassa_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../internal/helpers/catch_exception_helper.dart';
import '../../../domain/use_case/seller_kassa_use_case.dart';

part 'seller_kassa_event.dart';
part 'seller_kassa_state.dart';

@singleton
class SellerKassaBloc extends Bloc<SellerKassaEvent, SellerKassaState> {
  final SellerUseCase useCase;

  SellerKassaBloc(this.useCase) : super(SellerKassaInitial()) {
    on<GetSellerKassaDateEvent>(
      (event, emit) async {
        if (event.isFirstCall == true) {
          emit(SellerKassaAllLoadingState());
        }

        await useCase
            .getSellerKassaDate(event.date ?? '', event.page ?? 1)
            .then((sellerKassaDateModel) => emit(SellerKassaDateLoadedState(
                sellerKassaDateModel: sellerKassaDateModel)))
            .onError(
              (error, stackTrace) => emit(SellerKassaErrorState(
                  error: CatchException.convertException(error))),
            );
      },
    );

    on<GetSellerKassaInfoEvent>(
      (event, emit) async {
        if (event.isFirstCall == true) {
          emit(SellerKassaLoadingState());
        }

        await useCase
            .getSellerKassaInfo(event.minDate, event.page!)
            .then(
              (sellerKassaModel) => emit(
                SellerKassaInfoLoadedState(sellerKassaModel: sellerKassaModel),
              ),
            )
            .onError(
              (error, stackTrace) => emit(SellerKassaErrorState(
                  error: CatchException.convertException(error))),
            );
      },
    );
  }
}

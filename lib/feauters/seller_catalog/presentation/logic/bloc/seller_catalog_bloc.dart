import 'package:cashback/feauters/seller_catalog/data/model/seller_product_model.dart';
import 'package:cashback/feauters/seller_catalog/domain/use_case/seller_catalog_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../internal/helpers/catch_exception_helper.dart';
import '../../../data/model/seller_catalog_model.dart';
part 'seller_catalog_event.dart';
part 'seller_catalog_state.dart';

@injectable
class SellerCatalogBloc extends Bloc<SellerCatalogEvent, SellerCatalogState> {
  final SellerCatalogUseCase useCase;
  SellerCatalogBloc(this.useCase) : super(SellerCatalogInitial()) {
    on<SellerCatalogEvent>((event, emit) {});

    on<SellerGetCategoryEvent>((event, emit) async {
      emit(SellerCatalogLoadingState());

      await useCase
          .getCategory()
          .then((categoryModel) =>
              (emit(SellerCatalogLoadedState(categoryModel: categoryModel))))
          .onError((error, stackTrace) => emit(SellerCatalogErrorState(
              error: CatchException.convertException(error))));
    });

    on<GetSellerProductEvent>((event, emit) async {
      emit(SellerCatalogLoadingState());

      await useCase
          .getProduct(event.id)
          .then((productModel) =>
              emit(ProductSellerLoadedState(productModel: productModel)))
          .onError((error, stackTrace) => emit(SellerCatalogErrorState(
              error: CatchException.convertException(error))));
    });
  }
}

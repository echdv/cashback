import 'package:cashback/feauters/catalog/data/model/branch_model.dart';
import 'package:cashback/feauters/catalog/data/model/catalog_model.dart';
import 'package:cashback/feauters/catalog/domain/use_case/catalog_use_case.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/product_model.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

@injectable
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogUseCase useCase;

  CatalogBloc(this.useCase) : super(CatalogInitial()) {
    on<CatalogEvent>((event, emit) {});

    on<GetBranchEvent>((event, emit) async {
      emit(CatalogLoadingState());

      await useCase
          .getBranch()
          .then((branchModel) =>
              (emit(BranchLoadedState(branchModel: branchModel))))
          .onError((error, stackTrace) => emit(CatalogErroeState(
              error: CatchException.convertException(error))));
    });

    on<GetCategoryEvent>((event, emit) async {
      emit(CatalogLoadingState());

      await useCase
          .getCategory(event.id)
          .then((categoryModel) =>
              emit(CatalogLoadedState(categoryModel: categoryModel)))
          .onError((error, stackTrace) => emit(CatalogErroeState(
              error: CatchException.convertException(error))));
    });

    on<GetProductEvent>((event, emit) async {
      emit(CatalogLoadingState());

      await useCase
          .getProduct(event.id)
          .then((productModel) =>
              emit(ProductLoadedState(productModel: productModel)))
          .onError((error, stackTrace) => emit(CatalogErroeState(
              error: CatchException.convertException(error))));
    });
  }
}

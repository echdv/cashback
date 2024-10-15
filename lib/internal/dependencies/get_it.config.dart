// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cashback/feauters/auth/data/repositories/auth_repository_impl.dart'
    as _i4;
import 'package:cashback/feauters/auth/domain/repositories/auth_repository.dart'
    as _i3;
import 'package:cashback/feauters/auth/domain/use_cases/auth_use_case.dart'
    as _i5;
import 'package:cashback/feauters/auth/presentation/logic/bloc/auth_bloc.dart'
    as _i28;
import 'package:cashback/feauters/balance/data/repository/sale_repository_impl.dart'
    as _i20;
import 'package:cashback/feauters/balance/domain/repository/sale_repository.dart'
    as _i19;
import 'package:cashback/feauters/balance/domain/use_case/sale_use_case.dart'
    as _i21;
import 'package:cashback/feauters/balance/presentation/logic/bloc/sale_bloc.dart'
    as _i33;
import 'package:cashback/feauters/catalog/data/repository/catalog_repository_impl.dart'
    as _i10;
import 'package:cashback/feauters/catalog/domain/repository/catalog_repository.dart'
    as _i9;
import 'package:cashback/feauters/catalog/domain/use_case/catalog_use_case.dart'
    as _i11;
import 'package:cashback/feauters/catalog/presentation/logic/bloc/catalog_bloc.dart'
    as _i30;
import 'package:cashback/feauters/profile/data/repository/profile_repository_impl.dart'
    as _i14;
import 'package:cashback/feauters/profile/domain/repository/profile_repository.dart'
    as _i13;
import 'package:cashback/feauters/profile/domain/use_case/profile_use_case.dart'
    as _i15;
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart'
    as _i31;
import 'package:cashback/feauters/qr-code/data/repository/qr_code_repository_impl.dart'
    as _i17;
import 'package:cashback/feauters/qr-code/domain/repository/qr_code_repository.dart'
    as _i16;
import 'package:cashback/feauters/qr-code/domain/use_case/use_case.dart'
    as _i18;
import 'package:cashback/feauters/qr-code/presentation/logic/bloc/qr_code_bloc.dart'
    as _i32;
import 'package:cashback/feauters/seller_basket/data/repository/basket_repository_impl.dart'
    as _i7;
import 'package:cashback/feauters/seller_basket/domain/repository/basket_repository.dart'
    as _i6;
import 'package:cashback/feauters/seller_basket/domain/use_case/basket_use_case.dart'
    as _i8;
import 'package:cashback/feauters/seller_basket/presentation/logic/bloc/basket_bloc.dart'
    as _i29;
import 'package:cashback/feauters/seller_catalog/data/repository/seller_catalog_repository_impl.dart'
    as _i23;
import 'package:cashback/feauters/seller_catalog/domain/repository/seller_catalog_repository.dart'
    as _i22;
import 'package:cashback/feauters/seller_catalog/domain/use_case/seller_catalog_use_case.dart'
    as _i24;
import 'package:cashback/feauters/seller_catalog/presentation/logic/bloc/seller_catalog_bloc.dart'
    as _i34;
import 'package:cashback/feauters/seller_catalog/presentation/widgets/bloc/floating_bloc.dart'
    as _i12;
import 'package:cashback/feauters/seller_kassa/data/repository/seller_kassa_repository_impl.dart'
    as _i26;
import 'package:cashback/feauters/seller_kassa/domain/repository/seller_kassa_repository.dart'
    as _i25;
import 'package:cashback/feauters/seller_kassa/domain/use_case/seller_kassa_use_case.dart'
    as _i27;
import 'package:cashback/feauters/seller_kassa/presentation/logic/bloc/seller_kassa_bloc.dart'
    as _i35;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthRepository>(() => _i4.AuthRepositoryImlp());
  gh.factory<_i5.AuthUseCase>(
      () => _i5.AuthUseCase(authRepository: gh<_i3.AuthRepository>()));
  gh.factory<_i6.BasketRepository>(() => _i7.BasketRepositoryImpl());
  gh.factory<_i8.BasketUseCase>(
      () => _i8.BasketUseCase(basketRepository: gh<_i6.BasketRepository>()));
  gh.factory<_i9.CatalogRepository>(() => _i10.CatalogRepositoryImpl());
  gh.factory<_i11.CatalogUseCase>(() =>
      _i11.CatalogUseCase(catalogRepository: gh<_i9.CatalogRepository>()));
  gh.singleton<_i12.FloatingBloc>(_i12.FloatingBloc());
  gh.factory<_i13.ProfileRepository>(() => _i14.ProfileRepositoryImpl());
  gh.factory<_i15.ProfileUseCase>(() =>
      _i15.ProfileUseCase(profileRepository: gh<_i13.ProfileRepository>()));
  gh.factory<_i16.QrCodeRepository>(() => _i17.QrCodeRepositoryImpl());
  gh.factory<_i18.QrCodeUseCase>(
      () => _i18.QrCodeUseCase(qrRepository: gh<_i16.QrCodeRepository>()));
  gh.factory<_i19.SaleRepository>(() => _i20.SaleRepositoryImpl());
  gh.factory<_i21.SaleUseCase>(
      () => _i21.SaleUseCase(saleRepository: gh<_i19.SaleRepository>()));
  gh.factory<_i22.SellerCatalogRepository>(
      () => _i23.SellerCatalogRepositoryImpl());
  gh.factory<_i24.SellerCatalogUseCase>(() => _i24.SellerCatalogUseCase(
      catalogRepository: gh<_i22.SellerCatalogRepository>()));
  gh.singleton<_i25.SellerKassaRepository>(_i26.SellerKassaRepositoryImpl());
  gh.singleton<_i27.SellerUseCase>(_i27.SellerUseCase(
      sellerKassaRepository: gh<_i25.SellerKassaRepository>()));
  gh.factory<_i28.AuthBloc>(() => _i28.AuthBloc(gh<_i5.AuthUseCase>()));
  gh.factory<_i29.BasketBloc>(() => _i29.BasketBloc(gh<_i8.BasketUseCase>()));
  gh.factory<_i30.CatalogBloc>(
      () => _i30.CatalogBloc(gh<_i11.CatalogUseCase>()));
  gh.factory<_i31.ProfileBloc>(
      () => _i31.ProfileBloc(gh<_i15.ProfileUseCase>()));
  gh.factory<_i32.QrCodeBloc>(() => _i32.QrCodeBloc(gh<_i18.QrCodeUseCase>()));
  gh.factory<_i33.SaleBloc>(() => _i33.SaleBloc(gh<_i21.SaleUseCase>()));
  gh.factory<_i34.SellerCatalogBloc>(
      () => _i34.SellerCatalogBloc(gh<_i24.SellerCatalogUseCase>()));
  gh.singleton<_i35.SellerKassaBloc>(
      _i35.SellerKassaBloc(gh<_i27.SellerUseCase>()));
  return getIt;
}

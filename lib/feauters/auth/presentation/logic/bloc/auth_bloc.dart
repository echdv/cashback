import 'dart:developer';

import 'package:cashback/feauters/auth/data/models/login_model.dart';
import 'package:cashback/feauters/auth/domain/use_cases/auth_use_case.dart';
import 'package:cashback/feauters/seller_catalog/data/model/seller_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../internal/helpers/catch_exception_helper.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase useCase;

  AuthBloc(this.useCase) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});

    on<CheckPhoneNumberEvent>((event, emit) async {
      emit(AuthLoadingState());
      
      final String phoneNumber =
          event.phone.replaceAll(RegExp(r'[^\w\s]+'), '');

      log('phoneNumber == $phoneNumber');

      await useCase
          .getPhone('+996$phoneNumber')
          .then((value) => emit(SuccessPhoneNumberCheckedState()))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<CheckSendMsgEvent>((event, emit) async {
      emit(AuthLoadingState());

      await useCase
          .getMsgCode(event.smsCode, event.phone)
          .then((value) => emit(GetMsgLoadedState()))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<RegistationEvent>((event, emit) async {
      emit(AuthLoadingState());

      final String phoneNumber =
          event.phone.replaceAll(RegExp(r'[^\w\s]+'), '');

      await useCase
          .getRegistration('+996$phoneNumber', event.name, event.password)
          .then((value) => emit(SuccessRegistatrionLoadedState()))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<LogInEvent>((event, emit) async {
      emit(AuthLoadingState());

      final String phoneNumber =
          event.phone.replaceAll(RegExp(r'[^\w\s]+'), '');
      log(phoneNumber);

      await useCase
          .getLogIn('+996$phoneNumber', event.password)
          .then((loginModel) => emit(SuccessLogInState(loginModel: loginModel)))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoadingState());

      final String phoneNumber =
          event.phone.replaceAll(RegExp(r'[^\w\s]+'), '');

      await useCase
          .resetPassoword('+996$phoneNumber', event.password)
          .then((value) => emit(SuccessResetPasswordState()))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoadingState());

      await useCase
          .logout()
          .then((value) => emit(SuccessLogoutState()))
          .onError((error, stackTrace) => emit(
              AuthErrorState(error: CatchException.convertException(error))));
    });

    on<GetSellerEvent>((event, emit) async {
      emit(AuthLoadingState());

      await useCase
          .getSeller(event.id)
          .then((sellerModel) =>
              emit(SuccessSellerLoginState(sellerModel: sellerModel)))
          .onError((error, stackTrace) => emit(AuthErrorState(
                error: CatchException.convertException(error),
              )));
    });
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SuccessPhoneNumberCheckedState extends AuthState {}

class GetMsgLoadedState extends AuthState {}

class SuccessRegistatrionLoadedState extends AuthState {}

class SuccessLogInState extends AuthState {
  final LoginModel loginModel;

  SuccessLogInState({
    required this.loginModel,
  });
}

class SuccessResetPasswordState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final CatchException error;

  AuthErrorState({required this.error});
}

class SuccessLogoutState extends AuthState {}

class SuccessSellerLoginState extends AuthState {
  final SellerModel sellerModel;
  
  SuccessSellerLoginState({required this.sellerModel});
}

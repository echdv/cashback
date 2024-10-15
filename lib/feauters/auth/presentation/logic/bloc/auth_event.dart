// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class CheckPhoneNumberEvent extends AuthEvent {
  final String phone;

  CheckPhoneNumberEvent({required this.phone});
}

class CheckSendMsgEvent extends AuthEvent {
  final String phone;
  final String smsCode;

  CheckSendMsgEvent({
    required this.phone,
    required this.smsCode,
  });
}

class RegistationEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;

  RegistationEvent({
    required this.phone,
    required this.name,
    required this.password,
  });
}

class LogInEvent extends AuthEvent {
  final String phone;
  final String password;

  LogInEvent({
    required this.phone,
    required this.password,
  });
}

class ResetPasswordEvent extends AuthEvent {
  final String phone;
  final String password;

  ResetPasswordEvent({
    required this.phone,
    required this.password,
  });
}

class LogoutEvent extends AuthEvent {}

class GetSellerEvent extends AuthEvent {
  final int id;
  
  GetSellerEvent({required this.id});
}

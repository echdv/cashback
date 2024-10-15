// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'qr_code_bloc.dart';

abstract class QrCodeState {}

class QrCodeInitial extends QrCodeState {}

class QrCodeLoadedState extends QrCodeState {
  final ClientModelTest clientModel;

  QrCodeLoadedState({
    required this.clientModel,
  });
}

class QrCodeLoadingState extends QrCodeState {}

class QrCodeErrorState extends QrCodeState {
  final CatchException error;

  QrCodeErrorState({
    required this.error,
  });
}

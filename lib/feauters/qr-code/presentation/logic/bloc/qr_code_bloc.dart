import 'package:cashback/feauters/qr-code/domain/use_case/use_case.dart';
import 'package:cashback/internal/helpers/catch_exception_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/model_test.dart';

part 'qr_code_event.dart';
part 'qr_code_state.dart';

@injectable
class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final QrCodeUseCase useCase;

  QrCodeBloc(this.useCase) : super(QrCodeInitial()) {
    on<QrCodeEvent>((event, emit) {});

    on<GetQrCodeEvent>((event, emit) async {
      emit(QrCodeLoadingState());

      await useCase
          .getQrCode()
          .then((clientModel) =>
              emit(QrCodeLoadedState(clientModel: clientModel)))
          .onError((error, stackTrace) => emit(
              QrCodeErrorState(error: CatchException.convertException(error))));
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'floating_event.dart';
part 'floating_state.dart';

@singleton
class FloatingBloc extends Bloc<FloatingEvent, FloatingState> {
  FloatingBloc() : super(FloatingInitial()) {
    on<ShowFABEvent>((event, emit) {
      emit(ShowFABState());
    });

    on<HideFABEvent>((event, emit) {
      emit(HideFABState());
    });
  }
}

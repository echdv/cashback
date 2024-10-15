import 'package:cashback/feauters/profile/data/model/profile_model.dart';
import 'package:cashback/feauters/profile/domain/use_case/profile_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';

import '../../../../../internal/helpers/catch_exception_helper.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileUseCase useCase;
  ProfileBloc(this.useCase) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<GetProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());

      await useCase
          .getProfile()
          .then((profileModel) =>
              emit(ProfileLoadedState(profileModel: profileModel)))
          .onError((error, stackTrace) => emit(ProfileErrorState(
              error: CatchException.convertException(error))));
    });

    on<PatchProfileEvent>((event, emit) async {
      emit(ProfileLoadingState());

      await useCase
          .patchProfile(event.username)
          .then((profileModel) =>
              emit(SuccessProfileRedactState(profileModel: profileModel)))
          .onError((error, stackTrace) => emit(ProfileErrorState(
              error: CatchException.convertException(error))));
    });

    on<GetProfileEventForSeller>((event, emit) async {
      emit(ProfileLoadingState());

      await useCase
          .getProfileForSeller(event.userId)
          .then((profileModel) =>
              emit(ProfileLoadedState(profileModel: profileModel)))
          .onError((error, stackTrace) => emit(ProfileErrorState(
              error: CatchException.convertException(error))));
    });

    on<DeleteProfileEvent>((event, emit) async {
      emit(ProfileDeleteLoadingSate());

      await useCase
          .deleteProfile()
          .then((value) => emit(SuccessProfileDeleteState()))
          .onError((error, stackTrace) => emit(ProfileErrorState(
              error: CatchException.convertException(error))));
    });
  }
}

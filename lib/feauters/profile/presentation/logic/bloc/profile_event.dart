// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class GetProfileEventForSeller extends ProfileEvent {
  final String userId;

  GetProfileEventForSeller({required this.userId});
}

class PatchProfileEvent extends ProfileEvent {
  final String username;

  PatchProfileEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class DeleteProfileEvent extends ProfileEvent {}

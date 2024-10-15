part of 'floating_bloc.dart';

abstract class FloatingState extends Equatable {
  const FloatingState();

  @override
  List<Object> get props => [];
}

class FloatingInitial extends FloatingState {}

class ShowFABState extends FloatingState {}

class HideFABState extends FloatingState {}

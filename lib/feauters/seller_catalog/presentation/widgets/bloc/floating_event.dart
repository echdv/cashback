part of 'floating_bloc.dart';

abstract class FloatingEvent extends Equatable {
  const FloatingEvent();

  @override
  List<Object> get props => [];
}

class ShowFABEvent extends FloatingEvent {}

class HideFABEvent extends FloatingEvent {}

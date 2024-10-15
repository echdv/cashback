part of 'timer_cubit.dart';

abstract class TimerState extends Equatable {
  @override
  List<Object> get props => [];
}

class TimerInitial extends TimerState {}

class TimerRunning extends TimerState {
  final int duration;

  TimerRunning(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerEnd extends TimerState {}

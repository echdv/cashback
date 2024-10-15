/* External dependencies */
import 'package:cashback/feauters/auth/presentation/logic/bloc/auth_bloc.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/* Local dependencies */
import 'package:cashback/feauters/auth/presentation/widgets/timer/cubit/timer_cubit.dart';

class CustomTimer extends StatefulWidget {
  final String phone;

  const CustomTimer({Key? key, required this.phone}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  TimerCubit? timerCubit;
  bool buttonClicked = false;
  int seconds = 60;
  // int seconds = 3; // для проверки работы, чтобы не ждать долго
  late AuthBloc bloc;
  @override
  void initState() {
    timerCubit = TimerCubit();
    timerCubit!.startTimer(seconds);
    bloc = getIt<AuthBloc>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerCubit, TimerState>(
      bloc: timerCubit,
      builder: (context, state) {
        if (state is TimerInitial) {
          return const Text('');
        }

        if (state is TimerRunning) {
          buttonClicked = false;

          return Align(
            alignment: Alignment.center,
            child: Text(
              'Отправить повторно через: ${formatHHMMSS(state.duration)}',
              textAlign: TextAlign.center,
              // style: TextHelper.medium16,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.center,
          child: InkWell(
            // splashColor: ThemeHelper.backgroundColor,
            // highlightColor: ThemeHelper.backgroundColor,
            onTap: () {
              bloc.add(CheckPhoneNumberEvent(phone: widget.phone));
              timerCubit!.restartTimer(seconds, buttonClicked);
            },
            child: Text(
              'Отправить код повторно',
              // style: TextHelper.bold16.copyWith(color: ThemeHelper.orange),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

// для фортмата времени
// ignore: body_might_complete_normally_nullable
String? formatHHMMSS(int seconds) {
  int hours = (seconds / 3600).truncate();
  seconds = (seconds % 3600).truncate();
  int minutes = (seconds / 60).truncate();

  // ignore: unused_local_variable
  String hoursStr = (hours).toString().padLeft(2, '0');
  String minutesStr = (minutes).toString().padLeft(2, '0');
  String secondsStr = (seconds % 60).toString().padLeft(2, '0');

  if (hours == 0) {
    return "$minutesStr:$secondsStr";
  }
}

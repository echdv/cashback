/* External dependencies */
import 'package:cashback/feauters/auth/presentation/screens/registration_screen/phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/* Local dependencies */
import 'package:cashback/internal/helpers/components/custom_progress_indicator.dart';
import 'package:cashback/internal/helpers/splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'internal/dependencies/get_it.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('tokenBox');
  await Hive.openBox('idBox');
  await Hive.openBox('isStaffBox');
  await Hive.openBox('branchBox');
  await Hive.openBox('staffID');

  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          builder: FlutterSmartDialog.init(
            loadingBuilder: (String msg) => CustomProgressIndicator(msg: msg),
          ),
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          theme: ThemeData(
            fontFamily: 'Lato',
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(
              fontSizeFactor: 1.sp,
              bodyColor: Colors.black,
            ),
          ),
          home: PhoneNumberScreen(),
        );
      },
    );
  }
}

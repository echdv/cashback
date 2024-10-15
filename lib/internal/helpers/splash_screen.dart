/* External dependencies */
import 'dart:async';
import 'dart:developer';

import 'package:cashback/feauters/auth/presentation/screens/choose_screen/choose_screen.dart';
import 'package:cashback/feauters/catalog/presentation/screens/catalog_choose_screen/catalog_choose_screen.dart';
import 'package:cashback/feauters/seller_catalog/presentation/screens/seller_catalog_screen/seller_catalog_screen.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

/* Local dependencies */
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    navigatorHelper();
    super.initState();
  }

  Future navigatorHelper() async {
    var box = Hive.box('tokenBox');
    String token = box.get('token', defaultValue: '');
    var branchBox = Hive.box('branchBox');
    log('branch === ${branchBox.get('branch')}');

    var staffBox = Hive.box('isStaffBox');
    bool isStaff = staffBox.get('isStaff', defaultValue: false);

    await Future.delayed(const Duration(seconds: 3));

    if (token.isEmpty) {
      Timer(const Duration(seconds: 3), () {
        // context.go('/chooseScreen');
        customNavigatorPushAndRemove(context, ChooseScreen());
      });
    } else {
      if (isStaff) {
        // ignore: use_build_context_synchronously
        // context.go('/sellerCatalogScreen');
        customNavigatorPushAndRemove(context, SellerCatalogScreen());
      } else {
        // ignore: use_build_context_synchronously
        // context.go('/clientChooseCatalog');
        customNavigatorPushAndRemove(context, CatalogChooseScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/icons/logotip.svg',
          height: 242.r,
          width: 242.r,
        ),
      ),
    );
  }
}

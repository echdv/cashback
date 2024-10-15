import 'package:cashback/feauters/balance/presentation/screens/balance_screen/balance_screen.dart';
import 'package:cashback/feauters/catalog/presentation/screens/catalog_choose_screen/catalog_choose_screen.dart';
import 'package:cashback/feauters/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:cashback/feauters/qr-code/presentation/screens/qr-code_screen/qr-code_screen.dart';
import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ClientNavBar extends StatelessWidget {
  final int currentPage;

  const ClientNavBar({super.key, this.currentPage = 0});

  List<BottomNavigationBarItem> _generateItemList() {
    var items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/catalogA.svg'),
        icon: SvgPicture.asset('assets/icons/catalog.svg'),
        label: 'Каталог',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/balanceA.svg'),
        icon: SvgPicture.asset('assets/icons/balance.svg'),
        label: 'Баланс',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/qrcodeA.svg'),
        icon: SvgPicture.asset('assets/icons/qrcode.svg'),
        label: 'QR-code',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/profileA.svg'),
        icon: SvgPicture.asset('assets/icons/profile.svg'),
        label: 'QR-code',
      ),
    ];

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: BottomNavigationBar(
        items: _generateItemList(),
        backgroundColor: ColorHelper.green08,
        selectedItemColor: Colors.white,
        unselectedItemColor: ColorHelper.white05,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Lato',
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 24.h,
        unselectedFontSize: 14.h,
        selectedFontSize: 14.h,
        onTap: (index) async {
          switch (index) {
            case 0:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(
                    context,
                    const CatalogChooseScreen(),
                  );
                }

                break;
              }
            case 1:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(
                    context,
                    const BalanceScreen(),
                  );
                }
                break;
              }
            case 2:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(
                    context,
                    const QrCodeScreen(),
                  );
                }
                break;
              }
            case 3:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(
                    context,
                    const ProfileScreen(),
                  );
                }
                break;
              }
          }
        },
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

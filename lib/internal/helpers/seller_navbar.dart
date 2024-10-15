import 'package:cashback/internal/helpers/colors_helper.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../feauters/seller_basket/presentation/screens/choose_basket_screen/choose_basket_screen.dart';
import '../../feauters/seller_catalog/presentation/screens/seller_catalog_screen/seller_catalog_screen.dart';
import '../../feauters/seller_kassa/presentation/screens/seller_kassa_screen/seller_kassa_screens.dart';

class SellerNavBar extends StatelessWidget {
  final int currentPage;

  const SellerNavBar({super.key, this.currentPage = 0});

  List<BottomNavigationBarItem> _generateItemList() {
    var items = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/catalogA.svg'),
        icon: SvgPicture.asset('assets/icons/catalog.svg'),
        label: 'Каталог',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/basketA.svg'),
        icon: SvgPicture.asset('assets/icons/basketN.svg'),
        label: 'Корзина',
      ),
      BottomNavigationBarItem(
        activeIcon: SvgPicture.asset('assets/icons/kassa.svg'),
        icon: SvgPicture.asset('assets/icons/kassaN.svg'),
        label: 'Касса',
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
        backgroundColor: ColorHelper.brown08,
        selectedItemColor: Colors.white,
        unselectedItemColor: ColorHelper.white05,
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Lato',
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.amber,
          fontSize: 14.sp,
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
                  customNavigatorPushAndRemove(context, const SellerCatalogScreen());
                }

                break;
              }
            case 1:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(context, const ChooseBasketScreen());
                }
                break;
              }
            case 2:
              {
                if (currentPage != index) {
                  customNavigatorPushAndRemove(context, const SellerKassaScreen());
                }
                break;
              }
            case 3:
          }
        },
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

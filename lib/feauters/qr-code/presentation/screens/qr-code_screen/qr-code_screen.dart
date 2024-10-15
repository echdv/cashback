// ignore_for_file: file_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/navbar.dart';
import '../../logic/bloc/qr_code_bloc.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  // ignore: non_constant_identifier_names
  late String qr_code;
  late QrCodeBloc bloc;

  @override
  void initState() {
    bloc = getIt<QrCodeBloc>();
    bloc.add(GetQrCodeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 53.w,
        centerTitle: false,
        backgroundColor: ColorHelper.green08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Text(
          "QR-CODE",
          style: TextStyleHelper.forAppBar,
        ),
        actions: [
          SizedBox(
            height: 58.h,
            width: 58.w,
            child: SvgPicture.asset("assets/icons/logo_appbar.svg"),
          ),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.w),
        child: Column(
          children: [
            SizedBox(
              height: 39.h,
            ),
            Text(
              "Отсканируйте QR-code",
              style: TextStyleHelper.forElementInfoL,
            ),
            SizedBox(
              height: 22.h,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(23, 69, 59, 0.25),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(
                      1,
                      4,
                    ), //New
                  ),
                ],
                color: Colors.white,
                border: Border.all(
                  color: ColorHelper.green05,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              width: 334.w,
              height: 334.h,
              child: BlocBuilder<QrCodeBloc, QrCodeState>(
                bloc: bloc,
                builder: (context, state) {
                  if (state is QrCodeLoadingState) {
                    if (Platform.isIOS) {
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 15.r,
                        color: ColorHelper.green06,
                      ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: ColorHelper.green06,
                        ),
                      );
                    }
                  }

                  if (state is QrCodeErrorState) {
                    return SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: SvgPicture.asset("assets/icons/userIcon.svg"),
                    );
                  }

                  if (state is QrCodeLoadedState) {
                    qr_code = state.clientModel.qrCode.toString();
                    return CachedNetworkImage(
                      imageUrl: state.clientModel.qrCode ?? '',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        if (Platform.isIOS) {
                          return Center(
                              child: CupertinoActivityIndicator(
                            radius: 15.r,
                            color: ColorHelper.green06,
                          ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: ColorHelper.green06,
                            ),
                          );
                        }
                      },
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 100.r,
                      ),
                    );
                  }
                  return const SizedBox(
                    child: Text('123'),
                  );
                },
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "ПРИМЕЧАНИЕ:",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15.sp,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Expanded(
                    
                    child: Text(
                      " на случай того если у вас не будет интернета сделайте скриншот",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorHelper.green08,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Lato"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigator(currentPage: 2),
    );
  }
}

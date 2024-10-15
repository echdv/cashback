import 'package:cashback/feauters/auth/presentation/widgets/text_field_card.dart';
import 'package:cashback/feauters/profile/presentation/logic/bloc/profile_bloc.dart';
import 'package:cashback/feauters/profile/presentation/screens/profile_screen/profile_screen.dart';
import 'package:cashback/internal/dependencies/get_it.dart';
import 'package:cashback/internal/helpers/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../internal/helpers/colors_helper.dart';
import '../../../../../internal/helpers/components/custom_flushbar.dart';
import '../../../../../internal/helpers/text_style_helper.dart';

class ProfileRedactScreen extends StatefulWidget {
  final String username;

  const ProfileRedactScreen({
    super.key,
    required this.username,
  });

  @override
  State<ProfileRedactScreen> createState() => _ProfilePutScreenState();
}

class _ProfilePutScreenState extends State<ProfileRedactScreen> {
  ValueNotifier<bool> enabledButton = ValueNotifier<bool>(false);
  final TextEditingController nameController = TextEditingController();
  late ProfileBloc bloc;

  @override
  void initState() {
    bloc = getIt<ProfileBloc>();
    nameController.text = widget.username;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.w,
        centerTitle: false,
        backgroundColor: ColorHelper.green08,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        toolbarHeight: 139.h,
        title: Transform(
          // you can forcefully translate values left side using Transform
          transform: Matrix4.translationValues(-0.0, 0.0, 0.0),
          child: Text(
            "ПРОФИЛЬ",
            style: TextStyleHelper.forAppBar,
          ),
        ),
        actions: [
          SizedBox(
              height: 58.h,
              width: 58.w,
              child: SvgPicture.asset("assets/icons/logo_appbar.svg")),
          SizedBox(
            width: 20.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 140.h),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 40.w,
              ),
              width: 1.sw,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: ColorHelper.green08,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  TextFieldCard(
                    onChange: (value) {
                      if (nameController.value.text.isEmpty) {
                        enabledButton.value = false;
                      } else if (nameController.value.text.isNotEmpty) {
                        enabledButton.value = true;
                      }
                    },
                    title: 'Введите имя',
                    type: TextInputType.name,
                    controller: nameController,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            BlocListener<ProfileBloc, ProfileState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is ProfileLoadingState) {
                  SmartDialog.showLoading(msg: 'Загрузка...');
                }

                if (state is SuccessProfileRedactState) {
                  
                  customNavigatorPush(context, ProfileScreen());
                  bloc.add(GetProfileEvent());
                  SmartDialog.dismiss();
                }

                if (state is ProfileErrorState) {
                  SmartDialog.dismiss();

                  Exceptions.showFlushbar(
                    state.error.message.toString(),
                    context: context,
                  );
                }
              },
              child: ValueListenableBuilder(
                valueListenable: enabledButton,
                builder: (BuildContext context, bool value, Widget? child) =>
                    CustomButtonCard(
                  onPressed: () {
                    if (enabledButton.value == true) {
                      bloc.add(
                        PatchProfileEvent(username: nameController.text),
                      );
                    } else {
                      Exceptions.showFlushbar(
                        'заполните поле',
                        context: context,
                      );
                    }
                  },
                  title: 'Сохранить',
                  width: 120.w,
                  height: 40.h,
                  bRadius: 20.r,
                  color: enabledButton.value
                      ? ColorHelper.green08
                      : ColorHelper.green08.withOpacity(0.5),
                  textStyle: TextStyleHelper.forClientButton,
                  backColor: enabledButton.value
                      ? Colors.white
                      : Colors.white.withOpacity(0.5), isGreen: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

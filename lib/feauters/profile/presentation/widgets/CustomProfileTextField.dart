// ignore_for_file: file_names

import 'package:cashback/internal/helpers/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileTextField extends StatelessWidget {
  final int flex1;
  final int flex2;
  final String title;

  const CustomProfileTextField({
    Key? key,
    required this.flex1,
    required this.flex2,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flex1,
          child: Text(
            title,
            style: TextStyleHelper.profileInfo,
          ),
        ),
        Expanded(
          flex: flex2,
          child: SizedBox(
            height: 20,
            child: TextField(
              cursorColor: Colors.white,
              style: TextStyleHelper.profileInfo,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    bottom: 13.h,
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                  )),
            ),
          ),
        )
      ],
    );
  }
}

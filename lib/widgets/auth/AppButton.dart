import 'package:flutter/material.dart';

import '../../themes/fonts.dart';
import '/themes/color.dart';
import '/themes/fonts.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double width;
  final Function()? onTap;
  final bool isActive;

  const AppButton(
      {super.key,
      this.text = 'text',
      this.onTap,
      this.width = 286,
      this.isActive = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isActive ? AppColor.mainRed : AppColor.subtitleColor,
          ),
          height: 54,
          width: width,
          child: Center(
              child: Text(
            text,
            style: buttonStyle,
          )),
        ),
        onTap: isActive ? onTap : null);
  }
}

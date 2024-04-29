import 'package:flutter/material.dart';

import '../constants/import_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width = double.infinity,
    this.color = Palette.red400,
    this.colorText = Colors.white,
    this.paddingTop = 12,
    this.paddingBottom = 12,
    this.paddingLeft = 12,
    this.paddingRight = 12,
    this.borderColor = Palette.red500,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final double width;
  final Color borderColor;
  final Color color;
  final Color colorText;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double paddingLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: paddingBottom,
          left: paddingLeft,
          right: paddingRight,
          top: paddingTop),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: isLoading ? Colors.white : color,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(60),
          ),
          fixedSize: Size(width, 46),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35.0),
                child: SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  text,
                  style: AppTextStyle.textWhite.copyWith(color: colorText),
                ),
              ),
      ),
    );
  }
}

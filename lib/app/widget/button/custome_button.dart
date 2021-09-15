import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/controller.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:flutter/material.dart';

///this custome widget button will show image and text in button
///take label as required paraments
class ButtonWithImage extends StatelessWidget {
  const ButtonWithImage(
    this.label, {
    Key? key,
    this.onTap,
    this.color,
    this.borderRadius,
    this.horizontal,
    this.vertical,
    required this.imageString,
    this.textColor,
    this.borderColor,
    this.isbold = false,
    this.isCentered = false,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String label;
  final Color? color;
  final double? borderRadius;
  final Color? borderColor;
  final double? vertical;
  final double? horizontal;
  final String imageString;
  final Color? textColor;
  final bool isbold;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: appsize.width,
        height: appsize.height * .07,
        padding: EdgeInsets.symmetric(
            horizontal: horizontal ?? Constant.defaultPadding * 2,
            vertical: vertical ?? Constant.defaultPadding),
        margin: EdgeInsets.symmetric(
          horizontal: horizontal ?? Constant.defaultPadding,
        ),
        decoration: BoxDecoration(
            color: color ?? Colors.transparent,
            borderRadius:
                BorderRadius.circular((borderRadius ?? Constant.defaultRadius)),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  imageString,
                  height: Constant.defaultFontSize * 2,
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: textColor ?? Themes.white,
                    fontWeight: isbold ? FontWeight.bold : FontWeight.normal),
                textAlign: isCentered ? TextAlign.center : TextAlign.left,
              ),
            )
          ],
        ),
      ),
    );
  }
}

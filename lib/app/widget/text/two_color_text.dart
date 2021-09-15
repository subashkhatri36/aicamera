import 'package:aicamera/app/constant/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///It will have two different color in same line of text
///Must pass two text
class TwoColorText extends StatelessWidget {
  final double? fontSize;
  final double? fontSize1;
  final bool isBold;
  final bool isBold1;
  final bool isUnderline1;
  final bool hasUnderline;
  final String text1;
  final String text2;
  final bool isCentered;
  final Color? color1;
  final Color? color2;

  const TwoColorText(
    this.text1,
    this.text2, {
    this.fontSize1,
    Key? key,
    this.fontSize,
    this.isBold = false,
    this.hasUnderline = false,
    this.isCentered = false,
    this.color1,
    this.color2,
    this.isBold1 = false,
    this.isUnderline1 = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: fontSize != null ? fontSize! : null,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              decoration: hasUnderline ? TextDecoration.underline : null,
              color: color1 ?? Themes.textColor,
            ),
        children: <TextSpan>[
          TextSpan(
              text: ' ' + text2,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: fontSize1 != null ? fontSize1! : null,
                    fontWeight: isBold1 ? FontWeight.bold : FontWeight.normal,
                    decoration: isUnderline1 ? TextDecoration.underline : null,
                    color: color2 ?? Themes.pRIMARYCOLORLIGHT,
                  )),
        ],
      ),
    );
  }
}

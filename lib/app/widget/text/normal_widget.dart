import 'package:aicamera/app/constant/themes.dart';
import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final double? fontSize;
  final bool isBold;
  final bool hasUnderline;
  final String text;
  final bool isCentered;
  final Color? color;
  final int maxline;

  const NormalText(
    this.text, {
    Key? key,
    this.fontSize,
    this.isBold = false,
    this.hasUnderline = false,
    this.isCentered = false,
    this.color,
    this.maxline = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: fontSize != null ? fontSize! : null,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            decoration: hasUnderline ? TextDecoration.underline : null,
            color: color ?? Themes.textColor,
          ),
      textAlign: isCentered ? TextAlign.center : null,
      maxLines: maxline,
      overflow: TextOverflow.clip,
    );
  }
}

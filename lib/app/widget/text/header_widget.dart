import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final double? fontSize;
  final bool isBold;
  final bool hasUnderline;
  final String text;
  final bool isCentered;
  final Color? textColor;

  const HeaderText(
    this.text, {
    this.fontSize,
    this.isBold = true,
    this.hasUnderline = false,
    this.isCentered = false,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline3!.copyWith(
          fontSize: fontSize != null ? fontSize : null,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          decoration: hasUnderline ? TextDecoration.underline : null,
          color: textColor ?? Theme.of(context).primaryColorLight),
      textAlign: isCentered ? TextAlign.center : null,
    );
  }
}

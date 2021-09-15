import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:flutter/material.dart';

/// custom text input field widget
class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      this.label,
      this.hintText,
      this.obscureText = false,
      this.textInputType = TextInputType.text,
      this.icon,
      this.validator,
      this.onFieldSubmitted,
      this.onChanged,
      this.controller,
      this.suffix,
      this.iconColor,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.borderRadius = 0,
      this.color = Colors.transparent})
      : super(key: key);

  final IconData? icon;
  final String? hintText;
  final TextInputType textInputType;
  final bool obscureText;
  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final IconData? suffix;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final String? label;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  // ignore: prefer_typing_uninitialized_variables
  final autovalidateMode;
  final double borderRadius;
  final Color color;
  final Color? iconColor;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  ///toggle status for passsword eye
  bool showPassword = false;
  bool checkdata = true;

  /// toggle status for password field
  bool shownPassword = false;

  @override
  void initState() {
    super.initState();
    shownPassword = widget.obscureText;
  }

  /// toggle password view
  void togglePassword() {
    setState(() {
      showPassword = !showPassword;
      shownPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: Constant.defaultPadding,
        vertical: Constant.defaultPadding / 2,
      ),

      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: widget.autovalidateMode,
        decoration: InputDecoration(
          fillColor: widget.color,
          contentPadding: widget.icon != null
              ? const EdgeInsets.fromLTRB(20, 0, 20, 0)
              : const EdgeInsets.fromLTRB(20, 0, 20, 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Themes.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Themes.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: Themes.grey),
          ),
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          labelText: widget.label,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Themes.grey,
            fontSize: Constant.defaultFontSize,
          ),
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () => togglePassword(),
                  icon: Icon(
                      showPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: widget.iconColor ?? Themes.grey),
                  splashRadius: 0.1,
                )
              : widget.suffix != null
                  ? Icon(checkdata ? widget.suffix : Icons.close,
                      color: widget.iconColor ?? Themes.red)
                  : null,
        ),
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        obscureText: shownPassword,
        keyboardType: widget.textInputType,
      ),
    );
  }
}

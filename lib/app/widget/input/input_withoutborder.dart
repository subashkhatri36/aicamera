import 'package:aicamera/app/constant/constants.dart';
import 'package:aicamera/app/constant/themes.dart';
import 'package:flutter/material.dart';

/// custom text input field widget without border
///
class InputField extends StatefulWidget {
  const InputField({
    Key? key,
    this.label,
    this.hintText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.icon,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.controller,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  }) : super(key: key);

  final IconData? icon;
  final String? hintText;
  final TextInputType textInputType;
  final bool obscureText;
  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final String? label;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  // ignore: prefer_typing_uninitialized_variables
  final autovalidateMode;

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  ///toggle status for passsword eye
  bool showPassword = false;

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
    return (Container(
      margin: const EdgeInsets.only(
        bottom: Constant.defaultPadding,
        top: Constant.defaultPadding,
      ),
      child: TextFormField(
        controller: widget.controller,
        autovalidateMode: widget.autovalidateMode,
        decoration: InputDecoration(
          contentPadding: widget.icon != null
              ? const EdgeInsets.fromLTRB(0, 0, 10, 0)
              : const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Themes.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Themes.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Themes.grey),
          ),
          prefixIcon: widget.icon != null ? new Icon(widget.icon) : null,
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
                    color: Themes.grey,
                  ),
                  splashRadius: 0.1,
                )
              : null,
        ),
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        onChanged: widget.onChanged,
        obscureText: shownPassword,
        keyboardType: widget.textInputType,
      ),
    ));
  }
}

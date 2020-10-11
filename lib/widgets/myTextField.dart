import 'package:e_commerce/components/constants.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final isPassword;
  final isSecure;
  final textColor;
  final fontFamily;
  final text;
  final hint;
  final maxLine;
  final validation;
  final isEmail;
  final isNumber;
  final controller;
  final onChanged;
  final maxLength;
  final onlyHint;
  final isMultiLine;
  final icon;

  CustomTextField({
    this.controller,
    this.textColor,
    this.fontFamily,
    this.text = '',
    this.hint = '',
    this.maxLine = 1,
    this.validation,
    this.onChanged,
    this.maxLength,
    this.isPassword = false,
    this.isSecure = false,
    this.isEmail = false,
    this.isMultiLine = false,
    this.isNumber = false,
    this.onlyHint = false,
    this.icon,
  });
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLine,
      controller: widget.controller,
      obscureText: widget.isPassword,
      keyboardType: widget.isNumber
          ? TextInputType.number
          : widget.isEmail
              ? TextInputType.emailAddress
              : widget.isMultiLine
                  ? TextInputType.multiline
                  : TextInputType.text,
      style: TextStyle(fontFamily: fontRegular, color: widget.textColor),
      decoration: InputDecoration(
          prefixIcon: widget.icon,
          labelText: widget.onlyHint ? null : widget.hint,
          contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          hintText: widget.onlyHint ? widget.hint : null,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.teal, width: 0.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.teal, width: 0.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          errorStyle: TextStyle()),
      validator: widget.validation,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
    );
  }
}

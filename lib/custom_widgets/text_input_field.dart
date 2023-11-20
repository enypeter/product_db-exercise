import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputForm extends StatelessWidget {
  const TextInputForm({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscure = false,
    this.onChanged,
    this.onSubmit,
    this.enabled = true,
    this.controller,
    this.label,
    this.hint,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
    this.prefixText,
    this.onTap,
  });

  final suffixIcon;
  final prefixIcon;
  final onChanged;
  final onSubmit;
  final validator;
  final bool enabled;
  final TextEditingController? controller;
  final bool obscure;
  final String? label;
  final String? prefixText;
  final String? hint;
  final TextCapitalization textCapitalization;
  final keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: InkWell(
      onTap: onTap,
      child: TextFormField(
        buildCounter: (context,
            {required currentLength, required isFocused, maxLength}) =>
        null,
        inputFormatters: inputFormatters,
        enabled: enabled,
        controller: controller,
        keyboardType: keyboardType,
        style:  TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w300),
        textCapitalization: textCapitalization,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        obscureText: obscure,
        obscuringCharacter: '*',
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          filled: false,
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
              const BorderSide(color: Colors.redAccent, width: 0.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide:
              const BorderSide(color: Colors.grey, width: 0.5)),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: label,
          hintText: hint,
          prefixText: prefixText,
          prefixStyle: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w300) ,
          labelStyle:  TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: Colors.grey),
          hintStyle:  TextStyle(fontSize: 14.sp, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 18),
        ),
      ),
    ),
  );
}

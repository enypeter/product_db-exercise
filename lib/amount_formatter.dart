import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String formatAmount(amount) {
 final formatCurrency = NumberFormat.simpleCurrency(
      locale: Platform.localeName, name: 'NGN');
  return formatCurrency.format(double.parse(amount.toString()));
}





class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    if (newText.isEmpty) {
      return newValue;
    }
    int selectionIndex = newValue.selection.end;
    final String newTextFormatted = NumberFormat("#,###,###,###")
        .format(double.tryParse(newText.replaceAll(",", "")));
    if (newText == newTextFormatted) {
      return newValue;
    }
    selectionIndex += -(newText.length - newTextFormatted.length);
    return TextEditingValue(
      text: newTextFormatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
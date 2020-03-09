import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

class CustomFormField extends TextFormField {
  CustomFormField({
    String hintText,
    IconData icon,
    TextEditingController controller,
    FormFieldValidator<String> validator,
    Function onSaved,
    Function onFieldSubmitted,
    Function onEditingComplete,
    TextInputType keyboardType = TextInputType.text,
    String initialValue = "",
    bool obscureText = false,
    int maxLines = 1,
  }) : super(
          style: smallTextStyle,
          validator: validator,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          onEditingComplete: onEditingComplete,
          keyboardType: keyboardType,
          initialValue: initialValue,
          obscureText: obscureText,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            prefixIcon: Icon(icon),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: primaryColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
          ),
        );
}

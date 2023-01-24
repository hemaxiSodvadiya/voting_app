import 'package:flutter/material.dart';

OutlineInputBorder myEnabledBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(0xffFFCB2B),
      width: 3,
    ),
  );
}

OutlineInputBorder myFocusBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: Color(0xffF5820D),
      width: 3,
    ),
  );
}

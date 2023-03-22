import 'package:charcode/html_entity.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Size displaySize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double displayHeight(BuildContext context) {
    return displaySize(context).height;
  }

  static String degreeSymbol = String.fromCharCode($deg);
}

import 'dart:math';

import 'package:flutter/material.dart';

Color convertChangeToColor(String change) {
  if (double.parse(change) < 0) {
    return Colors.red;
  } else {
    return Colors.green;
  }
}

Icon convertChangeToIcon(String change) {
  if (double.parse(change) < 0) {
    return Icon(
      Icons.keyboard_arrow_down,
      color: Colors.red,
      size: 24.0,
    );
  } else {
    return Icon(
      Icons.keyboard_arrow_up,
      color: Colors.green,
      size: 24.0,
    );
  }
}

String roundMoney(String price) {
  int decimals = 2;
  int fac = pow(10, decimals);
  double rounded_price = (double.parse(price) * fac).round() / fac;
  String formattedPrice = "\$" + rounded_price.toString();
  return formattedPrice;
}

String roundChange(String change) {
  int decimals = 2;
  int fac = pow(10, decimals);
  double rounded_price = (double.parse(change) * fac).round() / fac;
  String formattedPrice = rounded_price.toString() + "%";
  return formattedPrice;
}
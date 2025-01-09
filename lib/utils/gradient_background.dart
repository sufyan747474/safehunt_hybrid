import 'package:flutter/material.dart';

import 'colors.dart';

const gradiantBackground = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: <Color>[appLightGreenColor, appBrownColor]),
);

const gradiantPaymentBackground = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        appLightGreenColor,
        appBrownColor,
      ]),
);

var bottomGradiantBackground = const BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.grey,
      spreadRadius: 5,
      blurRadius: 7,
      offset: Offset(0, 10), // changes position of shadow
    ),
  ],
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[appLightGreenColor, appGreyColor]),
);

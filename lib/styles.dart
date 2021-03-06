import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 60.0;
  static const _textSizeSmall = 20.0;
  static final Color _textColor = _hexToColor('FFFFFF');
  static final Color _textColorRegister = _hexToColor('000000');
  static final Color _textColorShadowed = _hexToColor('005b96');
  static final Color colorBackground = _hexToColor('03396c');
  static final Color colorBackground2 = Colors.blueGrey;
  static final Color colorRelleno = _hexToColor('e5e5e5');
  static final linkedText =
      TextStyle(color: Colors.blue, decoration: TextDecoration.underline);
  static final title =
      TextStyle(fontSize: _textSizeLarge, color: _textColorRegister);
  static final titleSplash =
      TextStyle(fontSize: _textSizeLarge, color: _textColor);
  static final button_big = TextStyle(fontSize: 20, color: Colors.white);
  static final title_shadowed =
      TextStyle(fontSize: _textSizeLarge, color: _textColorShadowed);
  static final subtitle =
      TextStyle(fontSize: _textSizeSmall, color: Colors.white);
  static final projectText = TextStyle(
      fontSize: _textSizeSmall,
      color: _textColorShadowed,
      fontWeight: FontWeight.bold);
  static final projectTextTitle = TextStyle(
      fontSize: 30, color: colorBackground, fontWeight: FontWeight.bold);
  static final subText =
      TextStyle(fontSize: _textSizeLarge, color: Colors.white);
  static final littleTittle =
      TextStyle(fontSize: _textSizeSmall, color: Colors.white);

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    backgroundColor: Colors.blue,
  );
}

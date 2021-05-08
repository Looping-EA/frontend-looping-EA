import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Styles {
  static const _textSizeLarge = 60.0;
  static const _textSizeSmall = 20.0;
  static final Color _textColor = _hexToColor('38ffe5');
  static final Color colorBackground = _hexToColor('1a9476');
  static final Color iconColor = _hexToColor('b3cde0');
  static final Color borderColor = _hexToColor('011f4b');
  static final Color white = _hexToColor('ffffff');
  static final Color textColor = _hexToColor('03396c');
  static final title = TextStyle(fontSize: _textSizeLarge, color: _textColor);
  static final subtitle =
      TextStyle(fontSize: _textSizeSmall, color: _textColor);

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

  static const List validEmail = ['test@gmail.com'];
}

/*class Palette {
  static const Color iconColor = Color(0xFFB6C7D1);
}*/

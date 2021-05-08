/*import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:provider/provider.dart';

class TextSection extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function onChanged;

  TextSection(
      {required this.hintText,
      required this.prefixIconData,
      required this.suffixIconData,
      required this.obscureText,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(
        color: Styles.textColor,
        fontSize: 14.0,
      ),
      cursorColor: Styles.borderColor,
      decoration: InputDecoration(
        labelText: hintText,
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Styles.iconColor,
        ),
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Styles.borderColor)),
        suffixIcon: GestureDetector(
          onTap: () {
            model.isVisible = !model.isVisible;
          },
          child: Icon(
            suffixIconData,
            size: 10,
            color: Styles.iconColor,
          ),
        ),
        labelStyle: TextStyle(color: Styles.borderColor),
        focusColor: Styles.borderColor,
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final String tittle;
  final bool hasBorder;

  ButtonWidget({
    required this.tittle,
    required this.hasBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? Styles.white : Styles.iconColor,
          borderRadius: BorderRadius.circular(10),
          border: hasBorder
              ? Border.all(
                  color: Styles.iconColor,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60.0,
            child: Center(
              child: Text(tittle,
                  style: TextStyle(
                    color: hasBorder ? Styles.textColor : Styles.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginModel extends ChangeNotifier {
  get isVisible => _isVisible;
  bool _isVisible = false;
  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;
  void isValidEmail(String input) {
    if (input == Styles.validEmail.first) {
      _isValid = true;
    } else {
      _isValid = false;
    }
    notifyListeners();
  }
}
*/
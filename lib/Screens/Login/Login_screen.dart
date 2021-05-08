/*import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:frontend_looping_ea/styles.dart';
import 'package:frontend_looping_ea/Screens/Login/text_section.dart';
import 'package:provider/provider.dart';
// Screens/Login/Login.dart

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<LoginModel>(context);
    return Scaffold(
      backgroundColor: Styles.colorBackground,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextSection(
              hintText: 'Email',
              obscureText: false,
              prefixIconData: Icons.mail_outline,
              suffixIconData: model.isValid ? Icons.check : null,
              onChanged: (value) {
                model.isValidEmail(value);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextSection(
                  hintText: 'Password',
                  obscureText: model.isVisible ? false : true,
                  prefixIconData: Icons.lock_outline,
                  suffixIconData:
                      model.isVisible ? Icons.visibility : Icons.visibility_off,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Forgot password?',
                  style: TextStyle(
                    color: Styles.iconColor,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonWidget(
              tittle: 'Login',
              hasBorder: false,
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonWidget(
              tittle: 'Sing Up',
              hasBorder: true,
            ),
          ],
        ),
      ),
    );
  }
}
*/
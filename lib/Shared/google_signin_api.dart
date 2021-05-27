import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _clientIDWeb =
      '750340506197-q91mnafhea336287opm25nciges3k7oa.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  static Future login() => _googleSignIn.signIn();
}

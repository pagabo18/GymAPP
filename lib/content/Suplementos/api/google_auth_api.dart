import 'package:google_sign_in/google_sign_in.dart';
class GoogleAuthApi{
  static final _googleSignIn = GoogleSignIn(scopes: ['https://mail.google.com/']);

  static Future<GoogleSignInAccount?> signIn() async{
    final googleUser = await _googleSignIn.signIn();
    return googleUser;
  }
  static Future<GoogleSignInAuthentication> authU() async{
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return googleAuth;
  }
}
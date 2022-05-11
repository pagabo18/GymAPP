import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuthRepository {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAlreadyAuthenticated() {
    return _auth.currentUser != null;
  }

  Future<void> signOutGoogleUser() async {
    await _googleSignIn.signOut();
  }

  Future<void> signOutFirebaseUser() async {
    await _auth.signOut();
  }
  static Future<GoogleSignInAccount?> signIn() async{
    final googleUser = await _googleSignIn.signIn();
    return googleUser;
  }
  static Future<GoogleSignInAuthentication> authU() async{
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    return googleAuth;
  }
  
  Future<void> signInWithGoogle() async {
    //Google Sign In
    final googleUser = await _googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;

    print("gymUser:${googleUser.email}");

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // firebase sign in
    final authResult = await _auth.signInWithCredential(credential);

    //extraer token
    User user = authResult.user!;
    final firebaseToken = await user.getIdToken();
    print("user fcm token:${firebaseToken}");

    await _createUserCollectionFirebase(_auth.currentUser!.uid);
  }

  Future<void> _createUserCollectionFirebase(String uid) async {
    var userDoc =
        await FirebaseFirestore.instance.collection("gymUser").doc(uid).get();
    if (!userDoc.exists) {
      await FirebaseFirestore.instance.collection("gymUser").doc(uid).set(
        {
          "Rutinas": [],
        },
      );
    } else {
      return;
    }
  }
}

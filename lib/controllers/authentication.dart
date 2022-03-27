import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

// googleSignIn() async {
//   GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
// }

Future<bool?> googleSignI() async {
  GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  if (googleSignInAccount != null) {
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = await auth.signInWithCredential(credential);

    User? user = auth.currentUser;
    print(user!.uid);

    return Future.value(true);
  }
}

Future<bool?> signInUser(String email, String password) async {
  try {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    // User? user = result.user;

    return Future.value(true);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'invalid-email':
        print('Service Error');
    }
  }
}

Future<bool?> signUp(String email, String password) async {
  try {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // User? user = result.user;

    return Future.value(true);
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'email-already-in-use':
        print('Service Error');
    }
  }
}

Future<bool> signOutUser() async {
  User? user = await auth.currentUser;

  if (user!.providerData[1].providerId == 'google.com') {
    await googleSignIn.disconnect();
  }

  await auth.signOut();

  return Future.value(true);
}

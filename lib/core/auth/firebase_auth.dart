import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture/core/helpers/firestore.dart';
import 'package:flutter_architecture/modules/home/screen/home.dart';
import 'package:flutter_architecture/modules/login/screen/login_page.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireAuthController extends GetxController {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Returns current user
  Rx<User?> get getCurrentUser => auth.currentUser.obs;
  Rx<User?> currentUser = Rx<User?>(auth.currentUser);

  // Stream of Auth state
  Stream<User?> get authStream => auth.userChanges();
  @override
  void onReady() async {
    // var authState = getCurrentUser.bindStream(auth.authStateChanges());
    // ever(authState, setInitialScreen(authState.value));
  }

  setInitialScreen(user) {
    if (user == false) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => LoginPage());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const Home());
    }
  }

  //Sign in with Google
  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential authResult =
          await auth.signInWithCredential(credential);
      final User user = authResult.user!;
      final query = await Firestore().getUserInfoFromDb(user);
      if (query.docs.length == 0) {
        await Firestore().addUserInfoToDb({
          "uid": user.uid,
          "name": user.displayName,
          "authProvider": "google",
          "email": user.email,
        });
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  //Create user with email and password
  Future<User> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((userCredential) => userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

//SignIn user with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user!;
      final query = await Firestore().getUserInfoFromDb(user);
      if (query.docs.length == 0) {
        await Firestore().addUserInfoToDb({
          "uid": user.uid,
          // "name": user.displayName,
          "authProvider": "firebase",
          "email": user.email,
          "emailVerified": user.emailVerified
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  //Signout user
  Future<bool> signOut() async {
    try {
      return auth.signOut().then((value) => true);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}

// ignore_for_file: unused_import
import 'package:web_ffi/web_ffi.dart';
import 'package:obs_websocket/obs_websocket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/auth/register/otp.dart';
import 'package:flutter_application_1/utils/firebase.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  User getCurrentUser() {
    User user = firebaseAuth.currentUser!;
    return user;
  }

  static bool loading = false;

// create a firebase user
  Future<bool> createUser({
    String? name,
    User? user,
    required PhoneAuthCredential credentials,
    String? phone,
    String? passingyear,
    String? about,
  }) async {
    try {
      var res = await firebaseAuth.signInWithCredential(credentials);

      // var res = await firebaseAuth.createUserWithphoneAndPassword(
      //   phone: '$phone',
      //   password: '$password',
      // );
      if (res.user != null) {
        await saveUserToFirestore(
            name!, res.user!, phone!, passingyear!, about!);
        return true;
      } else {
        // showInSnackBar("failed", );
        print("object");
        return false;
      }
    } catch (e) {
      print(e.toString());

      return false;
    }
  }

  static dynamic newUserResult;
  static var vId = "";

  Future createUserwithOTP(
    BuildContext context, {
    dynamic phone,
  }) async {
    loading = true;

    await verifyPhone(phone, context);

    // if (newUserResult != null) {
    //   // await saveUserToFirestore(
    //   //     name!, newUserResult.user!, phone!, passingyear!);
    //   print("user saved to databse");
    //   return true;
    // } else {
    //   print("Returning false inside saveuserTOFIrestore");
    //   return false;
    // }
  }
}

Future<void> verifyPhone(dynamic phoneNo, BuildContext buildContext) async {
  // String smsCode;
  // Future<String> getOTPresult() async {
  //   String otp = await Navigator.of(buildContext).push(
  //     CupertinoPageRoute(
  //       builder: (_) => const MyVerify(),
  //     ),
  //   // );
  //   // String otp = await Navigator.of(buildContext).pushReplacement(
  //   //           CupertinoPageRoute(
  //   //             builder: (_) => const MyVerify()
  //   //           ),

  //   );
  //   print("user enteredd------->"+otp);
  //   smsCode = otp;
  //   return smsCode;
  // }
  // AuthSerloading = true;
  AuthService.loading = true;
  await firebaseAuth.verifyPhoneNumber(
    phoneNumber: phoneNo,
    timeout: const Duration(seconds: 60),
    codeAutoRetrievalTimeout: (String verificationId) {},
    codeSent: (String verificationId, int? forceResendingToken) async {
      // ignore: avoid_print
      print("genertated----->$verificationId");
      // AuthService.vId = verificationId;
      AuthService.loading = true;
      await Navigator.of(buildContext).pushReplacement(
        CupertinoPageRoute(builder: (_) => MyVerify(verifyID: verificationId)),
      );

      // String OTPDialogResult = await getOTPresult();

// AuthCredential authCred = PhoneAuthProvider.getCredential( verificationId: verificationId, smsCode: OTPDialogResult);
//   newUserResult =  AuthService().signInWithPhoneNumber(authCred);

      // print("received------>" + AuthService.vId);
      // PhoneAuthCredential credential = PhoneAuthProvider.credential(
      //     verificationId: AuthService.vId, smsCode: OTPDialogResult);
      // AuthService.newUserResult =
      //     await firebaseAuth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException error) {
      print(error);
    },
    verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
      // await firebaseAuth.signInWithCredential(phoneAuthCredential);
    },
  );
}

//this will save the details inputted by the user to firestore.
// saveUserToFirestore(
//     String name, User user, String phone, String passingyear) async {
//   await usersRef.doc(user.uid).set({
//     'username': name,
//     'phone': phone,
//     'time': Timestamp.now(),
//     'id': user.uid,
//     'bio': "",
//     'passingyear': passingyear,
//     'photoUrl': user.photoURL ?? '',
//     'gender': '',
//   });
// }

saveUserToFirestore(String name, User user, String phone, String passingyear,
    String about) async {
  await usersRef.doc(user.uid).set({
    'username': name,
    'phone': phone,
    'time': Timestamp.now(),
    'id': user.uid,
    'about': about,
    'passingyear': passingyear,
    'photoUrl': user.photoURL ?? '',
    'gender': '',
  });
}

// function to login a user with his phone and password
// Future<bool> loginUser({String? phone, String? password}) async {
//   var res = await firebaseAuth.signInWithphoneAndPassword(
//     phone: '$phone',
//     password: '$password',
//   );

//   if (res.user != null) {
//     return true;
//   } else {
//     return false;
//   }
// }

// forgotPassword(String phone) async {
//   await firebaseAuth.sendPasswordResetphone(phone: phone);
// }

logOut() async {
  await firebaseAuth.signOut();
}

String handleFirebaseAuthError(String e) {
  if (e.contains("ERROR_WEAK_PASSWORD")) {
    return "Password is too weak";
  } else if (e.contains("invalid-phone")) {
    return "Invalid phone";
  } else if (e.contains("ERROR_phone_ALREADY_IN_USE") ||
      e.contains('phone-already-in-use')) {
    return "The phone address is already in use by another account.";
  } else if (e.contains("ERROR_NETWORK_REQUEST_FAILED")) {
    return "Network error occured!";
  } else if (e.contains("ERROR_USER_NOT_FOUND") ||
      e.contains('firebase_auth/user-not-found')) {
    return "Invalid credentials.";
  } else if (e.contains("ERROR_WRONG_PASSWORD") ||
      e.contains('wrong-password')) {
    return "Invalid credentials.";
  } else if (e.contains('firebase_auth/requires-recent-login')) {
    return 'This operation is sensitive and requires recent authentication.'
        ' Log in again before retrying this request.';
  } else {
    return e;
  }
}

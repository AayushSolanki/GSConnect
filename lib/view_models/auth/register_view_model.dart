import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth/register/phone_verify.dart';
import 'package:flutter_application_1/auth/register/profile_pic.dart';
import 'package:flutter_application_1/utils/firebase.dart';

import 'package:flutter_application_1/services/auth_service.dart';

import '../../auth/register/otp.dart';

class RegisterViewModel extends ChangeNotifier {
  User getCurrentUser() {
    User user = firebaseAuth.currentUser!;
    return user;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool validate = false;
  bool loading = false;
  String? username, passingyear, about;
  dynamic phone;
  FocusNode usernameFN = FocusNode();
  FocusNode phoneFN = FocusNode();
  FocusNode passingyearFN = FocusNode();
  FocusNode aboutFN = FocusNode();
  AuthService auth = AuthService();

  register(BuildContext context, PhoneAuthCredential credential) async {
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
    } else {
      if (credential != null) {
        loading = true;
        notifyListeners();
        try {
          notifyListeners();

          bool success = await auth.createUser(
              credentials: credential,
              name: username,
              phone: phone,
              passingyear: passingyear,
              about: about);
          // print(success);
          // print("before calling success");
          if (success) {
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) => ProfilePicture(),
              ),
            );
          } else {
            loading = false;
            notifyListeners();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (_) =>
                    MyVerify(verifyID: credential.verificationId.toString()),
              ),
            );
            // ignore: use_build_context_synchronously
            showInSnackBar('Try again wrong otp ', context);
          }
        } catch (e) {
          loading = false;
          notifyListeners();
          print(e);
          Navigator.of(context).pushReplacement(
            CupertinoPageRoute(
              builder: (_) => phoneVerify(),
            ),
          );
          showInSnackBar('try again wrong otp', context);
        }
        loading = false;
        notifyListeners();
      } else {
        showInSnackBar('The passwords does not match', context);
      }
    }
  }

  Future createUserwithOTP(
    BuildContext context, {
    dynamic phone,
  }) async {
    // loading = true;
    // notifyListeners();

    await verifyPhone(phone, context);
  }

  Future<void> verifyPhone(dynamic phoneNo, BuildContext buildContext) async {
    // loading = true;
    // notifyListeners();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
      codeSent: (String verificationId, int? forceResendingToken) async {
        // ignore: avoid_print
        print("genertated----->$verificationId");
        // AuthService.vId = verificationId;
        loading = false;

        notifyListeners();

        await Navigator.of(buildContext).pushReplacement(
          CupertinoPageRoute(
              builder: (_) => MyVerify(verifyID: verificationId)),
        );
      },
      verificationFailed: (FirebaseAuthException error) {
        showInSnackBar('Try again', buildContext);
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {},
    );
  }

  otpsend(BuildContext context) async {
    loading = true;
    FormState form = formKey.currentState!;
    form.save();
    if (!form.validate()) {
      validate = true;
      notifyListeners();
      showInSnackBar(
          'Please fix the errors in red before submitting.', context);
      loading = false;
    } else {
      // if (password == cPassword) {
      loading = true;
      // notifyListeners();
      try {
        notifyListeners();

        // bool success = await auth.createUser(
        //   name: username,
        //   phone: phone,
        //   password: password,
        //   passingyear: passingyear,
        showInSnackBar('OTP sent please wait', context);
        await createUserwithOTP(
          context,
          phone: phone,
          // name: username,
          // password: password,
          // passingyear: passingyear,
        );
        // if (success) {
        //   print("success in verify phone moving to create account");

        //   Navigator.of(context).pushReplacement(
        //     CupertinoPageRoute(
        //       builder: (_) => ProfilePicture(),
        //     ),
        //   );
        // }
      } catch (e) {
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar("Restart the app", context);
      }
      loading = false;
      notifyListeners();
      // } else {
      //   showInSnackBar('The passwords does not match', context);
      // }
    }
  }

  // setEmail(val) {
  //   email = val;
  //   notifyListeners();
  // }

  setPhone(val) {
    phone = val;
    notifyListeners();
  }

  setAbout(val) {
    about = val;
    notifyListeners();
  }

  setName(val) {
    username = val;
    notifyListeners();
  }

  setpassingyear(val) {
    passingyear = val;
    notifyListeners();
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}

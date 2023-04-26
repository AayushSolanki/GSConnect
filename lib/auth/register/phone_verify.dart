import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view_models/auth/register_view_model.dart';
import 'package:flutter_application_1/widgets/indicators.dart';

// ignore: camel_case_types
class phoneVerify extends StatefulWidget {
  const phoneVerify({super.key});

  @override
  State<phoneVerify> createState() => _phoneVerifyState();
}

// ignore: camel_case_types
class _phoneVerifyState extends State<phoneVerify> {
  bool buttonenabled = true;
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);
    return LoadingOverlay(
      progressIndicator: circularProgress(context),
      isLoading: viewModel.loading,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: viewModel.scaffoldKey,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/images/signup.png',
                ),
              )),
            ),
            const Text(
              'Verify Phone',
              style: TextStyle(
                // fontFamily: 'BilboSwashCaps-Regular',
                fontFamily: 'inconsolata',

                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
            buildForm(viewModel, context),
            const SizedBox(height: 10.0),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text(
            //       'Already have an account  ',
            //     ),
            //     GestureDetector(
            //       onTap: () => Navigator.pop(context),
            //       child: Text(
            //         'Login',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           //color: Theme.of(context).colorScheme.secondary,
            //           color: Colors.blueAccent.shade700,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  buildForm(RegisterViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          // TextFormBuilder(
          //   enabled: !viewModel.loading,
          //   prefix: Ionicons.phone_portrait,
          //   hintText: "Phone Number",
          //   textInputAction: TextInputAction.next,
          // validateFunction: Validations.validatePhone,
          //   onSaved: (String val) {
          //     viewModel.setPhone(val);
          //   },
          //   focusNode: viewModel.phoneFN,
          //   nextFocusNode: viewModel.phoneFN,
          // ),
          IntlPhoneField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(
                borderSide: BorderSide(),
              ),
            ),
            focusNode: viewModel.phoneFN,
            initialCountryCode: 'IN',
            onSaved: (val) {
              viewModel.setPhone(val?.completeNumber);
              // print(val?.completeNumber);
            },
            onChanged: (phone) {
              print(phone.completeNumber);
              viewModel.setPhone(phone);
            },
          ),

          const SizedBox(height: 25.0),
          SizedBox(
            height: 45.0,
            width: 300.0,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.blueAccent.shade700),
              ),
              child: Text(
                'Verify'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // onPressed: () => viewModel.register(context),
              // onPressed: () => viewModel.otpsend(context),
              onPressed: () async {
                bool result = await InternetConnectionChecker().hasConnection;
                if (result == true) {
                  // ignore: use_build_context_synchronously
                  viewModel.otpsend(context);
                } else {
                  // ignore: use_build_context_synchronously
                  showInSnackBar(
                      "Get an internet connection to proceed", context);
                }
                // setState(() {
                //   if (buttonenabled) {
                //     buttonenabled = false;

                //     viewModel.otpsend(context);
                //   }
                //   else{
                //             buttonenabled = true;
                //             //if buttonenabled == false, then make buttonenabled = true
                //         }
                // });
              },

              //   onPressed: () =>    Navigator.of(context).pushReplacement(
              //   CupertinoPageRoute(
              //     builder: (_) => MyVerify(),
              //   )
              // )
            ),
          ),
        ],
      ),
    );
  }
}

void showInSnackBar(String value, context) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
}

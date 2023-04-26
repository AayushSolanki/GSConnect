// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/auth/register/phone_verify.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:loading_overlay/loading_overlay.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/auth/register/register.dart';
// import 'package:flutter_application_1/components/password_text_field.dart';
// import 'package:flutter_application_1/components/text_form_builder.dart';
// import 'package:flutter_application_1/utils/validation.dart';
// import 'package:flutter_application_1/view_models/auth/login_view_model.dart';
// import 'package:flutter_application_1/widgets/indicators.dart';

// class Login extends StatefulWidget {
//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

//     return LoadingOverlay(
//       progressIndicator: circularProgress(context),
//       isLoading: viewModel.loading,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         key: viewModel.scaffoldKey,
//         body: ListView(
//           padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
//           children: [
//             SizedBox(height: MediaQuery.of(context).size.height / 5),
//             Container(
//               height: 300.0,
//               width: MediaQuery.of(context).size.width,
//               child: Image.asset(
//                 'assets/images/login.png',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             const Center(
//               child: Text(
//                 'Login',
//                 style: TextStyle(
//                   fontSize: 40.0,
//                   fontFamily: 'BilboSwashCaps-Regular',
//                   //fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             /*Center(
//               child: Text(
//                 'Log into your account',
//                 style: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w300,
//                   color: Theme.of(context).colorScheme.secondary,
//                 ),
//               ),
//             ),*/
//             const SizedBox(height: 25.0),
//             buildForm(context, viewModel),
//             const SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text('Don\'t have an account?'),
//                 const SizedBox(width: 5.0),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.of(context).push(
//                       CupertinoPageRoute(
//                         builder: (_) => phoneVerify(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       //color: Theme.of(context).colorScheme.secondary,
//                       color: Colors.blueAccent.shade700,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   buildForm(BuildContext context, LoginViewModel viewModel) {
//     return Form(
//       key: viewModel.formKey,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       child: Column(
//         children: [
//           TextFormBuilder(
//             enabled: !viewModel.loading,
//             //prefix: Ionicons.mail_outline,
//             prefix: Ionicons.phone_portrait_outline,
//             hintText: "Phone",
//             textInputAction: TextInputAction.next,
//             validateFunction: Validations.validateEmail,
//             onSaved: (String val) {
//               viewModel.setEmail(val);
//             },
//             focusNode: viewModel.emailFN,
//             nextFocusNode: viewModel.passFN,
//           ),
//           const SizedBox(height: 15.0),
//           PasswordFormBuilder(
//             enabled: !viewModel.loading,
//             prefix: Ionicons.lock_closed_outline,
//             suffix: Ionicons.eye_outline,
//             hintText: "Password",
//             textInputAction: TextInputAction.done,
//             validateFunction: Validations.validatePassword,
//             submitAction: () => viewModel.login(context),
//             obscureText: true,
//             onSaved: (String val) {
//               viewModel.setPassword(val);
//             },
//             focusNode: viewModel.passFN,
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 10.0),
//               child: InkWell(
//                 onTap: () => viewModel.forgotPassword(context),
//                 child: Container(
//                   width: 130,
//                   height: 40,
//                   child: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           Container(
//             height: 45.0,
//             width: 300.0,
//             child: ElevatedButton(
//               style: ButtonStyle(
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(40.0),
//                     ),
//                   ),
//                   /*backgroundColor: MaterialStateProperty.all<Color>(
//                   Theme.of(context).colorScheme.secondary,
//                 ),*/
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                     Colors.blueAccent.shade700,
//                   )
//                 //backgroundColor: Colors.blueAccent[700],
//               ),
//               // highlightElevation: 4.0,
//               child: Text(
//                 'Log in'.toUpperCase(),
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               onPressed: () => viewModel.login(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

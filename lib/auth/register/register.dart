import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/components/text_form_builder.dart';
import 'package:flutter_application_1/utils/validation.dart';
import 'package:flutter_application_1/view_models/auth/register_view_model.dart';
import 'package:flutter_application_1/widgets/indicators.dart';

class Register extends StatefulWidget {
  final PhoneAuthCredential credential;
  // final dynamic res;
  // FirebaseUser user;
  const Register({Key? key, required this.credential}) : super(key: key);
  // const Register({Key? key, required this.res}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late String _myActivity;
  late String _myActivityResult;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }
  final List<String> items = [
'1956',
'1957',
'1958',
'1959',
'1960',
'1961',
'1962',
'1963',
'1964',
'1965',
'1966',
'1967',
'1968',
'1969',
'1970',
'1971',
'1972',
'1973',
'1974',
'1975',
'1976',
'1977',
'1978',
'1979',
'1980',
'1981',
'1982',
'1983',
'1984',
'1985',
'1986',
'1987',
'1988',
'1989',
'1990',
'1991',
'1992',
'1993',
'1994',
'1995',
'1996',
'1997',
'1998',
'1999',
'2000',
'2001',
'2002',
'2003',
'2004',
'2005',
'2006',
'2007',
'2008',
'2009',
'2010',
'2011',
'2012',
'2013',
'2014',
'2015',
'2016',
'2017',
'2018',
'2019',
'2020',
'2021',
'2022',
'2023',
'2024',
'2025',
'2026',
];
String? selectedValue;

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
            // SizedBox(height: MediaQuery.of(context).size.height / 50),
            /*Text(
              'Welcome to GS70\nCreate a new account and connect with friends',
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),*/
            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/images/chat.png',
                ),
              )),
            ),
            const Text(
              'Sign In',
              style: TextStyle(
                fontFamily: 'BilboSwashCaps-Regular',
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            buildForm(viewModel, context),
            const SizedBox(height: 10.0),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       const Text(
          //         'Already have an account  ',
          //       ),
          //       GestureDetector(
          //         onTap: () => Navigator.of(context).pushReplacement(
          //           CupertinoPageRoute(
          //             builder: (_) => phoneVerify(),
          //           ),
          //         ),
          //         child: Text(
          //           'Login',
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             //color: Theme.of(context).colorScheme.secondary,
          //             color: Colors.blueAccent.shade700,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
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
          TextFormBuilder(
            enabled: !viewModel.loading,
            prefix: Ionicons.person_outline,
            hintText: "Name",
            textInputAction: TextInputAction.next,
            validateFunction: Validations.validateName,
            onSaved: (String val) {
              viewModel.setName(val);
            },
            focusNode: viewModel.usernameFN,
            nextFocusNode: viewModel.phoneFN,
          ),
          const SizedBox(height: 20.0),
          TextFormBuilder(
            enabled: !viewModel.loading,
            //prefix: Ionicons.mail_outline,

            prefix: Ionicons.text_outline,
            hintText: "About You",
           validateFunction: Validations.validateAbout,

            textInputAction: TextInputAction.newline,
            onSaved: (String val) {
              viewModel.setAbout(val);
            },
            focusNode: viewModel.aboutFN,
            nextFocusNode: viewModel.passingyearFN,
          ),
          const SizedBox(height: 30.0),
          DropdownButtonFormField2(
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                'Select Your Passing Year',
                style: TextStyle(fontSize: 14),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.blueAccent,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonPadding: const EdgeInsets.only(left: 10, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
              ),
              items: items
                      .map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                      .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select passing year';
                }
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
                                viewModel.setpassingyear(value.toString());

              },
              onSaved: (value) {
                selectedValue = value.toString();
                viewModel.setpassingyear(selectedValue);
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
                'Sign in'.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => viewModel.register(context, widget.credential),
            ),
          ),
        ],
      ),
    );
  }
}

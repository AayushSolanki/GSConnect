class Validations {
  static String? validateName(String? value) {
    if (value!.isEmpty) return 'Username is Required.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Please enter only alphabetical characters.';
    }
  }
  static String? validateAbout(String? value) {
    if (value!.isEmpty) return 'About is Required.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    // if (!nameExp.hasMatch(value)) {
    //   return 'Please enter only alphabetical characters.';
    // }
  }

  static String? validateEmail(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) {
      return 'Invalid email address';
    }
  }

  static String? validatePhone(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Phone Number is required.';
    final RegExp nameExp = RegExp(
        r"(^(?:[+0]9)?[0-9]{10,12}$)");
    if (!nameExp.hasMatch(value) && isRequried) {
      return 'Invalid Phone Number';
    }
  }

  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Please enter a valid password.';
    }
  }
}

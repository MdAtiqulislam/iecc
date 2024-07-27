import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'constraints/app_strings.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": {
          //button text
          AppTitlesAndKeys.logInButtonTextKey: "Sign In",
          AppTitlesAndKeys.logOutButtonTextKey: "Sign Out",
          AppTitlesAndKeys.signUpTextKey: "Sign Up",
          AppTitlesAndKeys.registrationTextKey: "Registration",
          AppTitlesAndKeys.forgotPasswordButtonTextKey: "Forgot your password?",
          AppTitlesAndKeys.noAccountButtonTextKey: "Don't have an account?",
          AppTitlesAndKeys.haveAccountButtonTextKey: "Already have an account?",

          //page title
          AppTitlesAndKeys.leadListPageTitle: "All Lead",

          //textField title
          AppTitlesAndKeys.emailTFTitle: "Email",
          AppTitlesAndKeys.emailTFHint: "xyz@mail.com",
          AppTitlesAndKeys.nameTFTitle: "Name",
          AppTitlesAndKeys.nameTFHint: "Mr. XYZ",
          AppTitlesAndKeys.phoneOrEmailTFTitle: "Email",
          AppTitlesAndKeys.phoneOrEmailTFHint: "xyz@mail.com",
          AppTitlesAndKeys.phoneTFTitle: "Phone",
          AppTitlesAndKeys.phoneTFHint: "Phone",
          AppTitlesAndKeys.passwordTFTitle: "Password",
          AppTitlesAndKeys.passwordTFHint: "Password",
          AppTitlesAndKeys.confirmPasswordTFTitle: "Confirm Password",
          AppTitlesAndKeys.confirmPasswordTFHint: "Confirm Password",

          //Others
          AppTitlesAndKeys.loginPageWelcomeText:
              "Welcome to IECC! Log in to see the latest",
          AppTitlesAndKeys.registrationPageWelcomeText:
              "Want to open a new account?",
        }
      };
}

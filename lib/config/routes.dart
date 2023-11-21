import 'package:arthub/pages/account_page.dart';
import 'package:arthub/pages/home_page.dart';
import 'package:arthub/pages/login_page.dart';
import 'package:arthub/pages/registration_page.dart';
import 'package:arthub/pages/reset_password_page.dart';
import 'package:arthub/pages/verify_email_page.dart';

class Routes{
  static final pages={
    login:(context) => LoginPage(),
    register:(context) => RegistrationPage(),
    home:(context) => HomePage(),
    reset_password:(context) => ResetPasswordPage(),
    account:(context) => AccountPage(),
    verify_email:(context) => VerifyEmailPage(),
    };






    static const login="/login";
    static const register="/registration";
    static const home="/home";
    static const reset_password="/reset_password";
    static const account="/account";
    static const verify_email="/verify_email";
}
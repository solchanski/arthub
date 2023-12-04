import 'package:arthub/models/user.dart';
import 'package:arthub/providers/user_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:arthub/resources/auth_methods.dart';
import 'package:arthub/responsive/mobile_screen_layout.dart';
import 'package:arthub/pages/auth/registration_page.dart';
import 'package:arthub/utils/colors.dart';
import 'package:arthub/utils/global_variable.dart';
import 'package:arthub/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool isHiddenPassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
      context.read<UserProvider>().refreshUser();
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      // context.read<UserProvider>().user = User(username: null, uid: uid, photoUrl: photoUrl, email: email, bio: bio, followers: followers, following: following)
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const MobileScreenLayout(),
            ),
            (route) => false);

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_log.png'),
          fit: BoxFit.cover)),
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _emailController,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Введите правильный Email'
                        : null,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'E-mail',
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25))
                    ),
                 ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                autocorrect: false,
                controller: _passwordController,
                obscureText: isHiddenPassword,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Пароль',
                  border: UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))
                  ),
                  suffixIcon: IconButton(
                                icon: Icon(isHiddenPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isHiddenPassword = !isHiddenPassword;
                                  });
                                },
                              ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/reset_password'),
                  child: const Text('Забыли пароль?',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: loginUser,
                child: Container(
                  height: 60,
                  width: 135,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'ВОЙТИ',
                          style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          ),
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Нет аккаунта? ',
                      style: TextStyle(
                        color: primaryColor,
                        ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        'Создать',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:arthub/config/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:arthub/services/snack_bar.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   bool isHiddenPassword = true;
//   TextEditingController emailTextInputController = TextEditingController();
//   TextEditingController passwordTextInputController = TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailTextInputController.dispose();
//     passwordTextInputController.dispose();

//     super.dispose();
//   }

//   void togglePasswordView() {
//     setState(() {
//       isHiddenPassword = !isHiddenPassword;
//     });
//   }

//   Future<void> login() async {
//     final navigator = Navigator.of(context);

//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;

//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailTextInputController.text.trim(),
//         password: passwordTextInputController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e.code);

//       if (e.code == 'user-not-found' || e.code == 'wrong-password') {
//         SnackBarService.showSnackBar(
//           context,
//           'Неправильный email или пароль. Повторите попытку',
//           true,
//         );
//         return;
//       } else {
//         SnackBarService.showSnackBar(
//           context,
//           'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
//           true,
//         );
//         return;
//       }
//     }

//     navigator.pushNamedAndRemoveUntil(Routes.search, (Route<dynamic> route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_log.png'),
//         fit: BoxFit.cover)),
//         padding: EdgeInsets.all(30),
//         child: Form(
//           key: formKey,
//           child: Column(
//             children: [
//               Spacer(),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 controller: emailTextInputController,
//                 validator: (email) =>
//                     email != null && !EmailValidator.validate(email)
//                         ? 'Введите правильный Email'
//                         : null,
//                 decoration: InputDecoration(
//                     fillColor: Colors.white,
//                     filled: true,
//                     hintText: 'E-mail',
//                     border: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))
//                     ),
//                  ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 autocorrect: false,
//                 controller: passwordTextInputController,
//                 obscureText: isHiddenPassword,
//                 validator: (value) => value != null && value.length < 6
//                     ? 'Минимум 6 символов'
//                     : null,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Пароль',
//                   border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))
//                   ),
//                   suffixIcon: IconButton(
//                                 icon: Icon(isHiddenPassword
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                                 onPressed: () {
//                                   setState(() {
//                                     isHiddenPassword = !isHiddenPassword;
//                                   });
//                                 },
//                               ),

//                 ),
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () =>
//                       Navigator.of(context).pushNamed('/reset_password'),
//                   child: const Text('Забыли пароль?',
//                     style: TextStyle(
//                       color: Colors.white,
//                       decoration: TextDecoration.underline),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 height: 50,
//                 width: 135,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xff514FFF),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                   ),
//                 onPressed: login,
//                 child: Text(
//                   'ВОЙТИ',
//                   style: TextStyle(
//                   color: Colors.white,
//                   ),
//                  ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Нет аккаунта?',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () => Navigator.of(context).pushNamed(Routes.register),
//                     child: Text(
//                       'Cоздать',
//                       style: TextStyle(
//                           color: Colors.white,
//                           decoration: TextDecoration.underline),
//                     ),
//                   ),
//                 ],
//               ),
//               Spacer(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
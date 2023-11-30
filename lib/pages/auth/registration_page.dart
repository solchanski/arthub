import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:arthub/resources/auth_methods.dart';
import 'package:arthub/responsive/mobile_screen_layout.dart';
import 'package:arthub/pages/auth/login_page.dart';
import 'package:arthub/utils/colors.dart';
import 'package:arthub/utils/utils.dart';
import 'package:arthub/pages/widgets/text_field_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _bioController = TextEditingController();
  bool _isLoading = false;
  // Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    // set loading to true
    setState(() {
      _isLoading = true;
    });

    // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        );
    // if string returned is sucess, user has been created
    if (res == "success") {
      setState(() {
        _isLoading = false;
      });
      // navigate to the home screen
      if (context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MobileScreenLayout(),
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      // show the error
      if (context.mounted) {
        showSnackBar(context, res);
      }
    }
  }

  // selectImage() async {
  //   Uint8List im = await pickImage(ImageSource.gallery);
  //   // set state because we need to display the image we selected on the circle avatar
  //   setState(() {
  //     _image = im;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flexible(
              //   flex: 2,
              //   child: Container(),
              // ),
              // const SizedBox(
              //   height: 64,
              // ),
              // Stack(
              //   children: [
              //     _image != null
              //         ? CircleAvatar(
              //             radius: 64,
              //             backgroundImage: MemoryImage(_image!),
              //             backgroundColor: Colors.red,
              //           )
              //         : const CircleAvatar(
              //             radius: 64,
              //             backgroundImage: NetworkImage(
              //                 'https://i.stack.imgur.com/l60Hf.png'),
              //             backgroundColor: Colors.red,
              //           ),
              //     Positioned(
              //       bottom: -10,
              //       left: 80,
              //       child: IconButton(
              //         onPressed: selectImage,
              //         icon: const Icon(Icons.add_a_photo),
              //       ),
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 24,
              // ),
              TextFieldInput(
                hintText: 'Enter your username',
                textInputType: TextInputType.text,
                textEditingController: _usernameController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),
              const SizedBox(
                height: 24,
              ),
              // TextFieldInput(
              //   hintText: 'Enter your bio',
              //   textInputType: TextInputType.text,
              //   textEditingController: _bioController,
              // ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: signUpUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor,
                  ),
                  child: !_isLoading
                      ? const Text(
                          'Sign up',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                flex: 2,
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                       color: Colors.white,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        ' Login.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
// import 'package:arthub/pages/services/snack_bar.dart';

// class RegistrationPage extends StatefulWidget {
//   const RegistrationPage({super.key});

//   @override
//   State<RegistrationPage> createState() => RegistrationPageState();
// }

// class RegistrationPageState extends State<RegistrationPage> {
//   bool isHiddenPassword = true;
//   TextEditingController emailTextInputController = TextEditingController();
//   TextEditingController passwordTextInputController = TextEditingController();
//   TextEditingController passwordTextRepeatInputController =
//       TextEditingController();
//   final formKey = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     emailTextInputController.dispose();
//     passwordTextInputController.dispose();
//     passwordTextRepeatInputController.dispose();

//     super.dispose();
//   }

//   void togglePasswordView() {
//     setState(() {
//       isHiddenPassword = !isHiddenPassword;
//     });
//   }

//   Future<void> signUp() async {
//     final navigator = Navigator.of(context);

//     final isValid = formKey.currentState!.validate();
//     if (!isValid) return;

//     if (passwordTextInputController.text !=
//         passwordTextRepeatInputController.text) {
//       SnackBarService.showSnackBar(
//         context,
//         'Пароли должны совпадать',
//         true,
//       );
//       return;
//     }

//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailTextInputController.text.trim(),
//         password: passwordTextInputController.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e.code);

//       if (e.code == 'email-already-in-use') {
//         SnackBarService.showSnackBar(
//           context,
//           'Такой Email уже используется, повторите попытку с использованием другого Email',
//           true,
//         );
//         return;
//       } else {
//         SnackBarService.showSnackBar(
//           context,
//           'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
//           true,
//         );
//       }
//     }

//     navigator.pushNamedAndRemoveUntil(Routes.home, (Route<dynamic> route) => false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/background_reg.png'),
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
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'E-mail',
//                   border: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 autocorrect: false,
//                 controller: emailTextInputController,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Имя пользователя',
//                   border: UnderlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(25))),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               TextFormField(
//                 autocorrect: false,
//                 controller: passwordTextInputController,
//                 obscureText: isHiddenPassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) => value != null && value.length < 6
//                     ? 'Минимум 6 символов'
//                     : null,
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
//               const SizedBox(height: 15),
//               TextFormField(
//                 autocorrect: false,
//                 controller: passwordTextRepeatInputController,
//                 obscureText: isHiddenPassword,
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 validator: (value) => value != null && value.length < 6
//                     ? 'Минимум 6 символов'
//                     : null,
//                 decoration: InputDecoration(
//                   fillColor: Colors.white,
//                   filled: true,
//                   hintText: 'Повторите пароль',
//                   border: UnderlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(25))
//                   ),
//                   suffixIcon: IconButton(
//                                 icon: Icon(isHiddenPassword
//                                     ? Icons.visibility
//                                     : Icons.visibility_off),
//                                 onPressed: () {
//                                   setState(() {
//                                     isHiddenPassword = !isHiddenPassword;
//                                   });
//                                 },
//                               ),

//                 ),
//               ),
//               const SizedBox(height: 40),
//               SizedBox(
//                 height: 50,
//                 width: 270,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xffDA480A),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
//                   ),
//                   onPressed: signUp,
//                   child: Text(
//                     'СОЗДАТЬ АККАУНТ',
//                     style: TextStyle(
//                     color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Уже есть аккаунт?',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                   TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                     child: Text(
//                       'Войти',
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


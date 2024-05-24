import 'package:creche/controllers/home_controller.dart';
import 'package:creche/controllers/profile_controller.dart';
import 'package:creche/core/helperes/app_validators.dart';
import 'package:creche/core/widgets/custom_input_texr.dart';
import 'package:creche/screen/profile/screen_register.dart';
import 'package:creche/screen/profile/screen_reset_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({Key? key}) : super(key: key);

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  bool showPassword = true;
  ProfileController? profileController;
  final keyForm = GlobalKey<FormState>();
  HomeController homeController = HomeController();

  @override
  void initState() {
    profileController = ProfileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          backgroundColor: Colors.brown[50],
          title: const Text(
            "Login",
          ),
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: MediaQuery.sizeOf(context).height * .8,
            width: MediaQuery.sizeOf(context).width * .8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 2, color: Colors.grey)),
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/creche.png",
                    width: 165,
                    height: 165,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInputText(
                    controller: ProfileController.emailController,
                    label: const Text("Email"),
                    hintText: "entrez votre email",
                    iconData: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre email";
                      } else if (!AppValidators.isEmailValid(value)) {
                        return "entrez un email valide";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInputText(
                    label: const Text("Mot de passe"),
                    controller: ProfileController.passWordController,
                    hintText: "entrez votre mot de passe",
                    iconData: Icons.lock,
                    obscureText: showPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.brown[200],
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre mot de passe";
                      } else if (value.length < 8) {
                        return "entrez password > 8 caracteres";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: const Text(
                        'mot de passe publie?',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenResetPassword()));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.brown),
                          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                              horizontal: 28, vertical: 15))),
                      onPressed: () async {
                        // if (keyForm.currentState!.validate()) {
                        profileController!.login(context);
                        // }
                        await homeController.getListEnfants(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ScreenHome(),
                        //     ));
                      },
                      child: const Text(
                        "connecter",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "vous etes inscrit? ",
                      children: [
                        TextSpan(
                            text: "Register",
                            style: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.brown),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tap register ');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenRegister(),
                                    ));
                              }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

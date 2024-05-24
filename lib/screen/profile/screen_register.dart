import 'package:creche/controllers/profile_controller.dart';
import 'package:creche/core/helperes/app_validators.dart';
import 'package:creche/core/widgets/custom_input_texr.dart';
import 'package:creche/screen/profile/screen_login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScreenRegister extends StatefulWidget {
  const ScreenRegister({Key? key}) : super(key: key);

  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  bool showPassword = true;
  bool showConfirmPassword = true;

  final keyForm = GlobalKey<FormState>();
  TextEditingController? emailController,
      nomController,
      adressController,
      nomCompletController,
      numeroTelController,
      passwordController,
      confirmationpasswordController;

  ProfileController? profileController;
  @override
  void initState() {
    emailController = TextEditingController();
    nomController = TextEditingController();
    adressController = TextEditingController();
    nomCompletController = TextEditingController();
    numeroTelController = TextEditingController();
    passwordController = TextEditingController();
    confirmationpasswordController = TextEditingController();
    profileController = ProfileController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(9),
          height: MediaQuery.sizeOf(context).height * .9,
          width: MediaQuery.sizeOf(context).width * .8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.grey)),
          child: SingleChildScrollView(
            child: Form(
              key: keyForm,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/creche.png",
                    width: 145,
                    height: 145,
                  ),
                  CustomInputText(
                    label: const Text("Nom complet"),
                    hintText: "entrez votre nom complet",
                    iconData: Icons.person,
                    controller: nomCompletController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre nom complet";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputText(
                    label: const Text("Nom d'utilsateur"),
                    hintText: "entrez votre nom ",
                    iconData: Icons.person,
                    controller: nomController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre nom";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputText(
                    controller: emailController,
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
                    height: 8,
                  ),
                  CustomInputText(
                    controller: adressController,
                    label: const Text("Adress"),
                    hintText: "entrez votre adress",
                    iconData: Icons.location_city_outlined,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre adress";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputText(
                    label: const Text("Numero de téléphone"),
                    hintText: "entrez votre numero",
                    iconData: Icons.phone,
                    controller: numeroTelController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre numero";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputText(
                    label: const Text("Mot de passe"),
                    controller: passwordController,
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
                    height: 8,
                  ),
                  CustomInputText(
                    controller: confirmationpasswordController,
                    label: const Text("Confirmation"),
                    hintText: "entrez votre mot de passe à nouveau",
                    iconData: Icons.lock,
                    obscureText: showConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      icon: Icon(
                        showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.brown[200],
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre mot de passe à nouveau";
                      } else if (passwordController!.text !=
                          confirmationpasswordController!.text) {
                        return "password invalide";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                           backgroundColor: MaterialStatePropertyAll(Colors.brown),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                            horizontal: 28, vertical: 15))),
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          print('email=============> ${emailController!.text}');
                          profileController!.register(
                              nomController!.text,
                              numeroTelController!.text,
                              adressController!.text,
                              emailController!.text,
                              passwordController!.text,
                              nomController!.text,
                              context);
                        }
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Avez-vous deja un compte ? ",
                      children: [
                        TextSpan(
                            text: "Login",
                            style: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.brown),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('tap Login ');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ScreenLogin(),
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

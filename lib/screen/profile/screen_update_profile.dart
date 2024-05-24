import 'package:creche/controllers/profile_controller.dart';
import 'package:creche/core/widgets/custom_input_texr.dart';
import 'package:flutter/material.dart';

class ScreenUpdateProfile extends StatelessWidget {
  ScreenUpdateProfile({Key? key}) : super(key: key);

  bool showPassword = true;

  final keyForm = GlobalKey<FormState>();

  int currentIndex = 0;

  ProfileController profileController = ProfileController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Profile",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
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
                    controller: ProfileController.nomCompletController,
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
                    controller: ProfileController.nomController,
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
                    controller: ProfileController.emailController,
                    label: const Text("Email"),
                    hintText: "entrez votre email",
                    iconData: Icons.email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez votre email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInputText(
                    controller: ProfileController.adressController,
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
                    controller: ProfileController.numeroTelController,
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
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 15))),
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          print(
                              'email=============> ${ProfileController.emailController.text}');
                          profileController.updateUser(
                              ProfileController.nomController.text,
                              ProfileController.numeroTelController.text,
                              ProfileController.adressController.text,
                              ProfileController.emailController.text,
                              ProfileController.nomController.text,
                              context);
                        }
                      },
                      child: const Text(
                        "Modifie",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

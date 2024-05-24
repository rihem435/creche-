import 'package:creche/controllers/profile_controller.dart';
import 'package:creche/core/widgets/custom_input_texr.dart';
import 'package:flutter/material.dart';

class ScreenResetPassword extends StatelessWidget {
  const ScreenResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: const EdgeInsets.all(18),
                height: MediaQuery.sizeOf(context).height * .8,
                width: MediaQuery.sizeOf(context).width * .8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.grey)),
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
                      hintText: "entrez votre email",
                      iconData: Icons.email,
                      controller: ProfileController.emailController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                        style:const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.brown),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 28, vertical: 15))),
                        onPressed: () {
                          if (ProfileController
                              .emailController.text.isNotEmpty) {
                            ProfileController.resetPassword(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ScreenMotPassOublie(),
                            //     ));
                          }
                        },
                        child: const Text(
                          "Envoyer",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )),
                  ],
                ))));
  }
}

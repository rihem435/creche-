import 'package:creche/controllers/personnel_controller.dart';
import 'package:flutter/material.dart';

import '../../core/widgets/custom_input.dart';

class ScreenUpdatePersonnel extends StatefulWidget {
  const ScreenUpdatePersonnel({Key? key}) : super(key: key);

  @override
  State<ScreenUpdatePersonnel> createState() => _ScreenUpdatePersonnelState();
}

class _ScreenUpdatePersonnelState extends State<ScreenUpdatePersonnel> {
  PersonnelController personnelController = PersonnelController();

  @override
  Widget build(BuildContext context) {
    personnelController.getPersonnel();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/listPersonnels");
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Modifie  personnel",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            // key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.brown[100],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    hintText: "nom",
                    controller: PersonnelController.nomController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    hintText: "prenom ",
                    // iconData: Icons.person,
                    controller: PersonnelController.nomCompletController,
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "entrez votre prenom";
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    controller: PersonnelController.adressController,
                    //label: Text("Adress"),
                    hintText: "adress",

                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "entrez votre adress";
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    controller: PersonnelController.numeroTelController,
                    //label: Text("Adress"),
                    hintText: "phone",

                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "entrez votre adress";
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomInput(
                    controller: PersonnelController.cinController,
                    //label: Text("Adress"),
                    hintText: "cin",

                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return "entrez votre adress";
                    //   }
                    // },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 15))),
                      onPressed: () {
                        setState(() {
                          personnelController.updatePersonnel(
                              PersonnelController.nomController.text,
                              PersonnelController.numeroTelController.text,
                              PersonnelController.adressController.text,
                              PersonnelController.cinController.text,
                              PersonnelController.nomCompletController.text,
                              context);
                          Navigator.pushNamed(context, "/listPersonnels");
                        });
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

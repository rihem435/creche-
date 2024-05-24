import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/screen/personnels/screen_list_personnel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ScreenAjoutPersonnel extends StatefulWidget {
  const ScreenAjoutPersonnel({Key? key}) : super(key: key);

  @override
  _ScreenAjoutPersonnelState createState() => _ScreenAjoutPersonnelState();
}

class _ScreenAjoutPersonnelState extends State<ScreenAjoutPersonnel> {
  final keyForm = GlobalKey<FormState>();
  HomeController? homeController;
  TextEditingController? nomController,
      adressController,
      nomCompletController,
      numeroTelController,
      cinController;

  @override
  void initState() {
    nomController = TextEditingController();
    adressController = TextEditingController();
    nomCompletController = TextEditingController();
    numeroTelController = TextEditingController();
    cinController = TextEditingController();
    super.initState();
  }

  final dio = Dio();
  addPersonnel(BuildContext context) {
    print('-----------------------add---------------------');
    Map<String, dynamic> data = {
      "firstName": nomController!.text..trim(),
      "lastName": nomCompletController!.text.trim(),
      "phone": numeroTelController!.text.trim(),
      "adress": adressController!.text.trim(),
      "cin": cinController!.text.trim()
    };
    dio.post(AppApi.personnelUrl, data: data).then(
      (value) async {
        print('value ===================> $value');

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScreenListPersonnel(),
        ));
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Ajouter  personnel",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.brown[100],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomInput(
                    hintText: "nom",
                    controller: nomController,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    hintText: "prenom ",
                    // iconData: Icons.person,
                    controller: nomCompletController,
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
                    controller: adressController,
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
                    controller: numeroTelController,
                    //label: Text("Adress"),
                    hintText: "numero telephone",

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
                    controller: cinController,
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
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.brown),
                          padding: MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 28, vertical: 15))),
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          addPersonnel(context);
                        }
                      },
                      child: const Text(
                        "Ajouter",
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

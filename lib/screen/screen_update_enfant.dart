import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';

import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/models/enfant_model.dart';
import 'package:creche/screen/screen_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ScreenUpdateEnfant extends StatefulWidget {
  const ScreenUpdateEnfant({Key? key}) : super(key: key);

  @override
  _ScreenUpdateEnfantState createState() => _ScreenUpdateEnfantState();
}

class _ScreenUpdateEnfantState extends State<ScreenUpdateEnfant> {
  String? tempPath;
  List<File> images = [];
  HomeController? homeController;

  void _pickFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((event) {
          setState(() {
            homeController!.pickedFile = files[0];
            homeController!.fileBytes = reader.result as Uint8List?;
          });
        });
      }
    });
  }

  final keyForm = GlobalKey<FormState>();
  String? Sevalue;
  List<String> items = ['homme', 'femme'];
  TextEditingController? emailController,
      nomController,
      adressController,
      nomCompletController,
      numeroTelController,
      programmeController,
      confirmationpasswordController;
  EnfantModel? enfantModel;
  getEnfant() async {
    var dio = Dio();
    print('get enfant+++++++++++++++++++++');
    try {
      var response = await dio.request(
        "${AppApi.listEnfantsUrl}${InfoStorage.readIdEnfant()}",
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print("get enfant==================================${response.data}");
        enfantModel = EnfantModel.fromJson(response.data);
        print(
            "get enfant==================================${enfantModel!.data!.birthdate}");

        nomController!.text = enfantModel!.data!.firstName!;
        nomCompletController!.text = enfantModel!.data!.lastName!;
        numeroTelController!.text = enfantModel!.data!.phone!.toString();
        adressController!.text = enfantModel!.data!.adress!;
        //   HomeController.categoryModel!.data!.sId,
        //   'parent': HomeController.userModel!.data!.sId!,
        //  'sex': Sevalue,
        programmeController!.text = enfantModel!.data!.program!;
        // 'birthdate': HomeController.selectedDate.toString()
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => const ScreenHome()));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("error get enfant=======================>$e");
    }
  }

  modifieEnfants(BuildContext context) async {
    try {
      // String fileName = image!.path.split('/').last;
      print('image======================');
      Map<String, dynamic> data = {
        'firstName': nomController!.text.trim(),
        'lastName': nomCompletController!.text.trim(),
        'phone': numeroTelController!.text.trim(),
        'adress': adressController!.text.trim(),
        //'category': HomeController.categoryModel!.data!.sId,
        // 'parent': HomeController.userModel!.data!.sId!,
        // 'sex': Sevalue,
        'program': programmeController!.text.trim(),
        //'birthdate': HomeController.selectedDate.toString()
      };

      print('test fun----------------------------------------');
      var dio = Dio();
      var response = await dio.request(
        "${AppApi.listEnfantsUrl}${InfoStorage.readIdEnfant()}",
        options: Options(
          method: 'PATCH',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("la modification   est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ScreenHome()));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("error modifie enfant=======================>$e");
    }
  }

  @override
  void initState() {
    homeController = HomeController();
    emailController = TextEditingController();
    nomController = TextEditingController();
    adressController = TextEditingController();
    nomCompletController = TextEditingController();
    numeroTelController = TextEditingController();
    programmeController = TextEditingController();
    confirmationpasswordController = TextEditingController();
    getEnfant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Modifie enfants",
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: keyForm,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Icon(
                  Icons.child_care_outlined,
                  size: 100,
                  color: Colors.brown[100],
                ),
                const SizedBox(
                  height: 8,
                ),
                CustomInput(
                  hintText: "nom",
                  controller: nomController,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomInput(
                  hintText: "prenom ",
                  controller: nomCompletController,
                  // iconData: Icons.person,
                  // controller: nomController,
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "entrez votre prenom";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomInput(
                  controller: numeroTelController,

                  hintText: "numero telephone ",

                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "entrez votre numero";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 12,
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
                  height: 12,
                ),
                CustomInput(
                  controller: programmeController,
                  //label: Text("Adress"),
                  hintText: "programme",

                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "entrez votre adress";
                  //   }
                  // },
                ),
                const SizedBox(
                  height: 18,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.brown),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                            horizontal: 28, vertical: 15))),
                    onPressed: () {
                      if (keyForm.currentState!.validate()) {
                        modifieEnfants(context);
                      }
                    },
                    child: const Text(
                      "Modifier",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

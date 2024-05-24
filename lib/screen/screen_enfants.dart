import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';

import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/screen/screen_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ScreenAjoutEnfant extends StatefulWidget {
  const ScreenAjoutEnfant({Key? key}) : super(key: key);

  @override
  _ScreenAjoutEnfantState createState() => _ScreenAjoutEnfantState();
}

class _ScreenAjoutEnfantState extends State<ScreenAjoutEnfant> {
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
  addEnfants(BuildContext context) async {
    try {
      // String fileName = image!.path.split('/').last;
      print('image======================');
      FormData data = FormData.fromMap({
        "photo": MultipartFile.fromBytes(
          homeController!.fileBytes!,
          filename: homeController!.pickedFile!.name,
        ),
        'firstName': nomController!.text.trim(),
        'lastName': nomCompletController!.text.trim(),
        'phone': numeroTelController!.text.trim(),
        'adress': adressController!.text.trim(),
        'category': HomeController.categoryModel!.data!.sId,
        'parent': HomeController.userModel!.data!.sId!,
        'sex': Sevalue,
        'program': programmeController!.text.trim(),
        'birthdate': HomeController.selectedDate.toString(),
        'etablissement': InfoStorage.readId()
      });

      print('test fun----------------------------------------');
      var dio = Dio();
      var response = await dio.request(
        AppApi.listEnfantsUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("l'ajout d'enfant est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ScreenHome()));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("error ajout enfant=======================>$e");
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Ajouter enfants",
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
                  size: 50,
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
                  height: 8,
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
                  height: 8,
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
                InkWell(
                  child: Container(
                      width: MediaQuery.sizeOf(context).width * .9,
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromARGB(
                              255,
                              240,
                              195,
                              178,
                            ),
                          ),
                          top: BorderSide(
                            color: Color.fromARGB(
                              255,
                              240,
                              195,
                              178,
                            ),
                          ),
                          left: BorderSide(
                            color: Color.fromARGB(
                              255,
                              240,
                              195,
                              178,
                            ),
                          ),
                          right: BorderSide(
                            color: Color.fromARGB(
                              255,
                              240,
                              195,
                              178,
                            ),
                          ),
                        ),
                      ),
                      child: Center(
                          child: HomeController.selectedDate.isEmpty
                              ? const Text("Date de naissance")
                              : Text(HomeController.selectedDate.toString()))),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                            height: 250,
                            child: Card(
                                child: SfDateRangePicker(
                              showActionButtons: true,
                              onSubmit: (p0) {
                                print('value=============>$p0');
                                Navigator.pop(context);
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              cancelText: "fermer",
                              confirmText: "confirmer",
                              onSelectionChanged:
                                  (dateRangePickerSelectionChangedArgs) {
                                setState(() {
                                  if (dateRangePickerSelectionChangedArgs.value
                                      is DateTime) {
                                    HomeController.selectedDate =
                                        dateRangePickerSelectionChangedArgs
                                            .value
                                            .toString()
                                            .substring(0, 10);
                                  }
                                });
                              },
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                            )));
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton(
                    hint: const Text("category"),
                    // Initial Value
                    value: HomeController.selectedValue,

                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),

                    // Array list of items
                    items: HomeController.listCategories!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (value) {
                      //controller.gettypebyName(value!);
                      //   print("id=${controller.getTypeModel!.data!.sId}");
                      setState(() {
                        HomeController.selectedValue = value;
                        InfoStorage.saveCatname(value!);
                        HomeController.getCategorieByName();
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton(
                    hint: const Text("parent"),
                    // Initial Value
                    value: HomeController.selectedValue2,

                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),

                    // Array list of items
                    items: HomeController.listParents!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (value) {
                      //controller.gettypebyName(value!);
                      //   print("id=${controller.getTypeModel!.data!.sId}");
                      setState(() {
                        HomeController.selectedValue2 = value;
                        //   InfoStorage.saveCatname(value!);
                        HomeController.getParentByName(value!);
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                DropdownButton(
                    hint: const Text("sexe"),
                    // Initial Value
                    value: Sevalue,

                    // Down Arrow Icon
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                    ),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (value) {
                      //controller.gettypebyName(value!);
                      //   print("id=${controller.getTypeModel!.data!.sId}");
                      setState(() {
                        Sevalue = value;
                      });
                    }),
                const SizedBox(
                  height: 8,
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
                  height: 8,
                ),
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            240,
                            195,
                            178,
                          ),
                        ),
                      ),
                      child: const Text('ajouter un image')),
                  onTap: () {
                    _pickFile();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                homeController!.pickedFile != null &&
                        homeController!.fileBytes != null
                    ? Column(
                        children: [
                          Image.memory(homeController!.fileBytes!),
                          Text(
                              'Picked File: ${homeController!.pickedFile!.name}'),
                        ],
                      )
                    : const SizedBox(),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.brown),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                            horizontal: 28, vertical: 15))),
                    onPressed: () {
                      if (keyForm.currentState!.validate()) {
                        addEnfants(context);
                      }
                    },
                    child: const Text(
                      "Ajouter",
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

import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/models/situation_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateSituationScreen extends StatefulWidget {
  const UpdateSituationScreen({Key? key}) : super(key: key);

  @override
  _UpdateSituationScreenState createState() => _UpdateSituationScreenState();
}

class _UpdateSituationScreenState extends State<UpdateSituationScreen> {
  TextEditingController type = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController treatment = TextEditingController();
  TextEditingController description = TextEditingController();

  HomeController? homeController;
  final dio = Dio();
  SituationModel? situationModel;
  getSituation() async {
    try {
      Response response = await dio
          .get("${AppApi.situationsUrl}${InfoStorage.readIdSituation()}");
      print('responxxxxxxxxxxxse=====================${response.data}');
      if (response.statusCode == 200) {
        situationModel = SituationModel.fromJson(response.data);
        name.text = situationModel!.data!.name!;
        type.text = situationModel!.data!.type!;
        treatment.text = situationModel!.data!.treatment!;
        description.text = situationModel!.data!.description!;
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  @override
  initState() {
    homeController = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getSituation();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });

            //   setState(() {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const ListPresenceEtabliScreen()),
            // );
            //  });
          },
        ),
        title: const Text(
          "Modifie situation",
          style: TextStyle(
              color: Color.fromARGB(255, 240, 195, 178),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text(
                          'Êtes-vous sûr de vouloir supprimer situation ?',
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'fermer',
                              style: TextStyle(
                                color: Color.fromARGB(255, 248, 187, 164),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'supprimer',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 248, 187, 164)),
                            ),
                            onPressed: () {
                              setState(() {
                                homeController!.deleteSituation(context);
                              
                              });
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/mod.png",
                  width: 100,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  validator: (p0) {
                    return null;
                  },
                  controller: type,
                  hintText: "Type",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  validator: (p0) {
                    return null;
                  },
                  controller: name,
                  hintText: "Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  validator: (p0) {
                    return null;
                  },
                  controller: treatment,
                  hintText: "Traitement ",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomInput(
                  validator: (p0) {
                    return null;
                  },
                  controller: description,
                  hintText: "Description",
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.brown),
                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
                            horizontal: 28, vertical: 15))),
                    onPressed: () {
                      setState(() {
                        homeController!.updateSituation(
                          type.text,
                          name.text,
                          treatment.text,
                          description.text,
                          context,
                        );
                        //      Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Modifie",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ]),
        ),
      ),
    );
  }
}

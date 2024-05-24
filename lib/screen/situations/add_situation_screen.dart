import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class AddSituationScreen extends StatefulWidget {
  const AddSituationScreen({Key? key}) : super(key: key);

  @override
  _AddSituationScreenState createState() => _AddSituationScreenState();
}

class _AddSituationScreenState extends State<AddSituationScreen> {
  TextEditingController type = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController treatment = TextEditingController();
  TextEditingController description = TextEditingController();

  HomeController? homeController;

  @override
  initState() {
    homeController = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           
              Navigator.pop(context);
           
          },
        ),
        title: const Text(
          "Ajout situation",
          style: TextStyle(
              color: Color.fromARGB(255, 240, 195, 178),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/add.png",
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
                        homeController!.ajoutSituation(
                          context,
                          type.text,
                          name.text,
                          treatment.text,
                          description.text,
                        );
                        //      Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Ajouter",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ]),
        ),
      ),
    );
  }
}

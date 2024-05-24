import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/screen/categories/list_category_screen.dart';
import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  TextEditingController statut = TextEditingController();
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
            setState(() {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ListCategoryScreen()),
              );
            });
          },
        ),
        title: const Text(
          "Ajout categorie",
          style: TextStyle(
              color: Color.fromARGB(255, 240, 195, 178),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cat.jpg",
                width: 200,
                height: 300,
              ),
              SizedBox(
                width: 200,
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInput(
                      validator: (p0) {
                        return null;
                      },
                      controller: statut,
                      hintText: "name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.brown),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 28, vertical: 15))),
                  onPressed: () {
                    setState(() {
                      homeController!.ajoutCategory(
                        context,
                        statut.text,
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
    );
  }
}

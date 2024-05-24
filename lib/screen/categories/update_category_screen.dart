import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/screen/categories/list_category_screen.dart';
import 'package:flutter/material.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({Key? key}) : super(key: key);

  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  HomeController? homeController = HomeController();
  TextEditingController st = TextEditingController();

  @override
  Widget build(BuildContext context) {
    homeController!.getCategory();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //   setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ListCategoryScreen()),
            );
            //  });
          },
        ),
        title: const Text(
          "Modifie Categorie",
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
                      controller: HomeController.name,
                      hintText: "${InfoStorage.readCat()}",
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
                      homeController!
                          .updateCategory(HomeController.name.text, context);
                      //      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Modiife",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ]),
      ),
    );
  }
}

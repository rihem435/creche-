import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/screen/categories/add_category_screen.dart';
import 'package:creche/screen/categories/update_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListCategoryScreen extends StatefulWidget {
  const ListCategoryScreen({Key? key}) : super(key: key);

  @override
  _ListCategoryScreenState createState() => _ListCategoryScreenState();
}

class _ListCategoryScreenState extends State<ListCategoryScreen> {
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
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Liste des categories",
        ),
        actions: [
          ElevatedButton(
            style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 240, 195, 178)),
                padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 28, vertical: 15))),
            onPressed: () {
              print('zssssssssss');
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AddCategoryScreen(),
              ));
            },
            child: const Text(
              'Ajouter',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: homeController!.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: homeController!.allCategoryModel!.data!.length,
                  itemBuilder: (context, index) => InkWell(
                    child: Slidable(
                      //  controller: controller,
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(1),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: (context) {
                              InfoStorage.saveIdCategory(homeController!
                                  .allCategoryModel!.data![index].sId);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                        'Êtes-vous sûr de vouloir supprimer cet categorie ?',
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
                                              color: Color.fromARGB(
                                                  255, 248, 187, 164),
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
                                                color: Color.fromARGB(
                                                    255, 248, 187, 164)),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              homeController!
                                                  .deleteCategory(context);
                                              //   Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            backgroundColor:
                                const Color.fromARGB(255, 243, 202, 187),
                            foregroundColor: Colors.red,
                            icon: Icons.delete,
                            label: 'Supprimer',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListTile(
                          shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 240, 195, 178)),
                          ),
                          title: Text.rich(TextSpan(
                              text: "Name:",
                              style: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      " ${homeController!.allCategoryModel!.data![index].name} ",
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ])),
                          horizontalTitleGap: 12,
                        ),
                      ),
                    ),
                    onTap: () {
                      InfoStorage.saveIdPresence(
                          homeController!.allCategoryModel!.data![index].sId);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UpdateCategoryScreen(),
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.data!.data!.isEmpty) {
                return Center(
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset("assets/images/pas_donnee.png"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("aucune donnée à venir"),
                      ],
                    ),
                  ),
                );
              }
              // we have the data, do stuff here
            }
            return const SizedBox();
          },
        ),
      ),
      //   bottomNavigationBar: const CustomBottomNavigationBar()
    );
  }
}

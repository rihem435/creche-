import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:creche/core/widgets/custom_drawer.dart';
import 'package:creche/screen/children/list_presence_etabli_screen.dart';
import 'package:creche/screen/screen_enfants.dart';
import 'package:creche/screen/screen_update_enfant.dart';
import 'package:creche/screen/situations/add_situation_screen.dart';
import 'package:creche/screen/situations/update_situation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {

  @override
  initState() {
    homeController = HomeController();
    homeController!.getCategories();
    HomeController.getParentByRole("Parent");
    super.initState();
  }
  HomeController? homeController;
  @override
  Widget build(BuildContext context) {
    print("testdaa========================>${homeController!.testData}");
    doNothing(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(
                'Message Here',
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          title: const Text(
            "Mes enfants",
          ),
          actions: [
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 240, 195, 178)),
                  padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 15))),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ScreenAjoutEnfant(),
                  ),
                );
              },
              child: const Text(
                'Ajouter',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder(
            future: homeController!.getListEnfants(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: homeController!.listEnfantsModel!.data!.length,
                  itemBuilder: (context, index) => Slidable(
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
                            InfoStorage.saveIdEnfants(homeController!
                                .listEnfantsModel!.data![index].sId);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: const Text(
                                      'Êtes-vous sûr de vouloir supprimer cet enfant ?',
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
                                                .deleteEnfant(context);
                                            Navigator.of(context).pop();
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
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 240, 195, 178),
                            ),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  maxRadius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(255, 240, 195, 178),
                                  child: Text(
                                    "${homeController!.listEnfantsModel!.data![index].firstName![0].toUpperCase()}${homeController!.listEnfantsModel!.data![index].lastName![0].toUpperCase()} ",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                title: Text.rich(TextSpan(
                                    text: "Nom et Prenom:",
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " ${homeController!.listEnfantsModel!.data![index].firstName!} ${homeController!.listEnfantsModel!.data![index].lastName!}",
                                        style: const TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ])),
                                subtitle: Text.rich(
                                  TextSpan(
                                    text: "Numero utiles:",
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " ${homeController!.listEnfantsModel!.data![index].phone!}",
                                        style: const TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: InkWell(
                                  onTap: () {
                                    InfoStorage.saveIdEnfants(homeController!
                                        .listEnfantsModel!.data![index].sId);
                                    //      HomeController.selectedDate = "";
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ListPresenceEtabliScreen(),
                                    ));
                                  },
                                  child: Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey[200]),
                                      child: const Text(
                                        'Presences',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    InfoStorage.saveIdEnfants(homeController!
                                        .listEnfantsModel!.data![index].sId);
                                    if (homeController!.listEnfantsModel!
                                        .data![index].situations!.isNotEmpty) {
                                      InfoStorage.saveIdSituation(
                                          homeController!.listEnfantsModel!
                                              .data![index].situations![0]);
                                    }
                                    //      HomeController.selectedDate = "";
                                    homeController!.listEnfantsModel!
                                            .data![index].situations!.isNotEmpty
                                        ? Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const UpdateSituationScreen(),
                                          ))
                                        : Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) =>
                                                const AddSituationScreen(),
                                          ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        right: 12.0, bottom: 8),
                                    child: homeController!.listEnfantsModel!
                                            .data![index].situations!.isNotEmpty
                                        ? Image.asset(
                                            "assets/images/mod.png",
                                            width: 40,
                                          )
                                        : Image.asset(
                                            "assets/images/add.png",
                                            width: 40,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('xxxxxxxxxxxxxxxxxxxx');
                          InfoStorage.saveIdEnfants(
                              "${homeController!.listEnfantsModel!.data![index].sId}");
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenUpdateEnfant(),
                          ));
                        },
                      ),
                    ),
                  ),
                );

                // we have the data, do stuff here
              } else if (homeController!.testData) {
                print("error-------------------");
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
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}

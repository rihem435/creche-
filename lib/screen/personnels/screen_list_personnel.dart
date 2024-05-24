import 'package:creche/controllers/personnel_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:creche/core/widgets/custom_drawer.dart';
import 'package:creche/screen/personnels/screen_ajout_personnel.dart';
import 'package:creche/screen/personnels/screen_update_personnel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ScreenListPersonnel extends StatefulWidget {
  const ScreenListPersonnel({Key? key}) : super(key: key);

  @override
  _ScreenListPersonnelState createState() => _ScreenListPersonnelState();
}

class _ScreenListPersonnelState extends State<ScreenListPersonnel> {
  PersonnelController? personnelController;
  int currentIndex = 0;

  @override
  initState() {
    personnelController = PersonnelController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[50],
          title: const Text(
            "Mes personnels",
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
                    builder: (context) => const ScreenAjoutPersonnel(),
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
            future: personnelController!.getListPersonnels(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount:
                        personnelController!.listPersonnelModel!.data!.length,
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
                              SlidableAction(
                                onPressed: (context) {
                                  InfoStorage.saveIdEnfants(personnelController!
                                      .listPersonnelModel!.data![index].sId);
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: const Text(
                                            'Êtes-vous sûr de vouloir supprimer cet personnel ?',
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
                                                  personnelController!
                                                      .deletePersonnel(context);
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

                              // A SlidableAction can have an icon and/or a label.
                            ],
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GestureDetector(
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(8),
                                  shape: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 240, 195, 178)),
                                  ),
                                  leading: CircleAvatar(
                                    maxRadius: 25,
                                    backgroundColor: const Color.fromARGB(
                                        255, 240, 195, 178),
                                    child: Text(
                                      "${personnelController!.listPersonnelModel!.data![index].firstName![0].toUpperCase()}${personnelController!.listPersonnelModel!.data![index].lastName![0].toUpperCase()} ",
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  title: Text.rich(TextSpan(
                                      text: "Nom et Prenom :",
                                      style: const TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "\t${personnelController!.listPersonnelModel!.data![index].firstName!} ${personnelController!.listPersonnelModel!.data![index].lastName!}",
                                          style: const TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        )
                                      ])),
                                  subtitle: Text.rich(
                                    TextSpan(
                                      text: "Numero utiles :",
                                      style: const TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              "\t${personnelController!.listPersonnelModel!.data![index].phone!}",
                                          style: const TextStyle(
                                            color: Colors.brown,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  print('-----------------------update');
                                  InfoStorage.saveIdPersonnel(
                                      personnelController!.listPersonnelModel!
                                          .data![index].sId);
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenUpdatePersonnel(),
                                  ));
                                }),
                          ),
                        ));
              } else if (personnelController!.testData) {
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

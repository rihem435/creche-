import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_drawer.dart';
import 'package:creche/screen/chat/chat_screen.dart';
import 'package:creche/screen/parents/add_parents_screen.dart';
import 'package:creche/screen/parents/update_parent_screen.dart';
import 'package:creche/screen/screen_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListParentsScreen extends StatefulWidget {
  const ListParentsScreen({Key? key}) : super(key: key);

  @override
  _ListParentsScreenState createState() => _ListParentsScreenState();
}

class _ListParentsScreenState extends State<ListParentsScreen> {
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //   setState(() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ));
            //  });
          },
        ),
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Mes Parents",
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
                  builder: (context) => const AddParentsScreen(),
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
          future: homeController!.getListParents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (homeController!.listParentModel!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount: homeController!.listParentModel!.data!.length,
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
                                .listParentModel!.data![index].sId);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: const Text(
                                      'Êtes-vous sûr de vouloir supprimer cet parent ?',
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
                                            InfoStorage.saveIdParent(
                                                homeController!.listParentModel!
                                                    .data![index].sId);
                                            homeController!
                                                .deleteParent(context);
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
                                    "${homeController!.listParentModel!.data![index].fullName![0].toUpperCase()}${homeController!.listParentModel!.data![index].userName![0].toUpperCase()} ",
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
                                            " ${homeController!.listParentModel!.data![index].fullName!} ${homeController!.listParentModel!.data![index].userName!}",
                                        style: const TextStyle(
                                          color: Colors.brown,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      )
                                    ])),
                                subtitle: Text.rich(
                                  TextSpan(
                                    text: "Numero teephone:",
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            " ${homeController!.listParentModel!.data![index].phone!}",
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
                                    InfoStorage.saveIdParent(homeController!
                                        .listParentModel!.data![index].sId);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                        title:
                                            "${homeController!.listParentModel!.data![index].fullName} ${homeController!.listParentModel!.data![index].userName}",
                                      ),
                                    ));
                                  },
                                  child: const Expanded(
                                      child: Icon(
                                    Icons.message_outlined,
                                    color: Color.fromARGB(255, 240, 195, 178),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          print('xxxxxxxxxxxxxxxxxxxx');
                          InfoStorage.saveIdParent(homeController!
                              .listParentModel!.data![index].sId);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateParentScreen(),
                          ));
                        },
                      ),
                    ),
                  ),
                );
              } else if (homeController!.listParentModel!.data!.isEmpty) {
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
              // we have the data, do stuff here
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      //bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

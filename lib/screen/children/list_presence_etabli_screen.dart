import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/screen/children/add_presence_screen.dart';
import 'package:creche/screen/children/update_presence_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListPresenceEtabliScreen extends StatefulWidget {
  const ListPresenceEtabliScreen({Key? key}) : super(key: key);

  @override
  _ListPresenceEtabliScreenState createState() =>
      _ListPresenceEtabliScreenState();
}

class _ListPresenceEtabliScreenState extends State<ListPresenceEtabliScreen> {
  HomeController? homeController;

  @override
  initState() {
    homeController = HomeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    homeController!.getEnfant(context);
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
          "Liste de presences",
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
                builder: (context) => const AddPresenceScreen(),
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
          future: homeController!.getListPresencesByChild(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                return ListView.builder(
                  itemCount:
                      homeController!.presencesByChildModel!.data!.length,
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
                              InfoStorage.saveIdPresence(homeController!
                                  .presencesByChildModel!.data![index].sId);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: const Text(
                                        'Êtes-vous sûr de vouloir supprimer cet element ?',
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
                                                  .deletePresence(context);
                                              // Navigator.of(context).pop();
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
                          leading: CircleAvatar(
                            maxRadius: 40,
                            child: Image.network(
                              "${AppApi.imageChildrenUrl}${homeController!.childModel!.data!.photo}",
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
                                      " ${homeController!.childModel!.data!.firstName!} ${homeController!.childModel!.data!.lastName!}",
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ])),
                          subtitle: Text.rich(
                            TextSpan(
                              text: "Temps :",
                              style: const TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      " ${homeController!.presencesByChildModel!.data![index].time!}",
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200]),
                            child: Text(
                              homeController!
                                  .presencesByChildModel!.data![index].status!,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                            ),
                          ),
                          horizontalTitleGap: 12,
                        ),
                      ),
                    ),
                    onTap: () {
                      InfoStorage.saveIdPresence(homeController!
                          .presencesByChildModel!.data![index].sId);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UpdatePresenceScreen(),
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
            return const SizedBox(
              child: Text("dedddd"),
            );
          },
        ),
      ),
      //   bottomNavigationBar: const CustomBottomNavigationBar()
    );
  }
}

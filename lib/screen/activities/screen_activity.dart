import 'package:creche/controllers/activity_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:creche/core/widgets/custom_drawer.dart';
import 'package:creche/screen/activities/screen_modifie_activity.dart';
import 'package:creche/screen/activities/screen_ajout_activity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenActivity extends StatefulWidget {
  const ScreenActivity({Key? key}) : super(key: key);

  @override
  _ScreenActivityState createState() => _ScreenActivityState();
}

class _ScreenActivityState extends State<ScreenActivity> {
  var dio = Dio();
  String url = "";
  int currentIndex = 0;

  ActivityController activityController = ActivityController();
  @override
  Widget build(BuildContext context) {
    activityController.getListActivity();
    //getImg();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          // leading: const Icon(
          //   Icons.event_sharp,
          //   color: Colors.brown,
          // ),
          title: const Text(
            "Les activités",
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
                    builder: (context) => const ScreenAjoutActivity(),
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
        body: FutureBuilder(
          future: activityController.getActivity(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: activityController.activityModel?.data!.length,
                  itemBuilder: (context, index) => 
                  Slidable(
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
                                InfoStorage.saveIdEnfants(activityController
                                    .listActivityModel!.data![index].sId);
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text(
                                          'Êtes-vous sûr de vouloir supprimer cet activitee ?',
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
                                                activityController
                                                    .deleteActivity(context);
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
                        child: GestureDetector(
                          onTap: () {
                            InfoStorage.saveIdEnfants(activityController
                                .listActivityModel!.data![index].sId);
                            //   activityController.getActivityById();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ScreenModifieActivity(),
                            ));
                          },
                          child: Card(
                            semanticContainer: true,
                            margin: const EdgeInsets.all(10),
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                // Image.asset("assets/images/activity.jpg", height: 100),
                                Expanded(
                                  child: Image.network(
                                    "${AppApi.imageActivitieUrl}${activityController.activityModel!.data![index].photo}",
                                    height: 200,
                                    width: 150,
                                  ),
                                ),

                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                        text:
                                            " ${activityController.activityModel!.data![index].title}\n",
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            text:
                                                "\t${activityController.activityModel!.data![index].description}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w300),
                                          ),
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      
                      
                      );
            } else if (activityController.testData) {
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
        bottomNavigationBar: const CustomBottomNavigationBar());
  }
}

import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_drawer.dart';
import 'package:creche/screen/children/list_presence_screen.dart';
import 'package:flutter/material.dart';

class ChildrenScreenParent extends StatefulWidget {
  const ChildrenScreenParent({Key? key}) : super(key: key);

  @override
  _ChildrenScreenParentState createState() => _ChildrenScreenParentState();
}

class _ChildrenScreenParentState extends State<ChildrenScreenParent> {
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
        title: const Text(
          "Mes enfants",
        ),
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: homeController!.getListEnfantsByParents(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: homeController!.listEnfantsModel!.data!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 240, 195, 178)),
                    ),
                    leading: CircleAvatar(
                      maxRadius: 40,
                      child: Image.network(
                        "${AppApi.imageChildrenUrl}${homeController!.listEnfantsModel!.data![index].photo}",
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
                                " ${homeController!.listEnfantsModel!.data![index].firstName!} ${homeController!.listEnfantsModel!.data![index].lastName!}",
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
                        InfoStorage.saveIdEnfants(
                            homeController!.listEnfantsModel!.data![index].sId);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ListPresenceScreen(),
                        ));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[200]),
                        child: const Text(
                          'Presences',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                    horizontalTitleGap: 12,
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
      //   bottomNavigationBar: const CustomBottomNavigationBar()
    );
  }
}

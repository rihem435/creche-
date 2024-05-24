import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:flutter/material.dart';

class ListPresenceScreen extends StatefulWidget {
  const ListPresenceScreen({Key? key}) : super(key: key);

  @override
  _ListPresenceScreenState createState() => _ListPresenceScreenState();
}

class _ListPresenceScreenState extends State<ListPresenceScreen> {
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
                  itemBuilder: (context, index) => Padding(
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

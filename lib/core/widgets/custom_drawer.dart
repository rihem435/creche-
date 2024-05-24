import 'package:creche/controllers/profile_controller.dart';
import 'package:creche/screen/categories/list_category_screen.dart';
import 'package:creche/screen/chat/chat_screen.dart';
import 'package:creche/screen/parents/list_parents_screen.dart';
import 'package:flutter/material.dart';
import '../../screen/profile/screen_update_profile.dart';
import '../storage/info_storage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = ProfileController();
    return Drawer(
      child: ListView(
        //    padding: const EdgeInsets.all(10),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 240, 195, 178),
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.grey),
              accountName: Text(
                "${InfoStorage.readName()}",
                style: const TextStyle(fontSize: 18),
              ),
              accountEmail: Text("${InfoStorage.readEmail()}"),
              currentAccountPictureSize: const Size.square(50),
            ), //UserAccountDrawerHeader
          ), //DrawerHeader
          InfoStorage.readRole() == "Parent"
              ? ListTile(
                  leading: const Icon(Icons.message),
                  title: const Text('Contact Creche'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ChatScreen(title: "My Creche"),
                    ));
                  },
                )
              : const SizedBox.shrink(),
          InfoStorage.readRole() == "Establishment"
              ? ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text('Liste des categories '),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ListCategoryScreen(),
                    ));
                  },
                )
              : const SizedBox.shrink(),
          InfoStorage.readRole() == "Establishment"
              ? ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' Liste des parents '),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ListParentsScreen(),
                      ),
                    );
                  },
                )
              : const SizedBox.shrink(),
          InfoStorage.readRole() == "Establishment"
              ? ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text(' Edit Profile '),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenUpdateProfile(),
                      ),
                    );
                  },
                )
              : const SizedBox.shrink(),
          const SizedBox(
            height: 300,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              //padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8,
                ),
                color: const Color.fromARGB(255, 240, 195, 178),
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  'LogOut',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text(
                          'Êtes-vous sûr de vouloir vous déconnecter ?',
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text(
                              'Annuler',
                              style: TextStyle(
                                color: Color.fromARGB(255, 248, 187, 164),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Fermer le AlertDialog
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Déconnexion',
                              style: TextStyle(
                                color: Color.fromARGB(255, 248, 187, 164),
                              ),
                            ),
                            onPressed: () {
                              profileController.logOut(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

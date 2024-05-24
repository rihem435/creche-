import 'package:creche/screen/parents/list_parents_screen.dart';
import 'package:creche/screen/personnels/screen_list_personnel.dart';
import 'package:flutter/material.dart';

import '../../screen/activities/screen_activity.dart';
import '../../screen/screen_home.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.child_care,
          ),
          label: "enfants",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.event_sharp,
          ),
          label: "activities",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_2_outlined,
          ),
          label: "personnels",
        ),
      ],
      currentIndex: currentIndex,
      fixedColor: Colors.grey,
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      onTap: (value) {
        setState(() {
          currentIndex = value;
          switch (value) {
            case 0:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
              );
              break;
            case 1:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScreenActivity(),
                ),
              );
              break;
            case 2:
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ScreenListPersonnel(),
                ),
              );
          }
        });
      },
    );
  }
}

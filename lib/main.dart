import 'package:creche/screen/get_started_screen.dart';
import 'package:creche/screen/personnels/screen_list_personnel.dart';
import 'package:creche/screen/activities/screen_activity.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(DevicePreview(
      enabled: !kReleaseMode, builder: (context) => const MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => const GetStartedScreen(),
        "/listPersonnels": (context) => const ScreenListPersonnel(),
        "/listActivities": (context) => const ScreenActivity()
      },
    );
  }
}

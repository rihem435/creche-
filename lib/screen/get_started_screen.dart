import 'package:creche/screen/acceuil_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Donner vie à votre \nnouvelle app",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              "assets/images/creche.png",
              // width: 145,
              // height: 145,
            ),
            const SizedBox(
              height: 18,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.brown),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AcceuilScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "Je m'inscris",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

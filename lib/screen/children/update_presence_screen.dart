import 'package:creche/controllers/home_controller.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/screen/children/list_presence_etabli_screen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class UpdatePresenceScreen extends StatefulWidget {
  const UpdatePresenceScreen({Key? key}) : super(key: key);

  @override
  _UpdatePresenceScreenState createState() => _UpdatePresenceScreenState();
}

class _UpdatePresenceScreenState extends State<UpdatePresenceScreen> {
  HomeController? homeController = HomeController();
  TextEditingController st = TextEditingController();

  @override
  Widget build(BuildContext context) {
    homeController!.getPresence();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[50],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            //   setState(() {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ListPresenceEtabliScreen()),
            );
            //  });
          },
        ),
        title: const Text(
          "Modifie Presence",
          style: TextStyle(
              color: Color.fromARGB(255, 240, 195, 178),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/presence.png",
                width: 200,
                height: 300,
              ),
              SizedBox(
                width: 200,
                height: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    CustomInput(
                      validator: (p0) {
                        return null;
                      },
                      controller: HomeController.statut,
                      hintText: "${InfoStorage.readStatus()}",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                          width: MediaQuery.sizeOf(context).width * .9,
                          height: 30,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              ),
                              top: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              ),
                              left: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              ),
                              right: BorderSide(
                                color: Color.fromARGB(
                                  255,
                                  240,
                                  195,
                                  178,
                                ),
                              ),
                            ),
                          ),
                          child: Center(
                              child: HomeController.selectedDate.isEmpty
                                  ? Text(InfoStorage.readTime().toString())
                                  : Text(
                                      HomeController.selectedDate.toString()))),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                                height: 250,
                                child: Card(
                                    child: SfDateRangePicker(
                                  showActionButtons: true,
                                  onSubmit: (p0) {
                                    print('value=============>$p0');
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                  cancelText: "fermer",
                                  confirmText: "confirmer",
                                  onSelectionChanged:
                                      (dateRangePickerSelectionChangedArgs) {
                                    setState(() {
                                      if (dateRangePickerSelectionChangedArgs
                                          .value is DateTime) {
                                        HomeController.selectedDate =
                                            dateRangePickerSelectionChangedArgs
                                                .value
                                                .toString()
                                                .substring(0, 10);
                                      }
                                    });
                                  },
                                  selectionMode:
                                      DateRangePickerSelectionMode.single,
                                )));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.brown),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 28, vertical: 15))),
                  onPressed: () {
                    setState(() {
                      homeController!.updatePresence(HomeController.statut.text,
                          HomeController.selectedDate.toString(), context);
                      //      Navigator.pop(context);
                    });
                  },
                  child: const Text(
                    "Modiife",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ]),
      ),
    );
  }
}

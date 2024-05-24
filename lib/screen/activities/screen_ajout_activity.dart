import 'dart:html';
import 'dart:typed_data';

import 'package:creche/controllers/activity_controller.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class ScreenAjoutActivity extends StatefulWidget {
  const ScreenAjoutActivity({Key? key}) : super(key: key);

  @override
  _ScreenAjoutActivityState createState() => _ScreenAjoutActivityState();
}

class _ScreenAjoutActivityState extends State<ScreenAjoutActivity> {
  final ImagePicker _picker = ImagePicker();
  List<XFile>? _mediaFileList;
  dynamic _pickImageError;
  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMedia = false,
  }) async {
    if (context.mounted) {
      if (isMedia) {
        try {
          final List<XFile> pickedFileList = <XFile>[];
          final XFile? media = await _picker.pickMedia();
          if (media != null) {
            pickedFileList.add(media);
            setState(() {
              _mediaFileList = pickedFileList;
            });
          }
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      } else {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
          );
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      }
    }
  }

  String? tempPath;
  List<File> images = [];
  void _pickFile() {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((event) {
      final files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((event) {
          setState(() {
            activityController.pickedFile = files[0];
            activityController.fileBytes = reader.result as Uint8List?;
          });
        });
      }
    });
  }

  ActivityController activityController = ActivityController();
  final keyForm = GlobalKey<FormState>();
  String img = "ajouter un image";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/listActivities");
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        backgroundColor: Colors.brown[50],
        title: const Text(
          "Ajouter activitie",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Icon(
                    Icons.event_sharp,
                    size: 100,
                    color: Colors.brown[100],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    hintText: "titre",
                    controller: activityController.titreController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez titre";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    hintText: "description ",
                    // iconData: Icons.person,
                    controller: activityController.descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez description";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CustomInput(
                    controller: activityController.dureeController,
                    hintText: "durée",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "entrez durée";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(
                              255,
                              240,
                              195,
                              178,
                            ),
                          ),
                        ),
                        child: const Text('ajouter un image')),
                    onTap: () {
                      _pickFile();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  activityController.pickedFile != null &&
                          activityController.fileBytes != null
                      ? Column(
                          children: [
                            Image.memory(activityController.fileBytes!),
                            Text(
                                'Picked File: ${activityController.pickedFile!.name}'),
                          ],
                        )
                      : const SizedBox(),
                  ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.brown),
                        padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                        ),
                      ),
                      onPressed: () {
                        if (keyForm.currentState!.validate()) {
                          print(
                              '------------------------------btn----------------------');
                          activityController.addActivity(context);
                        }
                      },
                      child: const Text(
                        "Ajouter",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:creche/controllers/activity_controller.dart';
import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/core/widgets/custom_input.dart';
import 'package:creche/models/activity_model.dart';
import 'package:creche/screen/activities/screen_activity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:html' as html;

class ScreenModifieActivity extends StatefulWidget {
  const ScreenModifieActivity({Key? key}) : super(key: key);

  @override
  _ScreenModifieActivityState createState() => _ScreenModifieActivityState();
}

class _ScreenModifieActivityState extends State<ScreenModifieActivity> {
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
  final dio = Dio();
  String img = "ajouter un image";
  ActivityModel? activityModelById;

  getActivityById() async {
    print('------------------------------by id--------------------------');
    try {
      Response response = await dio.request(
        "${AppApi.activitiesUrl}${InfoStorage.readIdEnfant()}",
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print(" activity-----------------------------------------");
        print(json.encode(response.data));
        activityModelById = ActivityModel.fromJson(response.data);
        activityController.titreController.text =
            activityModelById!.data!.title!;
        activityController.descriptionController.text =
            activityModelById!.data!.description!;
        activityController.dureeController.text =
            activityModelById!.data!.duration!;
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      print('error=========================>$error');
    }
  }

  updateActivity(BuildContext context) async {
    try {
      // String fileName = image!.path.split('/').last;
      print('image======================');

      Map<String, dynamic> data = {
        'title': activityController.titreController.text.trim(),
        'description': activityController.descriptionController.text.trim(),
        'duration': activityController.dureeController.text.trim()
      };

      print('test fun----------------------------------------');
      var dio = Dio();
      var response = await dio.request(
        "${AppApi.activitiesUrl}${InfoStorage.readIdEnfant()}",
        options: Options(
          method: "PATCH",
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("modification d'activite est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ScreenActivity()));
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print("error=======================>$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    getActivityById();
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
          "Modifier activitie",
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
                  const SizedBox(
                    height: 15,
                  ),
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
                          updateActivity(context);
                        }
                      },
                      child: const Text(
                        "Modifier",
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

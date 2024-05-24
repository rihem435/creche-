import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/models/activity_model.dart';
import 'package:creche/models/list_activity_model.dart';
import 'package:creche/screen/activities/screen_activity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:image_picker/image_picker.dart';

class ActivityController {
  static final dio = Dio();
  TextEditingController titreController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dureeController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  ListActivityModel? activityModel;
  ListActivityModel? listActivityModel;
  Future<ListActivityModel?> getActivity(BuildContext context) async {
    print('------cd-----------------get activities-----------------------');
    try {
      final response = await dio.get(AppApi.activitiesUrl);

      print('value categories ===================================> $response');
      activityModel = ListActivityModel.fromJson(response.data);
      print('-------------------list activities-------------$activityModel');
      return activityModel;
    } catch (error) {
      print('error===========>$error');
    }
    return null;
  }

  XFile? image;
  html.File? pickedFile;
  Uint8List? fileBytes;

  addActivity(BuildContext context) async {
    try {
      // String fileName = image!.path.split('/').last;
      print('image======================');
      FormData data = FormData.fromMap({
        "photo": MultipartFile.fromBytes(
          fileBytes!,
          filename: pickedFile!.name,
        ),
        'title': titreController.text.trim(),
        'description': descriptionController.text.trim(),
        'duration': dureeController.text.trim()
      });

      print('test fun----------------------------------------');
      var dio = Dio();
      var response = await dio.request(
        AppApi.activitiesUrl,
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 201) {
        print(json.encode(response.data));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("l'ajout d'activite est réussie"),
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

 
  bool testData = false;
  ActivityModel? activityModelById;

  getListActivity() async {
    try {
      Response response = await dio.request(
        AppApi.activitiesUrl,
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print("list activity-----------------------------------------");
        print(json.encode(response.data));
        listActivityModel = ListActivityModel.fromJson(response.data);
      } else {
        print(response.statusMessage);
      }
    } catch (error) {
      testData = true;
      print('error=========================>$error');
    }
  }

  deleteActivity(BuildContext context) async {
    print('-----------------------delete activitiy-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.activitiesUrl}${InfoStorage.readIdEnfant()}");

      print('value activity ===================================> $response');
      Navigator.of(context).pop();
    } catch (error) {
      print('error===========>$error');
    }
  }
}

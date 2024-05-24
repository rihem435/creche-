import 'package:creche/models/list_personnel_model.dart';
import 'package:creche/models/personnel_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../core/networking/app_api.dart';
import '../core/storage/info_storage.dart';

class PersonnelController {
  final dio = Dio();
  ListPersonnelModel? listPersonnelModel;
  bool testData = false;

  Future<ListPersonnelModel?> getListPersonnels(BuildContext context) async {
    try {
      Response response = await dio.get(AppApi.personnelUrl);

      print('value ===================> $response');
      if (response.statusCode == 200) {
        return listPersonnelModel = ListPersonnelModel.fromJson(response.data);
      }
      return null;
    } catch (error) {
      testData = true;

      print('error===========>$error');
    }
    return null;
  }

  static TextEditingController nomController = TextEditingController();
  static TextEditingController adressController = TextEditingController();
  static TextEditingController nomCompletController = TextEditingController();
  static TextEditingController numeroTelController = TextEditingController();
  static TextEditingController cinController = TextEditingController();
  PersonnelModel? personnelModel;
 
  getPersonnel() async {
    print(
        'get personnel------------------------------------------${AppApi.personnelUrl}${InfoStorage.readIpPersonnel()}');
    try {
      Response response = await dio
          .get("${AppApi.personnelUrl}${InfoStorage.readIpPersonnel()}");
      if (response.statusCode == 200) {
        personnelModel = PersonnelModel.fromJson(response.data);
        print('succes=======================${personnelModel!.data}');
        nomController.text = personnelModel!.data!.firstName!;
        adressController.text = personnelModel!.data!.adress!;
        nomCompletController.text = personnelModel!.data!.lastName!;
        numeroTelController.text = personnelModel!.data!.phone!.toString();
        cinController.text = personnelModel!.data!.cin!.toString();
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  updatePersonnel(String nom, String numeroTel, String adress, String cin,
      String userName, BuildContext context) {
    Map<String, dynamic> data = {
      "firstName": nom,
      "cin": cin,
      "phone": numeroTel,
      "adress": adress,
      "lastName": userName
    };
    dio
        .patch("${AppApi.personnelUrl}${InfoStorage.readIpPersonnel()}",
            data: data)
        .then(
      (value) {
        print('value ===================> $value');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("la modification est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  deletePersonnel(BuildContext context) async {
    print('-----------------------delete personnel-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.personnelUrl}${InfoStorage.readIdEnfant()}");

      print('value personnel ===================================> $response');
      Navigator.of(context).pop();
    } catch (error) {
      print('error===========>$error');
    }
  }



}

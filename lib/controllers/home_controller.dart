import 'dart:html' as html;
import 'dart:typed_data';

import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/models/all_parents_model.dart';
import 'package:creche/models/catecories_model.dart';
import 'package:creche/models/categories/all_category_model.dart';
import 'package:creche/models/category_model.dart';
import 'package:creche/models/child_model.dart';
import 'package:creche/models/list_enfants_model.dart';
import 'package:creche/models/presences/presence_model.dart';
import 'package:creche/models/presences/presences_by_child_model.dart';
import 'package:creche/models/user_model.dart';
import 'package:creche/screen/screen_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeController {
  final dio = Dio();
  ListEnfantsModel? listEnfantsModel;
  bool testData = false;
  Future<ListEnfantsModel?> getListEnfants(BuildContext context) async {
    try {
      Response response =
          await dio.get("${AppApi.listEnfantsUrlByE}${InfoStorage.readId()}");

      print('value ===================> $response');
      if (response.statusCode == 200) {
        listEnfantsModel = ListEnfantsModel.fromJson(response.data);
        if (listEnfantsModel!.data!.isNotEmpty) {
          InfoStorage.saveIdParent(listEnfantsModel!.data![0].etablissement);
        }
        return listEnfantsModel;
      }
      return null;
    } catch (error) {
      testData = true;
      print('error===========>$error');
    }
    return null;
  }

  deleteEnfant(BuildContext context) async {
    print('-----------------------delete enfant-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.listEnfantsUrl}${InfoStorage.readIdEnfant()}");

      print('value enfant ===================================> $response');
    } catch (error) {
      print('error===========>$error');
    }
  }

  deleteParent(BuildContext context) async {
    print('-----------------------delete parent-----------------------');
    try {
      await dio.delete("${AppApi.signUpUrl}${InfoStorage.readIdParent()}");
    } catch (error) {
      print('error===========>$error');
    }
  }

  static Dio dio_ = Dio();
  static String? selectedValue;
  static String? selectedValue2;

  static List<String>? listCategories;
  static List<String>? listParents;

  static CategoriesModel? categoriesModel;
  Future<CategoriesModel?> getCategories() async {
    print('-----------------------get categories-----------------------');
    try {
      final response = await dio_.get(AppApi.categoriesUrl);

      print('value categories ===================================> $response');
      categoriesModel = CategoriesModel.fromJson(response.data);
      allCategoryModel = AllCategoryModel.fromJson(response.data);
      listCategories = categoriesModel!.getCategoryNames();
      print('-------------------list categories-------------$listCategories');
      return categoriesModel;
    } catch (error) {
      print('error===========>$error');
    }
    return null;
  }

  static String selectedDate = '';
  static CategoryModel? categoryModel;
  static getCategorieByName() async {
    print('-----------------------get categories-----------------------');
    try {
      final response =
          await dio_.get("${AppApi.categoriesUrl}${InfoStorage.readCatName()}");

      print('value categories ===================================> $response');
      categoryModel = CategoryModel.fromJson(response.data);
    } catch (error) {
      print('error cat by name===========>$error');
    }
  }

  html.File? pickedFile;
  Uint8List? fileBytes;
  static UserModel? userModel;
  static getParentByName(String name) async {
    Map<String, dynamic> data = {"userName": name};
    print('-----------------------get parents by name-----------------------');
    try {
      final response =
          await dio_.get(AppApi.parentByNameUrl, queryParameters: data);

      print(
          'value parents name ===================================> $response');
      userModel = UserModel.fromJson(response.data);
    } catch (error) {
      print('error parents by name===========>$error');
    }
  }

  static AllParentModel? allParentModel;
  static getParentByRole(String role) async {
    print('-----------------------get parents-----------------------');
    Map<String, dynamic> data = {"role": role};
    try {
      final response =
          await dio_.get(AppApi.allParentsUrl, queryParameters: data);

      print('value parents ===================================> $response');
      allParentModel = AllParentModel.fromJson(response.data);
      listParents = allParentModel!.getParentsNames();

      print('length========================${allParentModel!.data!.length}');
    } catch (error) {
      print('error cat by name===========>$error');
    }
  }

  Future<ListEnfantsModel?> getListEnfantsByParents(
      BuildContext context) async {
    try {
      print(
          'url==================${AppApi.listEnfantsByParentUrl}${InfoStorage.readId()}');
      Response response = await dio
          .get("${AppApi.listEnfantsByParentUrl}${InfoStorage.readId()}");

      print('value ===================> $response');
      if (response.statusCode == 200) {
        return listEnfantsModel = ListEnfantsModel.fromJson(response.data);
      }
      return null;
    } catch (error) {
      testData = true;
      print('error===========>$error');
    }
    return null;
  }

  PresencesByChildModel? presencesByChildModel;
  Future<PresencesByChildModel?> getListPresencesByChild(
      BuildContext context) async {
    try {
      Response response = await dio.get(
          "${AppApi.listPresencesByChildUrl}${InfoStorage.readIdEnfant()}");

      print('value ===================> $response');
      if (response.statusCode == 200) {
        return presencesByChildModel =
            PresencesByChildModel.fromJson(response.data);
      }

      return null;
    } catch (error) {
      testData = true;
      print('error===========>$error');
    }
    return null;
  }

  ChildModel? childModel;
  getEnfant(BuildContext context) async {
    print('-----------------------get enfant-----------------------');
    try {
      final response = await dio
          .get("${AppApi.listEnfantsUrl}${InfoStorage.readIdEnfant()}");
      if (response.statusCode == 200) {
        return childModel = ChildModel.fromJson(response.data);
      }
      print('value enfant ===================================> $response');
      Navigator.of(context).pop();
    } catch (error) {
      print('error===========>$error');
    }
  }

//-----------------------------presence
  ajoutPresence(BuildContext context, String s, String t) {
    print('-----------------------add ---------------------');
    Map<String, dynamic> data = {
      "status": s,
      "time": t,
      "child": InfoStorage.readIdEnfant()
    };
    dio.post(AppApi.peresonceUrl, data: data).then(
      (value) async {
        print('value ===================> $value');
        getListPresencesByChild(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "Ajout presence success",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 150,
            left: 50,
            right: 50,
          ),
        ));
        //Navigator.pop(context);

        // of(context).push(MaterialPageRoute(
        //   builder: (context) => const ListPresenceEtabliScreen(),
        // ));
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  static TextEditingController statut = TextEditingController();
  static TextEditingController name = TextEditingController();

  PresenceModel? presenceModel;
  getPresence() async {
    print(
        'get presence------------------------------------------${AppApi.peresonceUrl}${InfoStorage.readIpPresence()}');
    try {
      Response response = await dio
          .get("${AppApi.peresonceUrl}${InfoStorage.readIpPresence()}");
      print('responxxxxxxxxxxxse=====================${response.data}');
      if (response.statusCode == 200) {
        presenceModel = PresenceModel.fromJson(response.data);

        InfoStorage.saveStatus(presenceModel!.data!.status!);

        InfoStorage.saveTime(presenceModel!.data!.time!);

        // personnelModel = PersonnelModel.fromJson(response.data);
        // print('succes=======================${personnelModel!.data}');
        // nomController.text = personnelModel!.data!.firstName!;
        // adressController.text = personnelModel!.data!.adress!;
        // nomCompletController.text = personnelModel!.data!.lastName!;
        // numeroTelController.text = personnelModel!.data!.phone!.toString();
        // cinController.text = personnelModel!.data!.cin!.toString();
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  updatePresence(String s, String t, BuildContext context) {
    Map<String, dynamic> data = {
      "status": s,
      "time": t,
      "child": InfoStorage.readIdEnfant()
    };
    dio
        .patch("${AppApi.peresonceUrl}${InfoStorage.readIpPresence()}",
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

  deletePresence(BuildContext context) async {
    print('-----------------------delete presence-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.peresonceUrl}${InfoStorage.readIpPresence()}");

      print(
          'value peresonceUrl ===================================> $response');
      Navigator.of(context).pop();
    } catch (error) {
      print('error===========>$error');
    }
  }

  //---------------------------------categories
  ajoutCategory(BuildContext context, String c) {
    print('-----------------------add ---------------------');
    Map<String, dynamic> data = {
      "name": c,
    };
    dio.post(AppApi.categoriesUrl, data: data).then(
      (value) async {
        print('value ===================> $value');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "Ajout category success",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 150,
            left: 50,
            right: 50,
          ),
        ));
        //Navigator.pop(context);

        // of(context).push(MaterialPageRoute(
        //   builder: (context) => const ListPresenceEtabliScreen(),
        // ));
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  AllCategoryModel? allCategoryModel;
  deleteCategory(BuildContext context) async {
    print('-----------------------delete cat-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.categoriesUrl}${InfoStorage.readIdCategory()}");

      print('value cat ===================================> $response');
      Navigator.of(context).pop();
    } catch (error) {
      print('error===========>$error');
    }
  }

  CategoryModel? categoryModels;
  getCategory() async {
    try {
      Response response = await dio
          .get("${AppApi.categoriesByIdUrl}${InfoStorage.readIdCategory()}");
      print('responxxxxxxxxxxxse=====================${response.data}');
      if (response.statusCode == 200) {
        categoryModels = CategoryModel.fromJson(response.data);

        InfoStorage.saveCat(categoryModels!.data!.name!);
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  updateCategory(String c, BuildContext context) {
    Map<String, dynamic> data = {
      "name": c,
    };
    dio
        .patch("${AppApi.categoriesUrl}${InfoStorage.readIdCategory()}",
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

  ajoutSituation(
      BuildContext context, String ty, String n, String t, String d) {
    print(
        '-----------------------add --------------------${InfoStorage.readIdEnfant()}-');
    Map<String, dynamic> data = {
      "type": ty,
      "name": n,
      "treatment": t,
      "description": d,
      "child": InfoStorage.readIdEnfant()
    };
    dio.post(AppApi.situationsUrl, data: data).then(
      (value) async {
        print('value ===================> $value');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "Ajout situation success",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 150,
            left: 50,
            right: 50,
          ),
        ));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScreenHome(),
        ));
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  updateSituation(
      String ty, String n, String t, String d, BuildContext context) {
    Map<String, dynamic> data = {
      "type": ty,
      "name": n,
      "treatment": t,
      "description": d,
      "child": InfoStorage.readIdEnfant()
    };
    dio
        .patch("${AppApi.situationsUrl}${InfoStorage.readIdSituation()}",
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

  deleteSituation(BuildContext context) async {
    print('-----------------------delete situ-----------------------');
    try {
      final response = await dio
          .delete("${AppApi.situationsUrl}${InfoStorage.readIdSituation()}");

      print('value situation ===================================> $response');
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenHome(),
          ));
    } catch (error) {
      print('error===========>$error');
    }
  }

  AllParentModel? listParentModel;
  Future<AllParentModel?> getListParents() async {
    print('-----------------------get parents-----------------------');
    Map<String, dynamic> data = {"role": "Parent"};
    try {
      final response =
          await dio_.get(AppApi.allParentsUrl, queryParameters: data);

      print('value parents ===================================> $response');
      listParentModel = AllParentModel.fromJson(response.data);
      print(
          'value  listParentModel===================================> ${listParentModel!.data!.isEmpty}');
      return listParentModel;
    } catch (error) {
      print('error cat by name===========>$error');
    }
    return null;
  }
}

import 'package:creche/core/networking/app_api.dart';
import 'package:creche/core/storage/info_storage.dart';
import 'package:creche/models/user_login_model.dart';
import 'package:creche/models/user_model.dart';
import 'package:creche/screen/children/children_screen_parent.dart';
import 'package:creche/screen/parents/list_parents_screen.dart';
import 'package:creche/screen/profile/screen_login.dart';
import 'package:creche/screen/screen_home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ProfileController {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passWordController = TextEditingController();
  static final dio = Dio();
  static TextEditingController nomController = TextEditingController();
  static TextEditingController adressController = TextEditingController();
  static TextEditingController nomCompletController = TextEditingController();
  static TextEditingController numeroTelController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController confirmationpasswordController =
      TextEditingController();
  static TextEditingController test = TextEditingController();
  register(String nom, String numeroTel, String adress, String email,
      String password, String userName, BuildContext context) {
    Map<String, dynamic> data = {
      "role": "Establishment",
      "fullName": nom,
      "email": email,
      "phone": numeroTel,
      "adress": adress,
      "password": password,
      "userName": userName
    };
    dio.post(AppApi.signUpUrl, data: data).then(
      (value) {
        print('value ===================> $value');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ScreenLogin(),
          ),
        );
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  addParent(String nom, String numeroTel, String adress, String email,
      String password, String userName, BuildContext context) {
    Map<String, dynamic> data = {
      "role": "Parent",
      "fullName": nom,
      "email": email,
      "phone": numeroTel,
      "adress": adress,
      "password": password,
      "userName": userName
    };
    dio.post(AppApi.signUpUrl, data: data).then(
      (value) {
        print('value ===================> $value');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("l'ajout est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ListParentsScreen(),
        ));
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "email est deja utiliser ",
            style: TextStyle(color: Colors.grey),
          ),
          backgroundColor: Colors.orange[100],
        ),
      );
    });
  }

  UserLoginModel? userLoginModel;
  login(BuildContext context) {
    print('-----------------------login---------------------');
    Map<String, dynamic> data = {
      "email": emailController.text,
      "password": passWordController.text,
    };
    dio.post(AppApi.loginUrl, data: data).then(
      (value) async {
        print('value ===================> $value');
        userLoginModel = UserLoginModel.fromJson(value.data);
        print(
            'username+++++++++++++++++++++++++++${userLoginModel!.user!.fullName}');
        InfoStorage.saveFullname(
            "${userLoginModel!.user!.fullName}${userLoginModel!.user!.userName}");
        InfoStorage.saveEmail(userLoginModel!.user!.email);
        print('id=========================>${userLoginModel!.user!.sId}');
        InfoStorage.saveId(userLoginModel!.user!.sId);
        InfoStorage.saveToken(userLoginModel!.token!.accessToken!);
        InfoStorage.saveRole(userLoginModel!.user!.role);
        print(
            'iddddddddddddddddddd--------------------${InfoStorage.readId()}');
        await getUser();
        if (userLoginModel!.user!.role == "Establishment") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ScreenHome(),
          ));
        } else if (userLoginModel!.user!.role == "Parent") {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ChildrenScreenParent(),
          ));
        }
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  UserModel? userModel;
  getUser() async {
    print(
        'get user------------------------------------------${AppApi.getUserUrl}${InfoStorage.readId()}');
    try {
      Response response =
          await dio.get("${AppApi.getUserUrl}${InfoStorage.readId()}");
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);
        print('succes=======================${userModel!.data}');
        print("email===============${userModel!.data!.email!}");
        emailController.text = userModel!.data!.email!;
        nomController.text = userModel!.data!.fullName!;
        adressController.text = userModel!.data!.adress!;
        nomCompletController.text = userModel!.data!.userName!;
        numeroTelController.text = userModel!.data!.phone!.toString();
        print("control==============${emailController.text}");
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  getParent() async {
    print(
        'get user------------------------------------------${AppApi.getUserUrl}${InfoStorage.readIdParent()}');
    try {
      Response response =
          await dio.get("${AppApi.getUserUrl}${InfoStorage.readIdParent()}");
      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);
        print('succes=======================${userModel!.data}');
        print("email===============${userModel!.data!.email!}");
        emailController.text = userModel!.data!.email!;
        nomController.text = userModel!.data!.fullName!;
        adressController.text = userModel!.data!.adress!;
        nomCompletController.text = userModel!.data!.userName!;
        numeroTelController.text = userModel!.data!.phone!.toString();
        print("control==============${emailController.text}");
      }
    } catch (error) {
      print('error=====================>$error');
    }
  }

  static resetPassword(BuildContext context) {
    Map<String, dynamic> data = {
      "email": emailController.text,
    };
    dio.post(AppApi.resetPasswordUrl, data: data).then((value) async {
      print('value ===================> ${value.statusCode}');
      if (value.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "Vérifiez votre courriel s'il vous plaît !",
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
        Future.delayed(
          const Duration(
            seconds: 1,
          ),
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScreenLogin(),
              ),
            );
          },
        );
      } else if (value.statusCode == 500) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Text(
            "entrez un email valide",
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
      }
    }).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  updateUser(String nom, String numeroTel, String adress, String email,
      String userName, BuildContext context) {
    Map<String, dynamic> data = {
      "fullName": nom,
      "email": email,
      "phone": numeroTel,
      "adress": adress,
      "userName": userName
    };
    dio.patch("${AppApi.getUserUrl}${InfoStorage.readId()}", data: data).then(
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

  updateParent(String nom, String numeroTel, String adress, String email,
      String userName, BuildContext context) {
    Map<String, dynamic> data = {
      "fullName": nom,
      "email": email,
      "phone": numeroTel,
      "adress": adress,
      "userName": userName
    };
    dio
        .patch("${AppApi.getUserUrl}${InfoStorage.readIdParent()}", data: data)
        .then(
      (value) {
        print('value ===================> $value');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("la modification est réussie"),
            backgroundColor: Colors.orange[100],
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ListParentsScreen(),
          ),
        );
      },
    ).onError((error, stackTrace) {
      print('error=====================>$error');
    });
  }

  logOut(BuildContext context) async {
    try {
      final response = await dio.get(
        AppApi.logOutUrl,
        options: Options(
          headers: {
            "authorization": "Bearer ${InfoStorage.readToken()}",
          },
        ),
      );
      print('response=======================>${response.data}');
      if (response.statusCode == 200) {
        emailController.clear();
        passWordController.clear();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ScreenLogin(),
        ));
      }
    } catch (error) {
      print('error======================>$error');
    }
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




class SignUpPage extends StatelessWidget {
  // هدول متعيرات مشان اظهار ال password وال re password
  bool rePasswordVisibility = true;
  bool passwordVisibility = true;
  // هدول ال controllers مشات الحقول
  //هاد لل اسم
  final nameController = TextEditingController();
  //هاد لل email
  final emailController = TextEditingController();
  //هاد لل password
  final passwordController = TextEditingController();
  //هاد ل إعادة password
  final rePasswordController = TextEditingController();
  //هاد ل إعادة رقم ال هاتف
  final phoneController = TextEditingController();
  //هاد ال key مسان ال validation
  final signUpFormKey = GlobalKey<FormState>();
  File? image;
  final _piker = ImagePicker();

  SignUpPage({super.key});

  Future getImage() async {
    //print("${t} samay is awsemee9769");

    final pickedfile = await _piker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedfile != null) {
      image = File(pickedfile.path);
    } else {
      print("no imagewee");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title:  const Text("Sign Up"),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: <Widget>[
          // صورة الخلفية
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "lib/assets/Image/noIntrnet.png",
              fit: BoxFit.cover,
            ),
          ),
          //هاد لون فوق الخلفية مشات وضوح الكتابة
          Container(
            height: double.infinity,
            width: double.infinity,
            color: const Color.fromARGB(150, 60, 60, 100),
          ),
          // هاد مشان لما نفتح ال keyboard
          // ما يعطي pixels rendered out error
          // يعني مشات  ما تطلع ال pixels  من الشاشة
          Form(
            key: signUpFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 90,
                    // color: Color.fromARGB(110, 200, 200, 200),
                  ),
                  //  هاد logo  الشركة
                  Image.asset(
                    "lib/assets/Image/noIntrnet.png",
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.095,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // هاد ال container اللي بيحتوي ع ال textFields

                  GestureDetector(
                      onTap: () {
                        getImage();

                      },
                      child: Stack(children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.white),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20,
                                offset: Offset(5, 5),
                              ),
                            ],
                          ),
                          child: image != null
                              ? ClipOval(
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                              : Icon(
                            Icons.person,
                            color: Colors.grey.shade300,
                            size: 80.0,
                          ),
                        ),
                      ])),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.67,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: const Color.fromARGB(180, 0, 0, 65)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        // هاد ال حقل الخاص ب الاسم
                        TextFormField(
                          validator: (enteredPasswordVal) =>
                          enteredPasswordVal!.length < 6
                              ? "Name is too short"
                              : null,
                          controller: nameController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.deepOrange,
                            ),
                            label: Text(
                              "Full Name",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        // هاد ال حقل الخاص ب ال email
                        TextFormField(
                          validator: (enteredEmailVal) =>
                          enteredEmailVal != null 
                           //   !EmailValidator.validate(enteredEmailVal)
                              ? "Please Enter a Valid E-Mail"
                              : null,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.deepOrange,
                            ),
                            label: Text(
                              "E-Mail",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                       
                       
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        // هاد ال حقل الخاص ب ال password
                        TextFormField(
                          validator: (enteredPasswordVal) =>
                          enteredPasswordVal!.length < 8
                              ? "Password is too short"
                              : null,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: passwordVisibility,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key_sharp,
                              color: Colors.deepOrange,
                            ),
                            suffixIcon: IconButton(
                                color: Colors.blue,
                                icon: passwordVisibility
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                // color: Colors.deepOrange,
                                onPressed: () {}
                              /*
                              => setState(
                                    () => passwordVisibility = !passwordVisibility,
                              ),

                               */
                            ),
                            label: const Text(
                              "Password",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        // هاد ال حقل الخاص ب اعادة ال password
                        TextFormField(
                          validator: (enteredPasswordVal) =>
                          enteredPasswordVal!= passwordController.text
                              ? "re-Password isn't current"
                              : null,
                          obscureText: rePasswordVisibility,
                          controller: rePasswordController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.vpn_key_sharp,
                              color: Colors.deepOrange,
                            ),
                            suffixIcon: IconButton(
                                color: Colors.blue,
                                icon: rePasswordVisibility
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                // color: Colors.deepOrange,
                                onPressed: () {}
                              /*
                              => setState(
                                    () => rePasswordVisibility =
                                !rePasswordVisibility,
                              ),

                               */
                            ),
                            label: const Text(
                              "Re-Password",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        // هاد ال حقل الخاص ب رقم الهاتف
                        TextFormField(
                          validator: (enteredPhoneVal) =>
                          enteredPhoneVal!.length < 9
                              ? "phone is too short"
                              : null,
                          keyboardType: TextInputType.phone,
                          controller: phoneController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.deepOrange,
                            ),
                            label: Text(
                              "phone Number",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.deepOrange,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2.0,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        //هاد الزر اخر شي مننقل كلشي جوا ال on pressed
                        // buttonsOfAuthentication(context, 'Sign Up', (){
                        //   //هون لازم نضيف ال validator
                        //   //     // حاليا رح اتركو بتعليق مشات
                        //   //     // ما يعذبك وقت التجريب اخر شي بزبطو
                        //   //
                        //        final signupFormKeyCurrent = signUpFormKey.currentState!;
                        //         if(signupFormKeyCurrent.validate()){
                        //           // تابع ارسال البيانات
                        //            print("Test Request SignUp m");
                        //         }
                        //
                        //
                        // }),
                        //  هي كبسة ال signUp
                        // جوا ال onPressed منحط ال استدعاء تابع ارسال البيانات لل database

                        ElevatedButton(
                          onPressed: () {
                            //هون لازم نضيف ال validator
                            // حاليا رح اتركو بتعليق مشات
                            // ما يعذبك وقت التجريب اخر شي بزبطو
                            /*
                                final signinFormKey = signupFormKey.currentState!;
                              if(signinFormKey.validate()){
                                // تابع ارسال البيانات
                              }
                             */

                            print("Test Request SignUp");
                            // cubit.signUp(nameController.text, emailController.text,
                            //     passwordController.text, rePasswordController.text,  phoneController.text, image!);



                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal:
                              MediaQuery.of(context).size.width * 0.25,
                            ), backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 15.0,
                          ),
                          child:  const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(
                                Icons.lock_open_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

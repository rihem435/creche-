import 'package:flutter/material.dart';

class ScreenMotPassOublie extends StatelessWidget {
const ScreenMotPassOublie({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: Center(
        child: Container(
          padding: const EdgeInsets.all(18),
          height: MediaQuery.sizeOf(context).height * .8,
          width: MediaQuery.sizeOf(context).width * .8,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.grey)),
          child: Column(
            children: [
              Image.asset(
                "assets/images/creche.png",
                width: 165,
                height: 165,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    
                    hintText: "entrez votre code",
                    border: OutlineInputBorder()),
          
             
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.brown),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 28, vertical: 15))),
                  onPressed: () {},
                  child: const Text(
                    "confirme",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    
                  )),
            
                  ],
                )
                )
                ));
  
}
}
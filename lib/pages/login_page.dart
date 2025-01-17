import 'package:flutter/material.dart';
import 'package:my_flutterapp/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeButton = false;

  final _formKey = GlobalKey<FormState>();

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1)); //ye hai hai taki mai dusre page par ja saku after
      //jab mera animation hojaye
      // ignore: use_build_context_synchronously
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [Image.asset("assets/images/login_image.png",
              fit: BoxFit.cover,
              // height: 600,this is only used to show the how singlechildscroolview is done

            ),
               const SizedBox(
                 height: 20.0,
               ),
                Text(
                  "Welcome $name",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),

              ),
              const SizedBox(
                height: 20.0,
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Enter username",
              //     labelText:  "Username",
              //   ),
              // ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: "Enter password",
              //     labelText:  "Password",
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                child: Column(children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Enter username",
                      labelText:  "Username",
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return("Username cannot be empty");
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                      setState(() {});
                    }
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Enter password",
                      labelText:  "Password",
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return("Password cannot be empty");
                      }
                      else if(value.length < 6) {
                        return "Password length should be atleast 6";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),

                  Material(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(changeButton? 50 : 8),
                    child: InkWell(
                      onTap: () => moveToHome(context),
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        width: changeButton? 50 : 150,
                        height: 50,
                        alignment: Alignment.center,
                        child: changeButton?
                        const Icon(Icons.done,
                        color: Colors.white,
                        )
                       : const Text("Login",
                          style: TextStyle(color: Colors.white ,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //     onPressed: (){
                  //       // print("Hi Nitish Kumar Sengar");
                  //       Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //     },
                  //     style: TextButton.styleFrom(minimumSize: Size(150, 40) ,
                  //     backgroundColor: Colors.lightGreen),
                  //     child: Text("Login")
                  // )

                ],),
              )

            ],
          ),
        ),
      )
    );
  }
}

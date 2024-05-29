import 'package:flutter/material.dart';
import 'package:my_flutterapp/pages/cart_page.dart';
import 'package:my_flutterapp/pages/login_page.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutterapp/utils/routes.dart';
import 'package:my_flutterapp/widgets/themes.dart';
import 'pages/home_page.dart';


void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // int days = 30;
    // String name = "Codepur";
    return  MaterialApp(
      // home: HomePage(),
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),

      debugShowCheckedModeBanner: false,
      initialRoute: "/home",
      routes: {
        "/": (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.cartRoute: (context) => CartPage(),
        },

    );

  }

}

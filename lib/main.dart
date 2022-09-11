import 'dart:io';
import 'package:blnk_test/home.dart';
import 'package:blnk_test/model/userInformation.dart';
import 'package:blnk_test/users_sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


Future main() async{
WidgetsFlutterBinding.ensureInitialized();
await UserSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes: {
        UserInformation.ROUTE_NAME: (context) =>UserInformation(),
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),


      },
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: getStarted()
    );
  }
}


  class getStarted extends StatelessWidget {
    const getStarted({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: 200,),
            Center(child: Image.asset("assets/logo.png")),
            TextButton(onPressed: ()=>Navigator.pushNamed(context, UserInformation.ROUTE_NAME), child: Text("Get started",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),))
          ],
        ),
      );
    }
  }







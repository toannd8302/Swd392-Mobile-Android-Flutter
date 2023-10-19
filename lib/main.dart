import 'package:firebase_core/firebase_core.dart';
import 'package:fltter_30days/service/noti_service.dart';
import 'package:fltter_30days/rourtes/MyRoutes.dart';
import 'package:fltter_30days/widgets/themes.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().init();
//tz.initializeTimeZones();
  await Firebase.initializeApp();
// FirebaseApi().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //    title: 'Flutter Demo',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //     fontFamily: "CeraPro",
    //   ),
    //   home:  MyHomePage1(title: 'Flutter Local Notification'),
    // );

    return MaterialApp(
      //change theme if the mobile change theme
      themeMode: ThemeMode.light,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: TextTheme(
              titleLarge: TextStyle(
            fontSize: 48,
          ))),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      //initialRoute: "/map",
      routes: myRourtes,
    );
  }
}

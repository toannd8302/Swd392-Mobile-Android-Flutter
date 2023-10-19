

import 'package:fltter_30days/pages/home_page.dart';
import 'package:fltter_30days/pages/introduction_page.dart';
import 'package:fltter_30days/pages/login_page.dart';
import 'package:fltter_30days/pages/map_screen.dart';
import 'package:fltter_30days/pages/project_detail_page.dart';
import 'package:fltter_30days/pages/splash_page.dart';


var myRourtes = {
  "/": (context) => LoginPage(),
  "/home/": (context) => MyHomePage(),
  "/login": (context) => LoginPage(),
  "/project-detail": (context) => ProjectDetailPage(),
  "/splash-screen": (context) => SplashPage(),
  "/introduction/": (context) => IntroductionPage(),
  "/map": (context) => MapScreen(),
};

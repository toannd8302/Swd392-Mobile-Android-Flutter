import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltter_30days/home_page1.dart';
import 'package:fltter_30days/pages/attendance_page.dart';
import 'package:fltter_30days/pages/profile_content_page.dart';
import 'package:fltter_30days/pages/schedule_page.dart';

import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  late String logo_img;
  final storage = FirebaseStorage.instance;

  Future<void> getImageUrl() async {
    // Get the reference to the image file in Firebase Storage
    final ref = storage.ref().child('image_2023-09-22_112237841.png');

    // Get teh imageUrl to download URL
    final url = await ref.getDownloadURL();

    setState(() {
      logo_img = url;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial value of imageUrl to an empty string
    logo_img = '';

    //Retrieve the imge grom Firebase Storage
    getImageUrl();
  }

  void _navigateToPage(int pageIndex) {
    _pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,

            // title: Text('Home Page',
            // style: TextStyle(
            //   color: Colors.white,
            //   fontSize: 20,
            //   fontWeight: FontWeight.bold,
            //   fontFamily: "Seoge UI"
            //   ),),
            // centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  //Proccess Notification Local and Push
                },
              )
            ],
            flexibleSpace: Center(
              child: Container(
                //padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                 color: Theme.of(context).colorScheme.primary,
                  ),
                child: Center(
                  child: Container(
                    width: 90.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Image.network(
                        logo_img,
                        width: 150.0,
                        height: 130.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: [
              MyHomePage1(internId: ApiService.currentUserId),
              scheduleContentPage(),
              AttendanceReportPage(internId: ApiService.currentUserId),
              // NotificationPage(),
              profileContentPage(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check),
                label: 'Attendace',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.notification_add),
              //   label: 'Notification',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                
               
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _navigateToPage,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            elevation: 0,
          ),
        ),
      ),
    );
  }
void logout(BuildContext context) {
  clearUserSession();
  Navigator.of(context).pushReplacementNamed('/login');
}

void clearUserSession() {
  ApiService.jwtToken = '';
  ApiService.currentEmail = '';
  ApiService.currentUserId = '';
}
}
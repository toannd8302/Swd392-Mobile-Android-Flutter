import 'dart:async';
import 'package:fltter_30days/pages/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late String imageUrl;
  final storage = FirebaseStorage.instance;
  Future<void> getImageUrl() async {
    // Get the reference to the image file in Firebase Storage
    final ref = await storage.ref().child('image_2023-09-22_112237841.png');

    // Get teh imageUrl to download URL
    final url = await ref.getDownloadURL();

    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    // Set the initial value of imageUrl to an empty string
    imageUrl = '';
    //Retrieve the imge grom Firebase Storage
    getImageUrl();
    // Đợi 3 giây, sau đó chuyển hướng đến trang đăng nhập.
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // margin: EdgeInsets.only(bottom: 35.0),
              child: Image.asset(
                imageUrl,
                width: 500,
                height: 600,
              ),
            ),
            const SizedBox(height: 20),
             CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onBackground)),
            
          ],
        ),
      ),
    );
  }
}

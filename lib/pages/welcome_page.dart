import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late String imageUrl;
  Future<void> getImageUrl() async {
    final ref =
        FirebaseStorage.instance.ref().child('image_2023-09-22_112237841.png');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial value of imageUrl to an empty string
    imageUrl = '';

    //Retrieve the imge grom Firebase Storage
    getImageUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                    colors: [
                      Color(0xFF1c62cf),
                      Colors.blue,

                      // Thêm các màu đậm khác theo cùng cách
                    ],
                    // stops: [0.0, 0.5, 1.0],  // Chỉ định điểm chuyển đổi màu
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
          ),
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                
              ),
              margin: EdgeInsets.only(top: 70.0),
              child: Image.network(
                imageUrl,
                width: 300,
                height: 415,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Welcome to TLATH",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: InkWell(
                // Sử dụng InkWell để tạo liên kết
                child: Container(
                  
                  child: Text(
                    'Click to login',
                    
                    style: TextStyle(
                      color: Colors.white, 
                      fontSize: 25,
                      fontFamily: "Roboto"// Màu văn bản của liên kết
                      //decoration: TextDecoration.underline, // Gạch chân văn bản
                    ),
                  ),
                ),
                onTap: () {
                  // Xử lý sự kiện khi liên kết được bấm
                   Navigator.pushNamed(context, '/login');
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:fltter_30days/pages/personal_profile_page.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class profileContentPage extends StatefulWidget {
  const profileContentPage({super.key});

  @override
  State<profileContentPage> createState() => _profileContentPageState();
}

class _profileContentPageState extends State<profileContentPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();

  String? _userName;
  String? _userAvatarUrl;
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final currentUser = await _googleSignIn.signInSilently();
      if (currentUser != null) {
        setState(() {
          _userName = currentUser.displayName;
          _userAvatarUrl = currentUser.photoUrl;
          _userEmail = currentUser.email;
        });
      }
    } catch (e) {
      // Handle sign-in errors
      print('Error loading user info: $e');
    }
  }
 @override
  Widget build(BuildContext context) {
    return WillPopScope(
        // Xử lý logic ở đây, trả về true nếu bạn muốn cho phép thoát, và false nếu bạn muốn ngăn người dùng thoát
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF39b6ee),
              Color(0xFF1c62cf),],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: _userAvatarUrl != null
                            ? NetworkImage(_userAvatarUrl!)
                            : const AssetImage("") as ImageProvider<Object>,
                      ),
                    ),
                    child: _userAvatarUrl == null
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userName ?? 'Loading...',
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _userEmail ?? 'Loading...',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.account_circle_rounded,
                  size: 30,
                ),
                title: const Text('Personal Profile'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InformationProfilePage(
                          interId: ApiService.currentUserId,role: ApiService.role),
                    ),
                  );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
           
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.star,
                  size: 30,
                ),
                title: const Text('Company Introduction'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                
                
                  Navigator.pushNamed(context, "/introduction/" );
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  size: 30,
                ),
                title: const Text('Logout'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Logout functionality
                  _googleSignIn.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                iconColor: Colors.white,
                textColor: Colors.white,
                tileColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
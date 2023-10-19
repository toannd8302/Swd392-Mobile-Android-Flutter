import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String imageUrl;
  late String ggImageURL;
  late String? mtoken;
  TextEditingController nameController = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  final storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool _isLoading = false; // Track the loading state
  Future<UserCredential?> _signInWithGoogle() async {
    //Login GG API
    try {
      setState(() {
        _isLoading =
            true; // Đặt trạng thái loading thành true khi bắt đầu đăng nhập
      });

      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount == null) {
        // Người dùng đã hủy đăng nhập hoặc không thể đăng nhập
        setState(() {
          _isLoading =
              false; // Đặt trạng thái loading thành false khi đăng nhập hoàn tất
        });
        return null;
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final String email = user.email!;
        final String jwtToken = await ApiService.fetchJwtToken(email);
        // Xử lý logic khi đăng nhập thành công ở đây
      } else {
        // Xử lý logic khi không thể lấy thông tin người dùng
      }

      setState(() {
        _isLoading =
            false; // Đặt trạng thái loading thành false khi đăng nhập hoàn tất
      });

      return userCredential;
    } catch (e) {
      setState(() {
        _isLoading =
            false; // Đặt trạng thái loading thành false trong trường hợp có lỗi
      });
      print("Error signing in with Google: $e");
      // Xử lý logic khi có lỗi xảy ra ở đây
      return null;
    }
  }

  Future<void> getImageUrl() async {
    // Get the reference to the image file in Firebase Storage
    final ref = storage.ref().child('image_2023-09-22_112237841.png');
    final ref1 = storage.ref().child('google_logo.png');

    // Get teh imageUrl to download URL
    final url = await ref.getDownloadURL();
    final ggurl = await ref1.getDownloadURL();
    setState(() {
      imageUrl = url;
      ggImageURL = ggurl;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set the initial value of imageUrl to an empty string
    imageUrl = '';
    ggImageURL = '';
    //Retrieve the imge grom Firebase Storage
    getImageUrl();
  }

  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      //Cập nhật trạng thái của Widget
      setState(() {
        changeButton = true;
      });
      //tạo độ trễ trong việc thực hiện các hành động tiếp theo (ở đây là 1s)
      await Future.delayed(const Duration(seconds: 1));
      //chuyển hướng đến màn hình khác
      await Navigator.pushNamed(context, '/home');
      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.background,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                       
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                            ),
                            filled: true,
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            hintStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold,
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility_off),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Text('Forgot Password?',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: double.infinity,
                            child: FilledButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  )),
                                ),
                                onPressed: () {},
                                child: Text('Login',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold)))),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Dont't have an account?",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'sign up',
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary))
                          ]),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '-----------------------Or-----------------------',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 15.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Tùy chọn đăng nhập Google
                              GestureDetector(
                                onTap: () {
                                  _signInWithGoogle().then((userCredential) {
                                    if (userCredential != null) {
                                      // Login successful, navigate to HomePage
                                      Navigator.pushNamed(
                                        context,
                                        '/splash-screen',
                                      );
                                    } else {
                                      _googleSignIn.signOut();
                                      // Error signing in, display an error message
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Failed to sign in with Google."),
                                        ),
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Màu nền của tùy chọn
                                    borderRadius: BorderRadius.circular(
                                        5.0), // Bo tròn viền
                                    boxShadow: [
                                      // Đổ bóng cho tùy chọn
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0,
                                            3), // thay đổi vị trí của đổ bóng
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'lib/assets/images/google_logo.png',
                                        width: 24,
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset('lib/assets/images/leaves_vector.png')))
        ],
      ),
    );
  }
}

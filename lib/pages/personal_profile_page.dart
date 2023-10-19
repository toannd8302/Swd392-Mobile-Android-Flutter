import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltter_30days/models/intern_model.dart';
import 'package:fltter_30days/pages/edit_profile_page.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';

class InformationProfilePage extends StatefulWidget {
  final String interId;
  final String role;

  const InformationProfilePage(
      {super.key, required this.interId, required this.role});

  @override
  State<InformationProfilePage> createState() => _InformationProfilePageState();
}

class _InformationProfilePageState extends State<InformationProfilePage> {
  Future<Intern>? _internFuture;
  late String imgUrl;
  Future<void> getDownloadImage() async {
    final ref =
        FirebaseStorage.instance.ref().child('background-mau-xanh-1.jpeg');
    final url = await ref.getDownloadURL();
    setState(() {
      imgUrl = url;
    });
  }

  @override
  void initState() {
    super.initState();
    imgUrl = '';
    getDownloadImage();
    _internFuture = ApiService.fetchIntern(widget.interId, widget.role);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Personal Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF39b6ee),
                    Color(0xFF1c62cf),
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                ),
              ),
            ),
          ),
        ),
        body: FutureBuilder<Intern>(
          future: _internFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              Intern intern = snapshot.data!;
              Future<void> _updateInternData() async {
                var updatedIntern = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditInformationPage(intern: intern)),
                );
                if (updatedIntern != null) {
                  setState(() {
                    intern = updatedIntern;
                  });
                }
              }

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      child: Container(
                       
                        decoration: BoxDecoration(
                        color: Color(0xFF2196F3),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            shrinkWrap:
                                true, // Đặt thuộc tính shrinkWrap thành true
                            itemCount: 7, // Số lượng phần tử trong danh sách
                            itemBuilder: (context, index) {
                              late Widget subtitleWidget;
                              switch (index) {
                                case 0:
                                  if (intern.fullName == '') {
                                    subtitleWidget = Text(
                                      'Updating...',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    );
                                  } else {
                                    subtitleWidget = Text(
                                      intern.fullName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    );
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'Full name',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF5F5F5),
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 1:
                                  if (intern.university == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(intern.university);
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'University',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF5F5F5),
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 2:
                                  if (intern.dob == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(intern.dob);
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'DOB',
                                      style: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 3:
                                  if (intern.gender == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(
                                        intern.gender == 0 ? 'Female' : 'Male');
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'Gender',
                                      style: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 4:
                                  if (intern.phoneNumber == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(intern.phoneNumber);
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'Phone number',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 5:
                                  if (intern.email == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(intern.email);
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'Email',
                                      style: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                case 6:
                                  if (intern.major == '') {
                                    subtitleWidget = Text('Updating...');
                                  } else {
                                    subtitleWidget = Text(intern.major);
                                  }
                                  return ListTile(
                                    title: const Text(
                                      'Major',
                                      style: TextStyle(
                                        color: Color(0xFFF5F5F5),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: subtitleWidget,
                                  );
                                default:
                                  return SizedBox(); // Trường hợp mặc định
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed:
                          _updateInternData, // Gọi hàm _updateInternData khi nhấp vào nút "Edit Information"
                      child: Text('Edit Information'),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('Thông tin của bạn chưa được cập nhật'),
              );
            }
          },
        ),
      ),
    );
  }
}

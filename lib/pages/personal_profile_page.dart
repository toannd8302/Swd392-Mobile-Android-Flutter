import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltter_30days/models/intern_model.dart';
import 'package:fltter_30days/pages/edit_profile_page.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';

class InformationProfilePage extends StatefulWidget {
  final String interId;
  final String role;

  const InformationProfilePage({super.key, required this.interId, required this.role});

  @override
  State<InformationProfilePage> createState() => _InformationProfilePageState();
}

class _InformationProfilePageState extends State<InformationProfilePage> {
  Future<Intern>? _internFuture;
  late String imgUrl;
  late Intern intern;

  Future<void> getDownloadImage() async {
    final ref = FirebaseStorage.instance.ref().child('background-mau-xanh-1.jpeg');
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

  void _updateInternData() async {
    var updatedIntern = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditInformationPage(intern: intern)),
    );
    if (updatedIntern != null) {
      setState(() {
        intern = updatedIntern;
      });
    }
  }

  Widget buildInformationItem(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Personal Profile',
      
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Seoge UI"
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      body: Container(
       
        child: FutureBuilder<Intern>(
          future: _internFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              intern = snapshot.data!;
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    buildInformationItem('Full name:', intern.fullName == '' ? 'Updating...' : intern.fullName),
                    buildInformationItem('University:', intern.university == '' ? 'Updating...' : intern.university),
                    buildInformationItem('Birthday:', intern.dob == '' ? 'Updating...' : intern.dob),
                    buildInformationItem('Gender:', intern.gender == 0 ? 'Female' : 'Male'),
                    buildInformationItem('Phone number:', intern.phoneNumber == '' ? 'Updating...' : intern.phoneNumber),
                    buildInformationItem('Email:', intern.email == '' ? 'Updating...' : intern.email),
                    buildInformationItem('Major:', intern.major == '' ? 'Updating...' : intern.major),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateInternData,
                      child: Text('Edit Information',
                      
                      style: TextStyle(
                        fontFamily: 'Seoge UI',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Thông tin của bạn chưa được cập nhật'),
              );
            }
          },
        ),
      ),
    );
  }
}

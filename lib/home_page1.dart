import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fltter_30days/models/intern_project_model.dart';
import 'package:fltter_30days/service/api_service.dart';

class MyHomePage1 extends StatefulWidget {
  final String internId;

  MyHomePage1({
    Key? key,
    required this.internId,
  }) : super(key: key);

  @override
  State<MyHomePage1> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHomePage1> {
  late String imgUrl;
  late Future<List<InternProject>> _internProjectFuture;
  Future<void> getDownloadURL() async {
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
    getDownloadURL();
    _internProjectFuture = ApiService.internProject(widget.internId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit
                  .cover, // Phù hợp và che đầy toàn bộ kích thước của Container
            ),
          ),
          child: FutureBuilder<List<InternProject>>(
            future: _internProjectFuture,
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
                final projects = snapshot.data!;
                if (projects.isEmpty) {
                  return Center(
                    child: Text(
                      'You have no project',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                } else if (projects.length == 1) {
                  return Center(
                    child: Column(children: [
                      Text(
                        'You has ${projects.length} project in progress',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.lightBlue, Colors.white],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ]),
                  );
                } else {}
                return Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Text(
                        'You have ${projects.length} projects in progress',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: projects.length, // Số lượng dự án
                          itemBuilder: (context, index) {
                            final project = projects[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/project-detail",
                                    arguments: project.projectId);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15.0,
                                ),
                                decoration: BoxDecoration(
                                 
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Text(
                                    '${project.projectName}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Seoge UI",
                                      
                                     
                                    ),
                                  ),
                                  
                                ),
                              ),
                            );
                          },
                        ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fltter_30days/models/project_model.dart';
import 'package:fltter_30days/service/api_service.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({Key? key}) : super(key: key);

  @override
  _ProjectDetailPageState createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Future<Project>? _projectDetail;
  String? projectId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_projectDetail == null) {
      final ModalRoute<dynamic>? route = ModalRoute.of(context);
      if (route != null && route.settings.arguments != null) {
        projectId = route.settings.arguments as String;
        print('fine');
        _loadProjectDetail();
      }
    }
  }

  void _loadProjectDetail() async {
    try {
      final project = await ApiService.fetchProjectApi(projectId!);

      setState(() {
        _projectDetail = Future.value(project);
      });
    } catch (error) {
      setState(() {
        _projectDetail = Future.error(error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Detail',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: FutureBuilder<Project>(
        future: _projectDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final projectDetail = snapshot.data!;
            // Hiển thị chi tiết dự án ở đây
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Project Name: ${projectDetail.name}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        Text('Project Description: ${projectDetail.desc}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),),  
                        
                        // Thêm thông tin chi tiết khác của dự án
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}

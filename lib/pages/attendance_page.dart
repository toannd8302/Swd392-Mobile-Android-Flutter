import 'package:fltter_30days/models/attendance_model.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';

class AttendanceReportPage extends StatefulWidget {
  const AttendanceReportPage({
    Key? key,
    required this.internId,
  }) : super(key: key);
  final String internId;
  @override
  State<AttendanceReportPage> createState() => _attContentPageState();
}

class _attContentPageState extends State<AttendanceReportPage> {
  late String imgUrl;
  late Future<List<AttendanceModel>> _attendanceFuture;

  @override
  void initState() {
    super.initState();
    _attendanceFuture = ApiService.fetchAttendanceApi(widget.internId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<List<AttendanceModel>>(
              future: _attendanceFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print("hello");
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  print("hello2");
                  final attendances = snapshot.data!;
                  if (attendances.isEmpty) {
                    return Center(
                      child: Text(
                        'You have no project',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    );
                  } else if (attendances.length == 1) {
                    final attendance = attendances[0];
                    return Center(
                      child: Column(children: [
                        Text(
                          'You has ${attendances.length} project in progress',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        Container(
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
                              '${attendance.description}',
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: "Seoge UI",
                              ),
                            ),
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
                          'You have ${attendances.length} projects in progress',
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
                            itemCount: attendances.length, // Số lượng dự án
                            itemBuilder: (context, index) {
                              final attendance = attendances[index];
                              print(attendance.checkInTime);
                              return Container(
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
                                    '${attendance.description}',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Seoge UI",
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
          ],
        ),
      ),
    );
  }
}

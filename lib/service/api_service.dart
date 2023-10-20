import 'dart:convert';
import 'package:fltter_30days/models/attendance_model.dart';
import 'package:fltter_30days/models/intern_model.dart';
import 'package:fltter_30days/models/intern_project_model.dart';
import 'package:fltter_30days/models/project_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://swdprojectapi.azurewebsites.net/api/';
  static String jwtToken = '';
  static String currentEmail = '';
  static String currentUserId = '';
  static String role = '';

  // ========================= AUTHENTICATION API ==============================
  static Future<String> fetchJwtToken(String email) async {
    final url = Uri.parse('${baseUrl}accounts/login');
    final body = jsonEncode(email);
    print(email);
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      jwtToken = data['accessToken'];
      currentEmail = email;
      currentUserId = data['id'];
      role = data['role'];
      return jwtToken;
    } else if (response.statusCode == 401) {
      // Access token expired, try refreshing the token using the refresh token
      final refreshToken = json.decode(response.body)['refreshToken'];
      final refreshResponse = await http.post(
        Uri.parse('${baseUrl}accounts/login/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (refreshResponse.statusCode == 200) {
        final refreshData = json.decode(refreshResponse.body);
        jwtToken = refreshData['accessToken'];
        currentEmail = email;
        return jwtToken;
      } else {
        throw Exception('Failed to refresh JWT token');
      }
    } else {
      throw Exception('Failed to fetch JWT token ${response.statusCode}');
    }
  }
  //===========================GET ROLE API===============================

  static Future<String> getRole(String email) async {
    final url = Uri.parse('${baseUrl}accounts/login');
    final body = jsonEncode(email);

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      currentUserId = data['id'];
      role = data['role'];
      return role;
    } else if (response.statusCode == 401) {
      // Access token expired, try refreshing the token using the refresh token
      final refreshToken = json.decode(response.body)['refreshToken'];
      final refreshResponse = await http.post(
        Uri.parse('${baseUrl}accounts/login/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'refreshToken': refreshToken,
        }),
      );

      if (refreshResponse.statusCode == 200) {
        final refreshData = json.decode(refreshResponse.body);
        jwtToken = refreshData['accessToken'];
        currentEmail = email;
        return jwtToken;
      } else {
        throw Exception('Failed to refresh JWT token');
      }
    } else {
      throw Exception('Failed to fetch JWT token ${response.statusCode}');
    }
  }

  // ========================= INTERN API ==============================
  static Future<Intern> fetchIntern(String id, String sendRole) async {
    id = ApiService.currentUserId;
    sendRole = ApiService.role;
    final url = Uri.parse('${baseUrl}accounts/detail');
    final body = jsonEncode({
      'id': id,
      'role': sendRole,
    });

    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> internJson = json.decode(response.body);
      return Intern.fromJson(internJson);
    } else {
      throw Exception('Failed to fetch intern ${response.statusCode}');
    }
  }

  // ========================= INTERN-PROJECT API ==============================
  static Future<List<InternProject>> internProject(String id) async {
    final url = Uri.parse('${baseUrl}projects/intern?id=$id');
    print(url);

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $jwtToken', // Thêm mã JWT vào tiêu đề Authorization
      },
    );

    final List<dynamic> projectListJson = json.decode(response.body);
    final List<InternProject> projectList = projectListJson
        .map((jsonItem) => InternProject.fromJson(jsonItem))
        .toList();
    return projectList;
  }

  // ========================= INTERN-PROJECT-DETAIL API ==============================
  static Future<Project> fetchProjectApi(String id) async {
    print(id);
    final url = Uri.parse('${baseUrl}projects/$id');
    print(url);
    print(jwtToken);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> projectJson = json.decode(response.body);
      print(projectJson);
      return Project.fromJson(projectJson);
    } else {
      throw Exception('Failed to fetch project ${response.statusCode}');
    }
  }

    // ========================= ATTENDANCE API ==============================
  static Future<List<AttendanceModel>> fetchAttendanceApi(String id) async {
    print(id);
    final url = Uri.parse('${baseUrl}/attendances/intern?id=${id}');
    print(url);
    print(jwtToken);
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );
    print(response.statusCode);
     if (response.statusCode == 200) {
    final List<dynamic> attendanceApi = json.decode(response.body);
    return attendanceApi.map((attendance) => 
    AttendanceModel.fromJson(attendance)).toList();
  } else {
      throw Exception('Failed to fetch attendance ${response.statusCode}');
    }
  }

  // ==================================UPDATE INTERN PRPOFILE=============================
  Map<String, dynamic> internToJson(Intern intern) {
    return {
      'id': intern.id,
      'fullName': intern.fullName,
      'university': intern.university,
      'dob': intern.dob,
      'gender': '${intern.gender}',
      'phoneNumber': intern.phoneNumber,
      'major': intern.major,
    };
  }

  // Hàm để gọi API
  Future<void> updateInternInformation(Intern intern) async {
    final apiUrl =
        '${baseUrl}accounts/intern/update'; // Đặt URL của API của bạn ở đây

    // Chuyển đổi đối tượng Dart thành JSON
    final jsonData = internToJson(intern);
    print(jsonData);
    final jsonString = jsonEncode(jsonData);

    final response = await http.patch(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer $jwtToken', // Thêm mã JWT vào tiêu đề Authorization
      },
      body: jsonString,
    );
    print(intern.dob);
    if (response.statusCode == 200) {
      // Xử lý kết quả từ API nếu cần
      print('Data updated successfully');
    } else {
      // Xử lý lỗi nếu có
      print('Error: ${response.statusCode}');
    }
  }
}

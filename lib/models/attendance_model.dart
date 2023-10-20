class AttendanceModel {
  String id;
  String internId;
  int status;
  String description;
  DateTime updateTime;
  DateTime checkInTime;
  DateTime checkOutTime;

  AttendanceModel({
    required this.id,
    required this.internId,
    required this.status,
    required this.description,
    required this.updateTime,
    required this.checkInTime,
    required this.checkOutTime,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'] ?? '',
      internId: map['internId'] ?? '', // Kiểm tra và xử lý giá trị null
      status: map['status'] is int
          ? map['status']
          : (map['status'] is String
              ? int.tryParse(map['status']) ?? 0
              : 0),
      description: map['description'] ?? '',

      updateTime: map['updateTime'] != null
          ? DateTime.parse(map['updateTime'])
          : DateTime.now(), // Kiểm tra và xử lý giá trị null
      checkInTime: map['checkIn'] != null
          ? DateTime.parse(map['checkIn'])
          : DateTime.now(), // Kiểm tra và xử lý giá trị null
      checkOutTime: map['checkOut'] != null
          ? DateTime.parse(map['checkOut'])
          : DateTime.now(), // Kiểm tra và xử lý giá trị null
    );
  }
}

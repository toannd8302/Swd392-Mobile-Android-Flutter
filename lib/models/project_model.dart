class Project {
  final String id;
  final String name;
  final String desc;
  final String code;
  final int status;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime updateTime;

  Project({
    required this.id,
    required this.name,
    required this.desc,
    required this.code,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.updateTime,
  });

 factory Project.fromJson(Map<String, dynamic> map) {
  return Project(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    desc: map['description'] ?? '',
    code: map['code'] ?? '',
    status: map['status'] is int
        ? map['status']
        : (map['status'] is String
            ? int.tryParse(map['status']) ?? 0
            : 0), // Handle cases where 'status' is not an int or a string
    startDate: DateTime.parse(map['startDate']),
    endDate: DateTime.parse(map['endDate']),
    updateTime: DateTime.parse(map['updateTime']),
  );
}

}



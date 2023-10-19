class InternProject {
  final String id;
  String projectId;
  String projectName;
  DateTime updateTime;

  InternProject({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.updateTime,
  });

  //getter & setter

  String getId() {
    return id;
  }

  String getProjectId() {
    return projectId;
  }

  void setProjectId(String id) {
    projectId = id;
  }

  String getProjectName() {
    return projectName;
  }

  void setProjectName(String name) {
    projectName = name;
  }

  DateTime getUpdateTime() {
    return updateTime;
  }

  void setUpdateTime(DateTime time) {
    updateTime = time;
  }

  //convert json to object

  factory InternProject.fromJson(Map<String, dynamic> json) {
    String? updateTimeStr = json['updateTime'];
    DateTime? updateTime;

    if (updateTimeStr != null) {
      try {
        updateTime = DateTime.parse(updateTimeStr);
      } catch (e) {
        // Handle parsing error, or set updateTime to null if necessary
        updateTime = null;
      }
    }
    return InternProject(
      id: json['id'] ?? '',
      projectId: json['projectId'] ?? '',
      projectName: json['projectName'] ?? '',
      updateTime: updateTime ?? DateTime.now(),
    );
  }
}

class Intern {
  String id;
  String fullName;
  String university;
  String major;
  String internshipSemester;
  String team;
  String dob;
  int gender;
  String role;
  String email;
  String phoneNumber;
  int status;
  Intern({
    required this.id,
    required this.fullName,
    required this.university,
    required this.major,
    required this.internshipSemester,
    required this.team,
    required this.dob,
    required this.gender,
    required this.role,
    required this.email,
    required this.phoneNumber,
    required this.status,
  });

  String getFullName() {
    return fullName;
  }

  void setFullName(String name) {
    fullName = name;
  }

  // Tương tự cho các trường thông tin khác
  String getUniversity() {
    return university;
  }

  void setUniversity(String univ) {
    university = univ;
  }

  String getDob() {
    return dob;
  }

  void setDob(String dateOfBirth) {
    dob = dateOfBirth;
  }

  int getGender() {
    return gender;
  }

  void setGender(int gen) {
    gender = gen;
  }

  String getPhoneNumber() {
    return phoneNumber;
  }

  void setPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  String getEmail() {
    return email;
  }

  void setEmail(String mail) {
    email = mail;
  }

  String getMajor() {
    return major;
  }

  void setMajor(String maj) {
    major = maj;
  }

  factory Intern.fromJson(Map<String, dynamic> json) {
    return Intern(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      university: json['university'] ?? '',
      major: json['major'] ?? '',
      internshipSemester: json['internshipSemester'] ?? '',
      team: json['team'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? 0,
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      status: json['status'] ?? 0,
    );
  }

 
}


import 'package:firebase_storage/firebase_storage.dart';
import 'package:fltter_30days/models/intern_model.dart';
import 'package:fltter_30days/service/api_service.dart';
import 'package:flutter/material.dart';

class EditInformationPage extends StatefulWidget {
  final Intern intern;

  EditInformationPage({Key? key, required this.intern}) : super(key: key);

  @override
  _EditInformationPageState createState() => _EditInformationPageState();
}

class _EditInformationPageState extends State<EditInformationPage> {
  TextEditingController fullNameController = TextEditingController();
  String universityController = '';
  DateTime? selectedDate; // Thêm DateTime để lưu ngày tháng năm
  int selectedGender = 0;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController majorController = TextEditingController();
  late String imageUrl;
  @override
  void initState() {
    super.initState();
    imageUrl = '';
    _getDownloadUrl();
    fullNameController.text = widget.intern.fullName;
    universityController = widget.intern.university;
    selectedDate =
    widget.intern.dob != null ? DateTime.parse(widget.intern.dob) : null;
    //Giá trị giới tính được chọn mặc định
    selectedGender = widget.intern.gender;
    phoneNumberController.text = widget.intern.phoneNumber;

    majorController.text = widget.intern.major;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _getDownloadUrl() async {
    final ref =
        FirebaseStorage.instance.ref().child('background-mau-xanh-1.jpeg');
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Tùy chỉnh hành vi ở đây trước khi thoát khỏi màn hình.
        // Ví dụ: Hiển thị hộp thoại xác nhận.
        bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confim'),
            content: Text('Are you already update your information?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('YES'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('NO'),
              ),
            ],
          ),
        );

        return confirm; // Trả về true hoặc false tùy thuộc vào sự xác nhận của người dùng.
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Information',
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonFormField<String>(
                        value: universityController,
                         isExpanded: true, // Chỉnh cho DropdownButton hiển thị toàn màn hình
                        items: [
                          DropdownMenuItem<String>(
                            value: 'FPT',
                            child: Text('FPT'),
                          ),
                          DropdownMenuItem<String>(
                            value: "IT",
                            child: Text('Information and Technology University'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'EDT',
                            child: Text('Education Technology University'),
                          )
                        ],
                        onChanged: (value) {
                          setState(() {
                            universityController = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'University',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                     
                      child: ListTile(
                        title: Text('Date of Birth'),
                        subtitle: selectedDate != null
                            ? Text("${selectedDate!.toLocal()}".split(' ')[0])
                            : Text('Select Date'),
                        onTap: () => _selectDate(context),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButtonFormField<int>(
                      value: selectedGender,
                      items: [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text('Female'),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text('Male'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: majorController,
                      decoration: InputDecoration(
                          labelText: 'Major',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Lưu thông tin đã chỉnh sửa và quay lại màn hình trước đó
                        if (fullNameController.text.isEmpty) {
                          fullNameController = TextEditingController(
                              text: widget.intern.fullName); //null
                        }
                        widget.intern.fullName = fullNameController.text;

                        if (universityController == '') {
                          universityController = 'null'; // Gán giá trị mặc định
                        }
                        widget.intern.university = universityController;

                        widget.intern.dob = selectedDate != null
                            ? selectedDate!.toLocal().toString().split(' ')[0]
                            : ''; // Lưu ngày tháng năm vào định dạng chuỗi
                        if (selectedGender == '') {
                          // Gán giá trị mặc định
                        }
                        widget.intern.gender = selectedGender;
                        if (phoneNumberController.text.isEmpty) {
                          phoneNumberController = TextEditingController(
                              text: widget.intern.phoneNumber); //null
                        }
                        widget.intern.phoneNumber = phoneNumberController.text;

                        if (majorController.text.isEmpty) {
                          majorController = TextEditingController(
                              text: widget.intern.major); //null
                        }
                        widget.intern.major = majorController.text;

                        // Gọi API để cập nhật thông tin
                        ApiService().updateInternInformation(widget.intern);
                        Navigator.pop(
                            context,
                            widget
                                .intern); //truyền dữ liệu đã cập nhật về màn hình trước đó
                      },
                      child: Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

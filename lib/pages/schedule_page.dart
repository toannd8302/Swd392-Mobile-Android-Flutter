import 'package:flutter/material.dart';

import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class scheduleContentPage extends StatefulWidget {
  const scheduleContentPage({Key? key}) : super(key: key);

  @override
  State<scheduleContentPage> createState() => _ScheduleContentPageState();
}

class _ScheduleContentPageState extends State<scheduleContentPage> {
  DateTime selectedDay = DateTime.now();

  List<CleanCalendarEvent> _selectedEvents = [];
  final Map<DateTime, List<CleanCalendarEvent>> _events = {};
  


  void _handleData(date) {
    setState(() {
      selectedDay = date;
      _selectedEvents = _events[selectedDay] ?? [];
    });
    
    print(selectedDay);
  }

  @override
  void initState() {
    super.initState();
    // Thêm sự kiện vào các ngày 3/10, 5/10 và 7/10
    _addEvents();
    _selectedEvents = _events[selectedDay] ?? [];
  }

  // Hàm để thêm sự kiện vào các ngày cụ thể
  void _addEvents() {
    DateTime date1 = DateTime(DateTime.now().year, 10, 3);
    DateTime date2 = DateTime(DateTime.now().year, 10, 5);
    DateTime date3 = DateTime(DateTime.now().year, 10, 7);

    _events[date1] = [
      CleanCalendarEvent(
        'Event 1',
        startTime: DateTime(date1.year, date1.month, date1.day, 9, 0),
        endTime: DateTime(date1.year, date1.month, date1.day, 11, 0),
        description: 'A special event 1',
        location: 'Some location',

        color: Colors.orange,
        
      ),
      // Thêm các sự kiện khác vào date1 nếu cần
      CleanCalendarEvent(
        'Event 5',
        startTime: DateTime(date1.year, date1.month, date1.day, 9, 0),
        endTime: DateTime(date1.year, date1.month, date1.day, 11, 0),
        description: 'A special event 1',
        color: Colors.red,
              ),
    ];

    _events[date2] = [
      CleanCalendarEvent(
        'Event 2',
        startTime: DateTime(date2.year, date2.month, date2.day, 10, 0),
        endTime: DateTime(date2.year, date2.month, date2.day, 12, 0),
        description: 'A special event 2',
        color: Colors.blue,
      ),
      // Thêm các sự kiện khác vào date2 nếu cần
    ];

    _events[date3] = [
      CleanCalendarEvent(
        'Event 3',
        startTime: DateTime(date3.year, date3.month, date3.day, 11, 0),
        endTime: DateTime(date3.year, date3.month, date3.day, 13, 0),
        description: 'A special event 3',
        color: Colors.green,
      ),
      // Thêm các sự kiện khác vào date3 nếu cần
      CleanCalendarEvent(
        'Event 7',
        startTime: DateTime(date1.year, date1.month, date1.day, 9, 0),
        endTime: DateTime(date1.year, date1.month, date1.day, 11, 0),
        description: 'A special event 1',
        color: Colors.yellow,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 20),

           child: Calendar(
            /*
            Thuộc tính startOnMonday là một thuộc tính kiểu bool 
            để xác định xem lịch có nên bắt đầu từ thứ Hai (Monday) không. 
            Nếu bạn đặt startOnMonday thành true, lịch sẽ bắt đầu từ thứ Hai 
            và kết thúc vào Chủ Nhật. Nếu bạn đặt thành false (mặc định), 
            lịch sẽ bắt đầu từ Chủ Nhật và kết thúc vào thứ Bảy.
             */
            startOnMonday: true,
            /*
            là màu sắc được sử dụng để làm nổi bật ngày đã chọn trên lịch
             */
            selectedColor: Colors.blue,
            //à màu sắc được sử dụng để làm nổi bật ngày hiện tại 
            todayColor: Colors.red,
            //màu sắc được sử dụng để biểu thị các sự kiện trên lịch
            eventColor: Colors.green,
            // là màu sắc được sử dụng để biểu thị các sự kiện đã hoàn thành trên lịch
            eventDoneColor: Colors.amber,
            bottomBarColor: Colors.deepOrange,
            onRangeSelected: (range){
              print('Selected Day ${range.from}, ${range.to}');
            },
            onDateSelected: (date){
              Navigator.pushNamed(context, '/map');
              return _handleData(date);
            },
            events: _events,
            
            isExpanded: true,
            /*
            Đây là một thuộc tính để định dạng văn bản 
            cho các ngày trong tuần (ngày trong một tháng) trong lịch
             */
            dayOfWeekStyle: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            /*
            Thuộc tính này cho phép bạn định dạng
             văn bản của thanh dưới cùng của lịch.
             */
            bottomBarTextStyle: TextStyle(
              color: Colors.white,
            ),
            //Đây là một thuộc tính kiểu bool 
            //để ẩn hoặc hiện thanh dưới cùng của lịch
            hideBottomBar: false,
            /*
             là một thuộc tính kiểu bool được sử dụng để ẩn 
             hoặc hiện các mũi tên (nút) điều hướng trên lịch
             */
            hideArrows: false,
            //weekDays là một danh sách (List) của các chuỗi được sử dụng 
            //để xác định tên của các ngày trong tuần trong lịch
            weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
           ),
    
          ),
        )
      ),
    );
  }
}

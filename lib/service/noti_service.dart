
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async{
    AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(android: androidInitializationSettings);
    await notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async{

    });
  }

notificationDetails(){
 return const NotificationDetails(
  android: AndroidNotificationDetails(
    'channelId',
    'channelName',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    icon: '@mipmap/ic_launcher' // Sử dụng tên biểu tượng ứng dụng thực sự ở đây
  )
);

}
Future showNotification(
  {int id = 0, String? title,String? body, String? payload})async{
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails());

  }
  Future scheduleNotification(
{int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime ScheduleNotificationDateTime}) async{
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(ScheduleNotificationDateTime, tz.local,),
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  
    }
}
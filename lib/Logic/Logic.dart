import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:study_buddy/Fork/flutter_dnd.dart';
import 'package:study_buddy/Logic/reminderLogic.dart';
import 'package:http/http.dart' as http;

String apiEndPoint = 'https://studybuddy.emilecode.com/default/';
String processingName = '';
List<String> selectedDays = [];
List<String> filteredName = [];
List<String> filteredMessage = [];
List<String> serverQueuMessage = [];
List<String> serverQueuName = [];
List<String> processedMessages = [];
List<String> networkProcessedMessage = [];
List<DateTime> tempMessageTime = [];
List<DateTime> messageTime = [];
//

///[FOR the server side]


Future<int> checkMessageImportance(String messageToProcess) async {
    // for (int i=0; i<processedMessages.length ; i++)
    // {
    //   if (processedMessages[i].startsWith(messageToProcess))
    //   {
    //      print('we already processed $messageToProcess no further processing required');
    //     return 0;
    //   }
    // }

  print('Processing: $messageToProcess');
  var response = await http.get(apiEndPoint + messageToProcess);
  var responseBody;
  print('The serveer response code is ${response.statusCode}');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    responseBody = jsonDecode(response.body);

    return responseBody['output'] as int;
  } else {
    //mostly a server error has occured and the message cannot be processed at this time
    // the rational way of managing this will be to create another temporary list to hold the message and check later
    // but since it is just a simple application i will just return that the message is not important
    return 0;
  }
}

//
///[FOr the remainder page]
Future<void> setRemainderRepeat(
    {@required String day,
    @required DateTime atTime,
    @required String description,
    @required int id}) async {
  Day requestedDay = getDayEnumerationFromDay(day);
  var time = Time(atTime.hour, atTime.minute, 0);
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '$day reminder', 'Weekly Reminder', 'Study reminder');
  await AndroidFlutterLocalNotificationsPlugin().showWeeklyAtDayAndTime(
      id,
      'Your $day Study reminder',
      description,
      requestedDay,
      time,
      androidPlatformChannelSpecifics);
}

Future<void> setRemainderOnce() async {}

void addReminderToDataBase(
    {@required List<int> reminderIds,
    @required List<String> days,
    @required String frequency,
    @required DateTime atTime,
    @required String title}) async {
  final DateFormat format = DateFormat.jm();

  ReminderLogic remLog = ReminderLogic(
      frequency: frequency,
      time: format.format(atTime),
      reminderIds: reminderIds,
      title: title);
  days.forEach((element) {
    print('adding $element');
    remLog.daysToRemind.add(element);
  });
  
  final hiveReminderBox = Hive.box('reminderBox');
  await hiveReminderBox.add(remLog);
}

Day getDayEnumerationFromDay(String day) {
  switch (day) {
    case 'Monday':
      return Day.Monday;
      break;
    case 'Tuesday':
      return Day.Tuesday;
      break;
    case 'Wednesday':
      return Day.Wednesday;
      break;
    case 'Thursday':
      return Day.Thursday;
      break;
    case 'Friday':
      return Day.Friday;
      break;
    case 'Saturday':
      return Day.Saturday;
      break;
    case 'Sunday':
      return Day.Sunday;
      break;

    default:
      return Day.Monday;
  }
}

///[FOR THE NOTIFICATION]

//we will disable dnd then send the notification then disable it again
Future<void> sendNotification({@required String withName, @required String andMessage , @required bool forceNotif})async{
  if(forceNotif == false)
  {
    if(networkProcessedMessage.contains(andMessage))
  {
    if (processingName == withName)
    {
      return;
    }
    
  }
  }
  processingName = withName;
  networkProcessedMessage.add(andMessage);
  if (await FlutterDnd.isNotificationPolicyAccessGranted) {
    await FlutterDnd.setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL).then((value) async {
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'Study97', 'Study buddy', 'Studying period',
    importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
      AndroidFlutterLocalNotificationsPlugin().show(1 + Random().nextInt(2000),'Study buddy:important notification', '$withName sent:\n$andMessage',notificationDetails: androidPlatformChannelSpecifics);
    }).then((value) async =>
            await Future.delayed(Duration(milliseconds: 1800), () async {
              processingName = '';
              await FlutterDnd.setInterruptionFilter(
                  FlutterDnd.INTERRUPTION_FILTER_NONE);
                  
            })); // Turn on DND - All notifications are suppressed.
  } else {
    FlutterDnd.gotoPolicySettings();
  }
}

void clearAllList() {
  filteredName.clear();
  filteredMessage.clear();
  serverQueuMessage.clear();
  serverQueuName.clear();
  tempMessageTime.clear();
  messageTime.clear();
}

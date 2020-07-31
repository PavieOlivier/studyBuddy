import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:study_buddy/Screens/HomeScreen/HomeScreen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'Logic/Logic.dart';
import 'Logic/reminderLogic.dart';
import 'Screens/BootScreen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDirectory = await  path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDirectory.path);
  Hive.registerAdapter(ReminderLogicAdapter());
  await Hive.openBox('reminderBox');
 // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initNotif();
  }

  void initNotif() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (number, string1, string2, string3) {
      //TODO: Check these string
      return;
    });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (notificationName) {
          //TODO: just check here later on
          return ;
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Buddy',
      theme: ThemeData(
        primaryColor: Colors.orange[200],
      ),
      home: BootScreen(),
      //home: HomeScreen(),
      //home: StudyingScreen(),
      //home: ReminderScreen(),
    );
  }
}

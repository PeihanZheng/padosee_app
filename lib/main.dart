import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:padosee/constants/theme/theme_manager.dart';
import 'package:padosee/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // _foregroundNotification(
  //   message.notification!.title ?? "PadoSee App",
  //   message.notification!.body ?? "",
  //   message.data["screen"],
  // );
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future onSelectNotification(String? data) async {
  if (data == "alerts_page") {
    Get.toNamed('/alerts-page');
  } else if (data == "messages") {
    Get.toNamed('/messages');
  }
}

Future<void> _foregroundNotification(String title, String body, String payload) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
    priority: Priority.high,
    //ticker: 'test ticker',
  );

  var iOSChannelSpecifics = const IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformChannelSpecifics,
    payload: payload,
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  runApp(const MyApp());
  // });
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

ThemeManager themeManager = ThemeManager();
var uuid = const Uuid();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging? _messaging;
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true,
  );

  @override
  void dispose() {
    themeManager.removeListener(themeListner);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themeListner);
    checkTheme();
    super.initState();

    setupInteractedMessage();
    var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = const IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );
  }

  themeListner() {
    if (mounted) {
      setState(() {});
    }
  }

  checkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("darkMode")) {
      if (prefs.getBool("darkMode")!) {
        setState(() {
          themeManager.themeChange = ThemeMode.dark;
        });
      } else {
        setState(() {
          themeManager.themeChange = ThemeMode.light;
        });
      }
    } else {
      setState(() {
        themeManager.themeChange = ThemeMode.light;
      });
    }
  }

  void registerNotification() async {
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    _messaging!.getToken().then((token) async {
      print(token);
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();

    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          _foregroundNotification(
            notification.title ?? "PadoSee App",
            notification.body ?? "",
            message.data["screen"],
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((message) {});
    } else {
      print('User declined or has not accepted permission');
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    checkForInitialMessage();
  }

  setupInteractedMessage() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    registerNotification();
  }

  checkForInitialMessage() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      print("message.data");
      print(message.data);
      print("title: ${message.notification?.title}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PadoSee',
      // theme: lightTheme,
      // darkTheme: dartTheme,
      themeMode: themeManager.themeMode,
      initialRoute: '/',
      getPages: Routes.routes,
    );
  }
}

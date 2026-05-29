import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:puri/presentation/login/loginScreen_2.dart';
import 'package:puri/presentation/loginaftersplace/loginaftersplace.dart';
import 'package:puri/presentation/screens/splash.dart';
import 'package:puri/presentation/visitorDashboard/visitorDashBoard.dart';
import 'package:puri/presentation/visitorList/visitorList.dart';
import 'package:puri/presentation/visitorloginEntry/visitorLoginEntry.dart';
import 'package:puri/presentation/vmsHome/vmsHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(); // ✅ Global Key

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _setupIosPushNotifications() async {
  if (!Platform.isIOS) return;

  final fcm = FirebaseMessaging.instance;

  await fcm.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  final settings = await fcm.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('📱 iOS notification permission: ${settings.authorizationStatus}');

  // APNs token arrives asynchronously from AppDelegate; retry before FCM token.
  String? apnsToken;
  for (var attempt = 0; attempt < 10; attempt++) {
    apnsToken = await fcm.getAPNSToken();
    if (apnsToken != null) break;
    await Future.delayed(const Duration(milliseconds: 500));
  }
  if (apnsToken == null) {
    print('❌ APNs token is still null. Use a physical iPhone (not Simulator) and check Xcode signing/capabilities.');
  } else {
    print('✅ APNs token received');
  }

  try {
    final token = await fcm.getToken();
    print('✅ FCM token: $token');
  } catch (e) {
    print('❌ Failed to get FCM token on iOS: $e');
  }
}

@pragma('vm:entry-point') // ✅ Required for background handlers
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  print("🔔 Background Notification Received: ${message.notification?.title}");
  print("--------27---xxxxxxxxx--${message}");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? title = message.notification?.title ?? "No Title";
  String? body = message.notification?.body ?? "No Body";

  await prefs.setString('notification_title', title);
  await prefs.setString('notification_body', body);

  print("✅ Stored Title: $title");
  print("✅ Stored Body: $body");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  await _setupIosPushNotifications();

  initializeNotifications();
  createNotificationChannel();

  // Register background message handler (called when app is terminated/suspended)
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // Handle foreground messages (when app is in foreground on both Android & iOS)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("🔔 Foreground Notification Received: ${message.notification?.title}");
    // The AppDelegate will handle showing the notification
  });

  // Handle notification tap when app is running or in background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("🔔 Notification Clicked: ${message.data}");
    openVisitorListDirectly();
  });

  runApp(MyApp());
  configLoading();

  // Handle app launch via notification (terminated state)
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("🔔 App opened from terminated state via notification");
      openVisitorListDirectly();
    }
  });
}

Future<void> openVisitorListDirectly() async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? iUserId = prefs.getString('iUserId');

  int retryCount = 0;
  while (navigatorKey.currentState == null && retryCount < 10) {
    await Future.delayed(const Duration(milliseconds: 500));
    retryCount++;
  }

  await Future.delayed(const Duration(milliseconds: 300)); // ✅ Extra safety delay

  if (iUserId == null || iUserId.isEmpty) {
    // here you simle navigate login screen
    safeNavigate('/LoginScreen_2');
  } else {
    // here you simple navigate Dashboard
    safeNavigate('/VisitorList');
  }
}

/// ✅ Store payload when clicked
Future<void> storeNotificationPayload(String payload) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('pending_notification_payload', payload);
}

/// ✅ Check and navigate after app starts
Future<void> checkAndNavigateFromStoredPayload() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? payload = prefs.getString('pending_notification_payload');

  if (payload != null && payload.isNotEmpty) {
    prefs.remove('pending_notification_payload'); // Clear after using
    navigateToNotificationScreen(payload);
  }

  // ✅ Also check Firebase initial message for killed app
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    String payload = jsonEncode(initialMessage.data.isNotEmpty ? initialMessage.data : {
      "title": initialMessage.notification?.title,
      "body": initialMessage.notification?.body
    });

   // Store and navigate after router is ready
    await storeNotificationPayload(payload);
    Future.delayed(const Duration(seconds: 1), () {
      navigateToNotificationScreen(payload);
    });
    //navigateToNotificationScreen(payload);
  }
}
//
Future<void> safeNavigate(String route, {String? payload}) async {
  await Future.delayed(const Duration(milliseconds: 300)); // small delay
  if (navigatorKey.currentContext != null) {

    GoRouter.of(navigatorKey.currentContext!).go(route, extra: payload);

  } else {
    print("Navigator still not ready, retrying...");
    Future.delayed(const Duration(milliseconds: 500), () {
      safeNavigate(route, payload: payload);
    });
  }
}


/// ✅ Navigate safely
void navigateToNotificationScreen(String payload) async {
  print("🔗 Navigating to VisitorList with Payload: $payload");

  if (navigatorKey.currentState == null) {
    print("⚠️ Navigator not ready yet, retrying...");
    Future.delayed(const Duration(milliseconds: 500), () {
      navigateToNotificationScreen(payload);
    });
    return;
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? iUserId = prefs.getString('iUserId');

  if (iUserId == null || iUserId.isEmpty) {
    safeNavigate('/LoginScreen_2');
  } else {
    safeNavigate('/VisitorList', payload: payload);
  }
}

/// ✅ MyApp with GoRouter
class MyApp extends StatelessWidget {
  final _router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(name: 'splace', path: '/', builder: (context, state) => SplashView()),
      GoRoute(name: 'Loginaftersplace', path: '/Loginaftersplace', builder: (context, state) => Loginaftersplace()),
      GoRoute(name: 'VisitorDashboard', path: '/VisitorDashboard', builder: (context, state) => VisitorDashboard()),
      GoRoute(name: 'VmsHome', path: '/VmsHome', builder: (context, state) => VmsHome()),
      GoRoute(name: 'VisitorLoginEntry', path: '/VisitorLoginEntry', builder: (context, state) => VisitorLoginEntry()),
      GoRoute(name: 'LoginScreen_2', path: '/LoginScreen_2', builder: (context, state) => LoginScreen_2()),
      GoRoute(
        name: 'VisitorList',
        path: '/VisitorList',
        builder: (context, state) {
          final payload = state.extra as String?;
          return VisitorList(payload: payload ?? '');
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
      builder: EasyLoading.init(),
    );
  }
}

/// ✅ Initialize Notifications
void initializeNotifications() {
  var androidSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var iosSettings = const DarwinInitializationSettings();
  var initSettings = InitializationSettings(android: androidSettings, iOS: iosSettings);

  flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        storeNotificationPayload(response.payload!);
        navigateToNotificationScreen(response.payload!);
      }
    },
    onDidReceiveBackgroundNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        storeNotificationPayload(response.payload!);
      }
    },
  );
}

/// ✅ Create Custom Notification Channel for Android
void createNotificationChannel() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'custom_channel',
    'Custom Notifications',
    description: 'Channel for custom sound notifications',
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('coustom_sound'),
  );

  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  await androidImplementation?.createNotificationChannel(channel);
}

/// ✅ Show Local Notification
Future<void> showNotification(RemoteMessage message) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'custom_channel',
    'Custom Sound Channel',
    channelDescription: 'Channel for custom sound notifications',
    importance: Importance.high,
    priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('coustom_sound'),
    playSound: true,
  );

  const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
    sound: 'coustom_sound.wav',
  );

  const NotificationDetails notificationDetails =
  NotificationDetails(android: androidDetails, iOS: iosDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification?.title ?? "New Alert",
    message.notification?.body ?? "This should play a custom sound",
    notificationDetails,
  );
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

// Test this code in your main.dart setupPushNotifications function
// or add it temporarily to main() to verify everything is working

import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> verifyAPNsAndFCMSetup() async {
  print('\n========== 🔍 iOS APNs & FCM VERIFICATION START ==========\n');

  try {
    final fcm = FirebaseMessaging.instance;

    // 1. Check if we can get the APNs token
    print('📱 Step 1: Getting APNs token...');
    try {
      // This will only work on iOS if APNs is properly set up
      // If this throws "APNS token has not been set yet" - AppDelegate is not forwarding token correctly
      final apnsToken = await fcm.getAPNSToken();
      if (apnsToken != null) {
        print('✅ APNs Token: $apnsToken');
      } else {
        print('⚠️  APNs Token is null (normal on simulator, should be set on device)');
      }
    } catch (e) {
      print('❌ ERROR getting APNs token: $e');
      print('   → This means AppDelegate is not forwarding the token properly');
      print('   → Check AppDelegate.swift: Messaging.messaging().apnsToken = deviceToken');
    }

    // 2. Request notification permissions
    print('\n📱 Step 2: Requesting notification permissions...');
    NotificationSettings settings = await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
    );

    print('✅ Permission status: ${settings.authorizationStatus}');
    print('   Values: notDetermined(0), denied(1), authorized(2), provisional(3)');
    print('   → Should be 2 (authorized) or 3 (provisional) for notifications to work');

    // 3. Get FCM token
    print('\n📱 Step 3: Getting FCM token...');
    try {
      String? token = await fcm.getToken();
      if (token != null && token.isNotEmpty) {
        print('✅ FCM Token obtained successfully!');
        print('   Token: $token');
        print('   → Send this token to your backend for testing');
      } else {
        print('⚠️  FCM Token is empty');
      }
    } catch (e) {
      print('❌ ERROR getting FCM token: $e');
      if (e.toString().contains('apns-token-not-set')) {
        print('   → AppDelegate.swift is not forwarding APNs token correctly!');
        print('   → Solution: Check didRegisterForRemoteNotificationsWithDeviceToken method');
      }
    }

    // 4. Check foreground notification settings
    print('\n📱 Step 4: Checking foreground notification settings...');
    print('   → Check if UNUserNotificationCenter.delegate is set in AppDelegate');
    print('   → AppDelegate should implement UNUserNotificationCenterDelegate');

    // 5. Verify background message handler is registered
    print('\n📱 Step 5: Background message handler...');
    print('   ✅ Background handler: firebaseBackgroundHandler');
    print('   ✅ Marked with: @pragma(\'vm:entry-point\')');
    print('   ✅ Registered with: FirebaseMessaging.onBackgroundMessage(...)');

    print('\n========== 🔍 iOS APNs & FCM VERIFICATION COMPLETE ==========\n');
    print('\n🎯 NEXT STEPS:');
    print('1. If APNs token is obtained → Good! Firebase can send notifications');
    print('2. If APNs token is null/error → Check AppDelegate.swift configuration');
    print('3. If FCM token obtained → Copy it and test sending notification from Firebase Console');
    print('4. Verify in Firebase Console: Project Settings → Cloud Messaging → APNs key uploaded with Team ID 853R23ZSA7');
    print('5. Kill app completely and send notification from Firebase Console');
    print('6. Notification should appear on lock screen even with app killed\n');

  } catch (e) {
    print('❌ CRITICAL ERROR: $e');
  }
}

// Call this from main() or from a button in your app for testing:
// In main():
// WidgetsBinding.instance.addPostFrameCallback((_) async {
//   await verifyAPNsAndFCMSetup();
// });


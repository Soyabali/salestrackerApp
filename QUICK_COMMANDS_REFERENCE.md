# iOS Background Notifications Fix: Quick Commands Reference

## One-Time Setup Commands

Run these in order from the project root:

```bash
# 1. Navigate to project root
cd /Users/synergy/Documents/application/Visitor-Management-System-main

# 2. Clean Flutter
flutter clean

# 3. Clean and reinstall pods
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..

# 4. Open Xcode workspace (NOT .xcodeproj)
open ios/Runner.xcworkspace

# 5. In Xcode (GUI, can't automate):
#    → Select Runner target
#    → Signing & Capabilities tab
#    → Verify Team: 853R23ZSA7
#    → Add Push Notifications capability
#    → Add Background Modes capability
#    → Check Remote notifications in Background Modes
#    → Close Xcode

# 6. Build iOS
flutter build ios --release

# 7. Or run on device directly
flutter run -d <device_id>
```

---

## Testing Commands

### Get FCM Token (add to your app temporarily)

```dart
import 'package:firebase_messaging/firebase_messaging.dart';

void testFCMToken() async {
  final fcm = FirebaseMessaging.instance;
  
  // Request permission
  await fcm.requestPermission();
  
  // Get APNs token
  String? apnsToken = await fcm.getAPNSToken();
  print("APNs Token: $apnsToken");
  
  // Get FCM token
  String? fcmToken = await fcm.getToken();
  print("FCM Token: $fcmToken");
}
```

### Monitor Xcode Logs (real device)

```bash
# Connect device, then:
open ios/Runner.xcworkspace

# In Xcode: Product → Scheme → Edit Scheme → Run → Arguments
# Add environment variable: OS_ACTIVITY_MODE = disable

# Or use command line:
cd ios
xcodebuild -workspace Runner.xcworkspace -scheme Runner -configuration Debug -derivedDataPath build | grep -i notification
```

---

## Firebase Console Setup (Manual Steps)

### Step 1: Create APNs Key
1. Go to https://developer.apple.com
2. Certificates, IDs & Profiles → Keys
3. Create new key → Enable "Apple Push Notifications service (APNs)"
4. Download .p8 file
5. Note the Key ID (e.g., XX1234ABCD)

### Step 2: Upload to Firebase
1. Go to https://console.firebase.google.com
2. Select project → Project Settings → Cloud Messaging tab
3. iOS app configuration → APNs section
4. Upload .p8 file
5. Enter Key ID: (your Key ID from step 1)
6. Enter Team ID: 853R23ZSA7
7. Click Save

### Verify
- Should see ✅ checkmark next to APNs key
- Team ID should show: 853R23ZSA7

---

## Verification Checklist

Run these checks:

### Check 1: AppDelegate Has Required Code
```bash
grep -n "Messaging.messaging().apnsToken" ios/Runner/AppDelegate.swift
# Should return a line number (if no output, it's missing - FIX!)
```

### Check 2: Background Handler Exists
```bash
grep -n "firebaseBackgroundHandler" lib/main.dart
# Should return multiple lines (handler definition + registration)
```

### Check 3: Info.plist Has Background Modes
```bash
grep -A2 "UIBackgroundModes" ios/Runner/Info.plist
# Should show:
# <key>UIBackgroundModes</key>
# <array>
#     <string>fetch</string>
#     <string>remote-notification</string>
```

### Check 4: Entitlements Have APNs Environment
```bash
grep "aps-environment" ios/Runner/RunnerDebug.entitlements
# Should show: <string>development</string>
```

---

## If Notifications STILL Don't Work

### 1. Check AppDelegate Logs
```bash
# Build and run on device
flutter run -d <device_id>

# Watch console for:
# "Registered for remote notifications" (success)
# "Failed to register for remote notifications" (error)
```

### 2. Check Firebase Console APNs
```bash
# In Firebase: Project Settings → Cloud Messaging
# Look for APNs section - should have:
# ✅ APNs Key uploaded
# ✅ Key ID: XX1234ABCD (from Apple Developer)
# ✅ Team ID: 853R23ZSA7
```

### 3. Check Xcode Build Settings
```bash
# In Xcode: Runner target → Build Settings
# Search for: "PROVISIONING_PROFILE"
# Should match team 853R23ZSA7 in the profile name
```

### 4. Delete Old Profiles and Rebuild
```bash
# Remove old provisioning profiles
rm ~/Library/MobileDevice/Provisioning\ Profiles/*

# Clean and rebuild
flutter clean
cd ios && pod install && cd ..
flutter build ios --release
```

### 5. Get Device Logs for Debugging
```bash
# Connect device
# In Xcode: Window → Devices and Simulators
# Select device → View device logs
# Look for errors mentioning APNs or notification

# Or use command line:
log stream --predicate 'eventMessage contains[c] "apns"' --level debug
```

---

## Common Error Messages & Fixes

### "APNS token has not been set yet"
```
Fix: AppDelegate.swift must have:
    Messaging.messaging().apnsToken = deviceToken
in didRegisterForRemoteNotificationsWithDeviceToken method
```

### "No Account for Team 853R23ZSA7"
```
Fix: Xcode → Preferences → Accounts
     Sign in with Apple ID that owns team 853R23ZSA7
     Verify team shows under that account
```

### "No profiles for 'com.synergy.synvmss' were found"
```
Fix: 1. Ensure Bundle ID in Xcode matches Firebase iOS app
     2. Delete: rm ~/Library/MobileDevice/Provisioning\ Profiles/*
     3. In Xcode: Re-enable Automatic signing
     4. Xcode will regenerate profiles
```

### "Signing for "Runner" requires a development team"
```
Fix: Xcode → Runner target → Signing & Capabilities
     Set Team dropdown to: SYNERGY TELEMATICS PRIVATE LIMITED (853R23ZSA7)
```

---

## File Changes Summary

### Modified Files (Already Done)
```
✅ ios/Runner/AppDelegate.swift
   └─ Added Firebase init
   └─ Added APNs token forwarding
   └─ Added UNUserNotificationCenterDelegate

✅ lib/main.dart
   └─ Added onMessage listener
   └─ Removed duplicate initialization
```

### Configuration Files (Already Correct - No Changes Needed)
```
✓ ios/Runner/Info.plist (UIBackgroundModes already set)
✓ ios/Runner/Runner.entitlements (aps-environment already set)
✓ ios/Runner/RunnerDebug.entitlements (aps-environment already set)
```

---

## After All Fixes Are Done

### Test Sequence:
1. Kill app completely (swipe up from home bar)
2. App should NOT be running
3. Send test notification from Firebase Console
4. Notification should appear on lock screen
5. Tap it → app launches and shows notification

### Expected Logs:
```
✅ APNs token set successfully
✅ Firebase initialized
✅ Background notification received
✅ Notification displayed
```

---

## Support

If stuck:
1. Run: `flutter build ios --verbose` and save output
2. Paste last 50 lines of build output
3. Paste Firebase Console Cloud Messaging screenshot
4. Confirm Team ID: `853R23ZSA7` matches everywhere
5. Paste Xcode device console error (if any)



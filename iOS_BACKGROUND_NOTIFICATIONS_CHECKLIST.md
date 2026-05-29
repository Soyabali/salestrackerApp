# iOS Background Notifications Fix Checklist

## What Was Fixed

### 1. **AppDelegate.swift** ✅
- ✅ Added `import Firebase` and `import UserNotifications`
- ✅ Made AppDelegate conform to `UNUserNotificationCenterDelegate`
- ✅ Added `FirebaseApp.configure()` call in `didFinishLaunchingWithOptions`
- ✅ Set `UNUserNotificationCenter.current().delegate = self`
- ✅ Called `application.registerForRemoteNotifications()` to request APNs token
- ✅ **CRITICAL**: Implemented `didRegisterForRemoteNotificationsWithDeviceToken` to forward APNs token to Firebase Messaging:
  ```swift
  Messaging.messaging().apnsToken = deviceToken
  ```
  **Why**: Without this, Firebase won't get the APNs token, and background notifications won't work on iOS.

### 2. **main.dart** ✅
- ✅ Added missing `FirebaseMessaging.onMessage.listen()` for foreground notifications
- ✅ Removed duplicate `addPostFrameCallback` calls
- ✅ Kept `FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler)` correctly set with `@pragma('vm:entry-point')`
- ✅ Kept `FirebaseMessaging.onMessageOpenedApp.listen()` for notification tap handling
- ✅ Kept `getInitialMessage()` for terminated state handling

### 3. **Configuration Files** ✅ (Already Correct)
- ✅ `Info.plist` has `UIBackgroundModes` with both `fetch` and `remote-notification`
- ✅ `Runner.entitlements` has `aps-environment` = `production`
- ✅ `RunnerDebug.entitlements` has `aps-environment` = `development`

---

## Critical Requirements for iOS Background Notifications

### **1. Firebase Configuration** ✅
- [x] Firebase initialized in AppDelegate before other code
- [x] APNs token forwarded to Messaging: `Messaging.messaging().apnsToken = deviceToken`
- [x] Background message handler registered: `FirebaseMessaging.onBackgroundMessage(...)`
- [x] Handler marked with `@pragma('vm:entry-point')`

### **2. APNs Setup in Firebase Console** ⚠️ **YOU MUST DO THIS**
Go to: **Firebase Console** → **Project Settings** → **Cloud Messaging** → **iOS app configuration**

**Option A: Upload APNs Key (.p8) - RECOMMENDED**
1. Go to [Apple Developer](https://developer.apple.com) → **Keys** → **Create a key**
2. Enable "Apple Push Notifications service (APNs)"
3. Download the `.p8` file and note the **Key ID**
4. In Firebase Console:
   - Upload the `.p8` file
   - Enter Key ID (from Apple Developer)
   - Enter Team ID: `853R23ZSA7`

**Option B: Upload APNs Certificate (less recommended)**
1. Create an APNs certificate in Apple Developer for your bundle ID
2. Download `.cer`, convert to `.p8`, and upload to Firebase

**⚠️ Common Issue**: If the wrong Team ID is in Firebase (like `74LKLX2CHU`), background notifications won't work. **Ensure Team ID is `853R23ZSA7` in Firebase.**

### **3. Xcode Project Configuration** ⚠️ **VERIFY IN XCODE**
1. Open `ios/Runner.xcworkspace` (NOT `.xcodeproj`)
2. Select **Runner target** → **Signing & Capabilities** tab
3. Verify:
   - [ ] **Team**: Set to `SYNERGY TELEMATICS PRIVATE LIMITED (853R23ZSA7)`
   - [ ] **Bundle Identifier**: Matches the iOS app in Firebase (e.g., `com.synergy.synvmss`)
   - [ ] **Automatically manage signing**: Checked
   - [ ] **Capability: Push Notifications**: Added (click + → Search "Push" → Add)
   - [ ] **Capability: Background Modes**: Added
     - [ ] ✓ Remote notifications
     - [ ] ✓ Background fetch (optional but recommended)

### **4. Entitlements** ✅
- [x] `Runner.entitlements` has `aps-environment` = `production` (for TestFlight/App Store)
- [x] `RunnerDebug.entitlements` has `aps-environment` = `development` (for debug builds)
- [ ] Verify in Xcode that entitlements file is selected in Signing & Capabilities

### **5. Info.plist** ✅
- [x] `UIBackgroundModes` array contains:
  - [x] `remote-notification`
  - [x] `fetch`

### **6. GoogleService-Info.plist** ⚠️ **VERIFY**
- [ ] File exists at `ios/Runner/GoogleService-Info.plist`
- [ ] Downloaded from Firebase Console for your iOS app (matching bundle ID)
- [ ] Added to Xcode project under Runner target (in Xcode Project Navigator)

---

## What You Need to Do Now

### **Step 1: Build and Clean**
```bash
cd /Users/synergy/Documents/application/Visitor-Management-System-main

# Clean Flutter build
flutter clean

# Reinstall pods
cd ios
rm -rf Pods Podfile.lock
pod install

cd ..
```

### **Step 2: Open Xcode and Verify Configuration**
```bash
open ios/Runner.xcworkspace
```
**In Xcode**:
1. Select **Runner** target → **Signing & Capabilities**
2. Verify Team is `SYNERGY TELEMATICS PRIVATE LIMITED (853R23ZSA7)`
3. Add **Push Notifications** capability if not present
4. Add **Background Modes** capability with **Remote notifications** checked
5. Close Xcode

### **Step 3: Verify Firebase Configuration** ⚠️ **IMPORTANT**
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project → **Project Settings** → **Cloud Messaging**
3. Under **iOS app configuration**:
   - [ ] APNs key (`.p8`) is uploaded
   - [ ] Key ID is correct
   - [ ] Team ID shows `853R23ZSA7` (not the old `74LKLX2CHU`)
4. If wrong Team ID is shown:
   - Remove the old APNs certificate/key
   - Create a new APNs key with the correct Team `853R23ZSA7`
   - Upload it to Firebase

### **Step 4: Build and Test**
```bash
# Build iOS app
flutter build ios --release

# Or run on device directly
flutter run -d <device_id>
```

**Watch the Xcode console for**:
```
✅ Registered for remote notifications
✅ APNs token set successfully
```

### **Step 5: Test Background Notification**
1. Build and install app on a real iOS device
2. Kill the app completely (swipe up to close)
3. Send a test notification from Firebase Console or your backend
4. **Notification should appear on lock screen**
5. Tap it — app should launch and show the notification screen

---

## Common Issues & Solutions

### **Issue: "APNS token has not been set yet"**
**Cause**: AppDelegate not forwarding APNs token to Firebase
**Fix**: Ensure this line is in AppDelegate:
```swift
Messaging.messaging().apnsToken = deviceToken
```

### **Issue: No notifications in background**
**Cause 1**: APNs not configured in Firebase with correct Team ID
**Fix**: Upload APNs key to Firebase with Team ID `853R23ZSA7`

**Cause 2**: Wrong aps-environment in entitlements
**Fix**: 
- Debug builds: `RunnerDebug.entitlements` → `aps-environment` = `development`
- Release builds: `Runner.entitlements` → `aps-environment` = `production`

**Cause 3**: Background Modes capability not enabled in Xcode
**Fix**: Runner target → Signing & Capabilities → Add "Background Modes" → Check "Remote notifications"

**Cause 4**: Notification payload missing `content-available: 1`
**Fix**: Ensure your backend/Firebase sends this in APNs payload:
```json
{
  "aps": {
    "content-available": 1,
    "mutable-content": 1,
    "alert": {
      "title": "...",
      "body": "..."
    }
  }
}
```

### **Issue: "No Account for Team 853R23ZSA7"**
**Cause**: Apple ID with that Team not added to Xcode
**Fix**:
1. Xcode → Preferences → Accounts
2. Click + → Sign in with Apple ID that owns Team `853R23ZSA7`
3. Verify Team appears under that Apple ID
4. In Xcode, reselect the team in Signing & Capabilities

### **Issue: Wrong Team (like 74LKLX2CHU) keeps appearing**
**Cause**: Old provisioning profiles or wrong certificate
**Fix**:
```bash
# Delete old provisioning profiles
rm ~/Library/MobileDevice/Provisioning\ Profiles/*

# Reopen Xcode, re-enable automatic signing
# Xcode will regenerate profiles for correct team
```

---

## Verification Commands

### **Check FCM Token is obtained (run this in your app)**
```dart
FirebaseMessaging messaging = FirebaseMessaging.instance;
String? token = await messaging.getToken();
print("FCM Token: $token");
```

### **Check APNs Token is set (watch Xcode console)**
When app launches, you should see logs like:
```
✅ APNs token set: <hex_token>
```

### **Verify background handler is called**
In Flutter console when you send a background notification (with app killed):
```
🔔 Background Notification Received: <title>
✅ Stored Title: <title>
✅ Stored Body: <body>
```

---

## What Changed (Summary)

| File | Change | Why |
|------|--------|-----|
| `ios/Runner/AppDelegate.swift` | Added Firebase init, APNs token forwarding, UNUserNotificationCenterDelegate | **Critical**: Enables iOS to handle background notifications |
| `lib/main.dart` | Added `onMessage` listener, removed duplicate init | Ensures foreground notifications work properly |
| `ios/Runner/Info.plist` | ✅ Already correct (no changes needed) | Already has Background Modes configured |
| `ios/Runner/*.entitlements` | ✅ Already correct (no changes needed) | Already has correct aps-environment |

---

## Final Checklist Before Testing

- [ ] AppDelegate.swift has `FirebaseApp.configure()`
- [ ] AppDelegate.swift has `Messaging.messaging().apnsToken = deviceToken` in `didRegisterForRemoteNotificationsWithDeviceToken`
- [ ] main.dart has `FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler)`
- [ ] Firebase Console has APNs key uploaded with Team ID `853R23ZSA7`
- [ ] Xcode Project has Team set to `853R23ZSA7` with Automatic signing enabled
- [ ] Xcode Project has Push Notifications capability added
- [ ] Xcode Project has Background Modes capability with Remote notifications checked
- [ ] `GoogleService-Info.plist` exists and is in Xcode project
- [ ] `Info.plist` has `UIBackgroundModes` with `remote-notification`
- [ ] Pod install completed successfully
- [ ] No build errors in Xcode

Once all items are checked, build and test on a real device.

---

## Support
If notifications still don't work after this:
1. Paste Xcode console output (build and run)
2. Paste Firebase Console Cloud Messaging config screenshot
3. Confirm Team ID matches everywhere (Xcode, Firebase, Apple Developer)
4. Run: `flutter build ios --verbose` and paste last 50 lines of output


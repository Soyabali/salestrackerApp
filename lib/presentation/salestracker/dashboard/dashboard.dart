import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/customdrawer.dart';
import '../../../app/generalFunction.dart';
import '../../../main.dart';
import '../../../services/vmsUpdateGsmId.dart';


class DashBoardSalesTrackerHome extends StatefulWidget {
  const DashBoardSalesTrackerHome({super.key});

  @override
  State<DashBoardSalesTrackerHome> createState() => _DashBoardSalesTrackerHomeState();
}

class _DashBoardSalesTrackerHomeState extends State<DashBoardSalesTrackerHome> {

  GeneralFunction generalFunction = GeneralFunction();
  var sUserName;
  var sContactNo;
  var token;
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    getLocaData();
    setupPushNotifications();
    super.initState();
  }
  getLocaData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sUserName = prefs.getString('sUserName');
    sContactNo = prefs.getString('sContactNo');
    setState(() {

    });
    print("----------33--$sUserName");
    print("----------34--$sContactNo");
  }


  //notification code
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    token = await fcm.getToken();
    print("📌 Token: $token");
    // call Gsmid
    updateGsmid();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📦 Data Payload: ${message.data}");
      playNotificationSound();

      if (message.notification != null) {
        var title = message.notification!.title ?? "New Notification";
        var body = message.notification!.body ?? "You have received a new message";

        print("🔔 Foreground Notification Received: $title - $body");
        playNotificationSound();
        // Show notification dialog (User must click "OK" to proceed)
        _showNotificationDialog(title, body);
      }
    });
  }
  //
  updateGsmid()async{
    if(token!=null){
      var UpdateGsmid = await VmsUpdateGsmid().vmsUpdateGsmid(context,token);
      print("-------Update Gsmid--------105-----$UpdateGsmid");
    }else{

    }
  }
  // notification Dialog
  void _showNotificationDialog(String title, String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // Prevents user from closing manually
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded Dialog
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent], // Attractive gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Notification Icon
                Icon(Icons.notifications_active, size: 50, color: Colors.white),
                SizedBox(height: 10),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),

                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 15),

                // Custom Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                    backgroundColor: Colors.amberAccent, // Attractive button color
                    elevation: 5,
                  ),
                  onPressed: () {
                    _stop(); // Stop sound
                    // call api
                    // getLocatDataBase();
                    Navigator.pop(context); // Close Dialog
                    //_navigateToVisitorList(title, message); // Navigate to new screen
                  },
                  child: Text(
                    "View",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //
  Future<void> _stop() async {
    await player.stop();// Force stop the sound
  }
  // play notification
  void playNotificationSound() async {
    await player.stop(); // Stop any previous sound
    await player.release(); // Release resources
    await player.setVolume(0.5);
    await player.play(AssetSource('sounds/coustom_sound.wav'), mode: PlayerMode.mediaPlayer);

    // Automatically stop the sound after 2 seconds
    Future.delayed(Duration(seconds: 2), () async {
      await player.stop();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Sales Tracker"), actions: <Widget>[
        ],),
      //drawer: generalFunction.drawerFunction_2(context,"$sUserName","$sContactNo"),
      drawer: const CustomDrawer(),

      body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Center(
             child: Text('Container', style: TextStyle(
               color: Colors.black,
               fontSize: 20
             ),),
           )
        ],
      ),

    );
  }
}


import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/verifyAppVersion.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplaceState();
}

class _SplaceState extends State<SplashView> {

  bool activeConnection = false;
  String T = "";
  var result, msg;

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          activeConnection = true;
          T = "Turn off the data and repress again";
          versionAliCall();
          //displayToast(T);
        });
      }
    } on SocketException catch (_) {
      setState(() {
        activeConnection = false;
        T = "Turn On the data and repress again";
        displayToast(T);
      });
    }
  }



  // get app Version

  //url
  void _launchGooglePlayStore() async {
    /// todo below url should be change as a your app store link
    const url =
        'https://play.google.com/store/apps/details?id=com.instagram.android&hl=en_IN&gl=US'; // Replace <YOUR_APP_ID> with your app's package name
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //
  void displayToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
   // checkForNotification();
    Future.delayed(const Duration(seconds: 1), () {
      checkUserConnection();
    });

    // versionAliCall();
    getlocalDataBaseValue();
   // context.go('/Loginaftersplace');
    print('---------xx--xxxxxx-------');
    super.initState();
  }

  //
  getlocalDataBaseValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var sContactNo = prefs.getString('sContactNo');
    // iUserType
    var iUserType = prefs.getString('iUserType');
    var pending_notification_payload = prefs.getString('pending_notification_payload');

    print("-----99-----$pending_notification_payload");

    print('----TOKEN---87---$sContactNo');
    print('----iUserType---101---$iUserType');


    // VisitorList
    /// todo here its testing purpose after testing you should uncomment below code

    if (iUserType != null && iUserType != '' && iUserType == '2') {

      print('-----89---Visitor DashBoard');//

      context.go('/VisitorDashboard');


    } else if(iUserType != null && iUserType != '' && iUserType == '1') {
     // print('-----115----LoginAfter Slace-------');
      print('-----112----vms HOME WITH ONLY vistitor box-------');

     // context.go('/Loginaftersplace');
      context.go('/VmsHome');

    }else{
      print('-----117----FirstTime go login after splace-------');
      context.go('/Loginaftersplace');

    }

  }

  Future<void> versionAliCall() async {
    try {
      // Call the API to check the app version
      var loginMap = await VerifyAppVersionRepo().verifyAppVersion(context, "1",
      );
      result = "${loginMap['Result']}";
      msg = "${loginMap['Msg']}";

      print("------114---App ");
      // Check result and navigate or show dialog
      if (result == "1") {

        //getlocalDataBaseValue();

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => const VmsHome()),
        // );

      } else {
        // Show dialog for mismatched version
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('New Version Available'),
              content: const Text(
                'Please download the latest version of the app from the Play Store.',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    _launchGooglePlayStore();
                  },
                  child: const Text('Download'),
                ),
              ],
            );
          },
        );
        //displayToast(msg ?? "Version mismatch. Please update the app.");
      }
    } catch (e) {
      // Handle potential errors
      print("Error in versionAliCall: $e");
      displayToast("Failed to verify app version.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplaceScreen(),
    );
  }
}

class SplaceScreen extends StatelessWidget {
  const SplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 210, // Adjust as needed
            left: 0,
            right: 0, // Ensures the column is centered horizontally
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF0533B5), // Primary Blue
                      Color(0xFF3B82F6), // Soft Professional Blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Sales",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF0533B5),
                      Color(0xFF3B82F6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "Tracker",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF0533B5),
                      Color(0xFF3B82F6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "",
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),

    );
  }
}

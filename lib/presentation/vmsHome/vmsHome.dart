import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/CheckVisitorDetailsRepo.dart';
import '../visitorList/visitorList.dart';
import 'package:audioplayers/audioplayers.dart';

import '../visitorloginEntry/visitorLoginEntry.dart';

class VmsHome extends StatelessWidget {
  const VmsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VmsHomePage(),
    );
  }
}

class VmsHomePage extends StatefulWidget {
  const VmsHomePage({super.key});

  @override
  State<VmsHomePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<VmsHomePage> {

  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<Map<String, dynamic>>? recentVisitorList;
  AudioPlayer player = AudioPlayer();
  bool isLoading = true; // logic
  var loginProvider;

  // focus
  FocusNode phoneNumberfocus = FocusNode();
  FocusNode passWordfocus = FocusNode();

  bool passwordVisible = false;
  // Visible and Unvisble value
  int selectedId = 0;
  var msg;
  var result;
  var loginMap;
  double? lat, long;
  String? sUserName,sContactNo;
  var token,firebasetitle,firebasebody;
  var firebaseToken,iUserId;
  GeneralFunction generalFunction = GeneralFunction();

  void stopNotificationSound() {
  }
  //
  void playNotificationSound() async {
    await player.stop(); // Stop any previous sound
    await player.release(); // Release resources
    await player.setVolume(0.5);
    await player.play(AssetSource('sounds/coustom_sound.wav'), mode: PlayerMode.mediaPlayer);
  }

  Future<void> _stop() async {
    await player.stop();// Force stop the sound
  }
  // check user id
  getLocatDataBase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sUserName = prefs.getString('sUserName');
      sContactNo = prefs.getString('sContactNo');// Set loading to false after fetching data
    });
    iUserId = prefs.getString('iUserId');
    if(iUserId!=null){
      checkNotifcationApi(iUserId);
    }else{
    }
  }
  // check notification api
  void checkNotifcationApi(iUserId) async {
    var  checkVisitorDetail = await CheckVisitorDetailsRepo().checkVisitorDetail(context,iUserId);
    result = '${checkVisitorDetail['Result']}';
    msg  = '${checkVisitorDetail['Msg']}';
    print("----resullt-------100-->>>--$result");
  }

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    // await fcm.requestPermission();
    await fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true, // Important for sounds
      provisional: false,
      sound: true, // Ensure this is true
    );
    token = await fcm.getToken();
    print("📌 Token:----78----xxx $token");
    //
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📦 Data Payload----563---xx--: ${message.data}");
     // playNotificationSound();

      if (message.notification != null) {
        var sound = message.notification!.android?.sound ?? message.notification!.apple?.sound;
        print("🔔 Playing custom sound: $sound");
        playNotificationSound();
        _showNotificationDialog(message.notification!.title ?? "New Notification",
         message.notification!.body ?? "You have received a new message.");

      }
    });
  }
  // Function to show Dialog
  void _showNotificationDialog(String title, String body) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent accidental dismiss while stopping sound
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () async {
              await _stop(); // Ensure sound is completely stopped before closing

              if (Navigator.canPop(context)) {

                if(result=="1"){
                  print("----------151----------Visitor List--$result");
                }else{
                  print("----------153----------LoGIN Screnn---$result");
                }
              }

            },
            child: Container(
              height: 200,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    body,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((_) async {
      await _stop(); // Ensure sound stops even if user dismisses manually
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkForNotification();
    getLocatDataBase();

  }

  Future<void> checkForNotification() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? title = prefs.getString('notification_title');
    String? body = prefs.getString('notification_body');

    print("🔍 Retrieved Title----x-x-----xxx--: $title");
    print("🔍 Retrieved Body: $body");

    if (title != null) {
      await prefs.remove('notification_title');
      await prefs.remove('notification_body');
      // here You should hit api and check data is availabel or not
      if(iUserId!=null){
        // call api
        var  checkVisitorDetail = await CheckVisitorDetailsRepo().checkVisitorDetail(context,iUserId);
        print("-------checkVisitorDertails----$checkVisitorDetail");
        result = '${checkVisitorDetail['Result']}';
        msg  = '${checkVisitorDetail['Msg']}';
        //var result2="1";
        print('-----result----xxxxx----xxxxx--x-$result');
        setState(() {
        });
        if(result=="1"){

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {  // Ensure context is valid
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VisitorList(
                    payload: jsonEncode({"title": title, "body": body}),
                  ),
                ),
              );
            }
          });

        }else{
          displayToast("------Result--$result");
        }

      }else{
      }
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    passwordController.dispose();
    player.dispose();
    super.dispose();
  }
  void clearText() {
    _phoneNumberController.clear();
    passwordController.clear();
  }

  // tabletLayout
  Widget _mobileDashboardLayout() {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        /// LOGO
        // Align(
        //
        //   alignment: Alignment.centerLeft,
        //
        //   child: Image.asset(
        //     'assets/images/synergylogo.png',
        //     height: 34,
        //   ),
        // ),

        // const SizedBox(height: 10),
        //
        // /// TOP IMAGE
        // Image.asset(
        //
        //   'assets/images/dashboardupper.png',
        //
        //   height: 180,
        //
        //   fit: BoxFit.contain,
        // ),
        //
        // const SizedBox(height: 16),

        /// GLASS CARD
        SizedBox(height: 150),
        _dashboardGlassCard(),
      ],
    );
  }
  Widget _tabletDashboardLayout() {

    return Row(

      children: [

        /// LEFT SIDE
        Expanded(

          child: Padding(

            padding: const EdgeInsets.all(20),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Image.asset(
                  'assets/images/synergylogo.png',
                  height: 55,
                ),

                const SizedBox(height: 25),

                Image.asset(
                  'assets/images/dashboardupper.png',
                  height: 320,
                ),

                const SizedBox(height: 25),

                const Text(

                  "Visitor Management System",

                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 10),

                Text(

                  "Manage visitors professionally with secure access and monitoring.",

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
        ),

        /// RIGHT SIDE
        Expanded(

          child: Center(

            child: SizedBox(

              width: 420,

              child: _dashboardGlassCard(),
            ),
          ),
        ),
      ],
    );
  }
  Widget _dashboardGlassCard() {

    final bool isTablet =
        MediaQuery.of(context).size.width >= 700;

    return GlassmorphicContainer(

      width: double.infinity,

      height: isTablet ? 540 : 400,

      borderRadius: 26,

      blur: 18,

      alignment: Alignment.center,

      border: 1.5,

      // linearGradient: LinearGradient(
      //
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      //
      //   colors: [
      //
      //     Colors.white.withOpacity(0.22),
      //     Colors.white.withOpacity(0.08),
      //   ],
      // ),
      linearGradient: LinearGradient(

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [

          const Color(0xFF1B4965).withOpacity(0.18),

          const Color(0xFF0F172A).withOpacity(0.10),

          Colors.black.withOpacity(0.05),
        ],
      ),

      // borderGradient: LinearGradient(
      //
      //   begin: Alignment.topLeft,
      //   end: Alignment.bottomRight,
      //
      //   colors: [
      //
      //     Colors.white.withOpacity(0.5),
      //     Colors.white.withOpacity(0.1),
      //   ],
      // ),
      borderGradient: LinearGradient(

        begin: Alignment.topLeft,
        end: Alignment.bottomRight,

        colors: [

          Colors.white.withOpacity(0.25),

          Colors.white.withOpacity(0.08),

          Colors.transparent,
        ],
      ),

      child: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            /// TITLE
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),

              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(18),
              //   // color: Colors.white.withOpacity(0.18),
              //   //color: const Color(0xFF0F6FB5).withOpacity(0.5),
              //   color: const Color(0xFF0B2FBD).withOpacity(0.5),
              // ),

              child: const Center(
                child: Text(
                  "Visitor Management System",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Container(
            //
            //   width: double.infinity,
            //
            //   padding: const EdgeInsets.symmetric(
            //     vertical: 12,
            //   ),
            //
            //   decoration: BoxDecoration(
            //
            //     color: Colors.white.withOpacity(0.18),
            //
            //     borderRadius: BorderRadius.circular(18),
            //   ),
            //
            //   child: const Center(
            //
            //     child: Text(
            //
            //       "Visitor Management System",
            //
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 12),

            /// CARD
            Expanded(
              child: _visitorLoginCard(),
            ),
          ],
        ),
      ),
    );
  }
   Widget _visitorLoginCard() {

    final bool isTablet =
        MediaQuery.of(context).size.width >= 700;

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: InkWell(

        borderRadius: BorderRadius.circular(24),

        onTap: () async {

          context.go('/VisitorLoginEntry');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => VisitorLoginEntry(),
          //   ),
          // );


        },

        child: Container(

          width: double.infinity,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(24),

            gradient: LinearGradient(

              colors: [

                Colors.white.withOpacity(0.95),
                Colors.white.withOpacity(0.82),
              ],

              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            boxShadow: [

              BoxShadow(

                color: Colors.black.withOpacity(0.08),

                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Padding(

            padding: const EdgeInsets.all(14),

            child: Column(

              mainAxisAlignment:
              MainAxisAlignment.spaceEvenly,

              children: [

                /// ICON
                Container(

                  height: isTablet ? 90 : 65,
                  width: isTablet ? 90 : 65,

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,

                    gradient: LinearGradient(
                      colors: [

                        const Color(0xFF0B2FBD).withOpacity(0.15),

                        Colors.white,
                      ],
                    ),
                  ),

                  child: Padding(

                    padding: const EdgeInsets.all(10),

                    child: Image.asset(
                      'assets/images/entry.png',
                    ),
                  ),
                ),

                Text(

                  "Visitor Login",

                  style: TextStyle(

                    fontSize: isTablet ? 22 : 18,

                    fontWeight: FontWeight.bold,

                    color: Colors.black87,
                  ),
                ),

                /// BUTTON
                Container(

                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),

                  // decoration: BoxDecoration(
                  //
                  //   color: Color(0xFF0B2FBD).withOpacity(0.5),
                  //
                  //   borderRadius: BorderRadius.circular(30),
                  // ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B2FBD),
                    borderRadius: BorderRadius.circular(30),
                  ),

                  child: const Row(

                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Text(

                        "Continue",

                        style: TextStyle(

                          color: Colors.white,
                          fontSize: 14,

                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Widget _visitorLoginCard() {
  //
  //   final bool isTablet =
  //       MediaQuery.of(context).size.width >= 700;
  //
  //   return InkWell(
  //
  //     borderRadius: BorderRadius.circular(24),
  //
  //     onTap: () async {
  //
  //       context.go('/VisitorLoginEntry');
  //     },
  //
  //     child: Container(
  //
  //       decoration: BoxDecoration(
  //
  //         borderRadius: BorderRadius.circular(24),
  //
  //         gradient: LinearGradient(
  //
  //           colors: [
  //
  //             Colors.white.withOpacity(0.95),
  //             Colors.white.withOpacity(0.82),
  //           ],
  //
  //           begin: Alignment.topLeft,
  //           end: Alignment.bottomRight,
  //         ),
  //
  //         boxShadow: [
  //
  //           BoxShadow(
  //
  //             color: Colors.black.withOpacity(0.08),
  //
  //             blurRadius: 18,
  //             offset: const Offset(0, 8),
  //           ),
  //         ],
  //       ),
  //
  //       child: Padding(
  //
  //         padding: const EdgeInsets.all(14),
  //
  //         child: Column(
  //
  //           mainAxisAlignment:
  //           MainAxisAlignment.spaceEvenly,
  //
  //           children: [
  //
  //             /// ICON
  //             Container(
  //
  //               height: isTablet ? 90 : 65,
  //               width: isTablet ? 90 : 65,
  //
  //               decoration: BoxDecoration(
  //
  //                 shape: BoxShape.circle,
  //
  //                 gradient: LinearGradient(
  //                   colors: [
  //
  //                     const Color(0xFF0F6FB5)
  //                         .withOpacity(0.15),
  //
  //                     Colors.white,
  //                   ],
  //                 ),
  //               ),
  //
  //               child: Padding(
  //
  //                 padding: const EdgeInsets.all(10),
  //
  //                 child: Image.asset(
  //                   'assets/images/entry.png',
  //                 ),
  //               ),
  //             ),
  //
  //             Text(
  //
  //               "Visitor Login",
  //
  //               style: TextStyle(
  //
  //                 fontSize: isTablet ? 22 : 18,
  //
  //                 fontWeight: FontWeight.bold,
  //
  //                 color: Colors.black87,
  //               ),
  //             ),
  //
  //             /// BUTTON
  //             Container(
  //
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: 18,
  //                 vertical: 8,
  //               ),
  //
  //               decoration: BoxDecoration(
  //
  //                 //color: const Color(0xFF0F6FB5),
  //                 color: const Color(0xFF0B2FBD).withOpacity(0.5),
  //
  //                 borderRadius: BorderRadius.circular(30),
  //               ),
  //
  //               child: const Row(
  //
  //                 mainAxisSize: MainAxisSize.min,
  //
  //                 children: [
  //
  //                   Icon(
  //                     Icons.arrow_forward,
  //                     color: Colors.white,
  //                     size: 18,
  //                   ),
  //
  //                   SizedBox(width: 8),
  //
  //                   Text(
  //
  //                     "Continue",
  //
  //                     style: TextStyle(
  //
  //                       color: Colors.white,
  //
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFF4),

      appBar: AppBar(title: Text("VMS")),
      drawer: generalFunction.drawerFunction_3(context,"$sUserName","$sContactNo"),

      //  appBar: AppBar(
      //    title: const Text("VMS"),
      //
      //    leading: IconButton(
      //      icon: const Icon(
      //        Icons.arrow_back_ios,
      //      ),
      //      onPressed: () {
      //        //Navigator.pop(context);
      //        Navigator.pushReplacement(
      //          context,
      //          MaterialPageRoute(
      //            builder:
      //                (context) => const Loginaftersplace(),
      //          ),
      //        );
      //      },
      //    ),
      //  ),

      //
      //       child: Container(
      //
      //         margin: const EdgeInsets.symmetric(
      //           vertical: 8,
      //         ),
      //
      //         decoration: BoxDecoration(
      //
      //           color: Colors.white.withOpacity(0.85),
      //
      //           borderRadius: BorderRadius.circular(14),
      //
      //           boxShadow: [
      //
      //             BoxShadow(
      //               color: Colors.black.withOpacity(0.08),
      //               blurRadius: 10,
      //               offset: const Offset(0, 4),
      //             ),
      //           ],
      //         ),
      //
      //         child: const Icon(
      //
      //           Icons.arrow_back_ios_new_rounded,
      //
      //           size: 18,
      //
      //           color: Color(0xFF0B2FBD),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),

      body: SafeArea(
        child: LayoutBuilder(

          builder: (context, constraints) {

            final size = MediaQuery.of(context).size;

            final bool isTablet = size.width >= 700;

            return Stack(

              children: [

                /// BACKGROUND
                Container(

                  width: double.infinity,
                  height: double.infinity,

                  decoration: const BoxDecoration(

                    image: DecorationImage(

                      // image: AssetImage(
                      //   "assets/images/bg.png",
                      // ),
                      image: AssetImage(
                        "assets/images/bg1.jpeg",
                      ),

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       InkWell(
                //         onTap: () {
                //           print("----back screen-----");
                //           Navigator.pop(context);
                //           //context.go('/Loginaftersplace');
                //           // Navigator.pushReplacement(
                //           //   context,
                //           //   MaterialPageRoute(
                //           //     builder:
                //           //         (context) => const Loginaftersplace(),
                //           //   ),
                //           // );
                //         },
                //         child: SizedBox(
                //           width: 50, // Set proper width
                //           height: 50, // Set proper height
                //           child: Image.asset("assets/images/backtop.png"),
                //         ),
                //       ),
                //       SizedBox(width: 4),
                //     ],
                //   ),
                // ),

                /// DARK OVERLAY
                Container(

                  decoration: BoxDecoration(

                    gradient: LinearGradient(

                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,

                      colors: [

                        Colors.black.withOpacity(0.15),
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),

                /// MAIN UI
                Center(

                  child: Padding(

                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 18,
                      vertical: isTablet ? 20 : 12,
                    ),

                    child: ConstrainedBox(

                      constraints: BoxConstraints(
                        maxWidth: isTablet ? 1200 : 500,
                      ),

                      child: isTablet
                          ? _tabletDashboardLayout()
                          : _mobileDashboardLayout(),
                    ),
                  ),
                ),

                /// BOTTOM LOGO
                // Positioned(
                //
                //   bottom: 10,
                //   left: 0,
                //   right: 0,
                //
                //   child: Center(
                //
                //     child: Image.asset(
                //
                //       'assets/images/companylogo2.png',
                //
                //       height: isTablet ? 55 : 42,
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );

  }
}

// toast code
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

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart' hide displayToast;
import '../../app/sakestrackingtypography.dart';
import '../../main.dart';
import '../../services/loginRepo.dart';
import '../../services/vmsUpdateGsmId.dart';
import '../salestracker/dashboard/dashboard.dart';
import '../visitorList/visitorList.dart' hide displayToast;
import '../vmsHome/vmsHome.dart' hide displayToast;

class Loginaftersplace extends StatelessWidget {

  const Loginaftersplace({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPageAfterSplace(),
    );
  }
}

class LoginPageAfterSplace extends StatefulWidget {

  const LoginPageAfterSplace({super.key});

  @override
  State<LoginPageAfterSplace> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageAfterSplace> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isObscured = false;
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
  String? phoneError;
  String? nameError;
  var token;
  AudioPlayer player = AudioPlayer();
  GeneralFunction generalFunction = GeneralFunction();

  @override
  void initState() {
    // TODO: implement initState
   // setupPushNotifications();
    super.initState();
  }

  //    notification





  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void clearText() {
    _phoneNumberController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    /// Tablet Detection
    final bool isTablet = size.width >= 700;

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: WillPopScope(

        onWillPop: () async => false,

        child: GestureDetector(

          onTap: () {
            FocusScope.of(context).unfocus();
          },

          child: Scaffold(

            resizeToAvoidBottomInset: true,

            body: Stack(
              children: [

                /// FIXED BACKGROUND IMAGE
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/loginbg2.png",
                    fit: BoxFit.cover,
                  ),
                ),

                /// GLASS OVERLAY
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.10),
                          Colors.white.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                ),

                /// MAIN CONTENT
                SafeArea(

                  child: LayoutBuilder(

                    builder: (context, constraints) {

                      return SingleChildScrollView(

                        keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,

                        child: ConstrainedBox(

                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),

                          child: IntrinsicHeight(

                            child: Center(

                              child: ConstrainedBox(

                                constraints: BoxConstraints(
                                  maxWidth: isTablet ? 1000 : 500,
                                ),

                                child: Padding(

                                  padding: EdgeInsets.only(
                                    left: isTablet ? 40 : 18,
                                    top: 20,
                                    bottom: 20,
                                    right: 0,
                                  ),

                                  child: isTablet
                                      ? _tabletLayout()
                                      : _mobileLayout(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //===========================================================
  // MOBILE UI
  //===========================================================
  Widget _mobileLayout() {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [

        /// RESPONSIVE TOP SPACE
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
        ),

        /// LOGIN CARD
        Padding(
          padding: const EdgeInsets.only(
            top: 160,
          ),

          child: Align(
            alignment: Alignment.centerLeft,

            child: _loginCard(),
          ),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  //===========================================================
  // TABLET UI
  //===========================================================

  Widget _tabletLayout() {
    return Row(
      children: [
        /// LEFT SIDE
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 35,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 65,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.12, ),
                     // padding: const EdgeInsets.only(top: 310),
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 50,

                        ),
                        child: Image.asset(
                          "assets/images/loginupper.png",
                          width: 580,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // child: Image.asset(
                      //   "assets/images/loginupper.png",
                      //   width: 580,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                /// TEXT SECTION
                Expanded(
                  flex: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// FIRST TEXT
                      const Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.5,
                          height: 1.1,
                        ),
                      ),

                      /// SPACE BETWEEN TEXTS
                      const SizedBox(height: 15),

                      /// SECOND TEXT
                      Text(
                        "Secure login portal for Synergy Telematics.",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.78),
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      // SizedBox(width: 120),
        SizedBox( width: MediaQuery.of(context).size.width * 0.04, ),
        /// RIGHT SIDE CARD
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 250,
                left: 1
            ),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _loginCard(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginCard() {
    return commonGlassFormCard(
      context: context,
      formKey: _formKey,
      title: "User Authentication",

      children: [
        commonTextFormField(
          controller: _phoneNumberController,
          focusNode: phoneNumberfocus,
          keyboardType: TextInputType.phone,
          labelText: "User Id",
          maxLength: 10,
          prefixIcon: Icons.verified_user,
        ),

        const SizedBox(height: 20),

        commonTextFormField(
          controller: passwordController,
          labelText: "Password",
          prefixIcon: Icons.lock,
          obscureText: _isObscured,
          isPassword: true,
          onTogglePassword: () {
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ],

      button: commonGradientButton(
        label: "Login",
        onPressed: ()async {
          // Call your API here
          var phone = _phoneNumberController.text.trim();
          var password = passwordController.text.trim();
          print("---phone--$phone");
          print("----password ---$password");

          if (_formKey.currentState!.validate() &&
              phone.isNotEmpty &&
              password.isNotEmpty) {
            loginMap = await LoginRepo().login(
              context,
              phone,
              password,
            );
            result = "${loginMap['Result']}";
            msg = "${loginMap['Msg']}";
            print("-------528----$loginMap");

            if(result=="1"){
              // to store the fetch data into the local database
              var iUserId = loginMap["Data"][0]["iUserId"].toString();
              var sUserName = loginMap["Data"][0]["sUserName"].toString();
              var sContactNo = loginMap["Data"][0]["sContactNo"].toString();
              var sToken = loginMap["Data"][0]["sToken"].toString();
              var iUserType = loginMap["Data"][0]["iUserType"].toString();
              var dLastLoginAt = loginMap["Data"][0]["dLastLoginAt"].toString();
              // to store the value into the sharedPreference
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('iUserId',iUserId).toString();
              prefs.setString('sUserName',sUserName).toString();
              prefs.setString('sContactNo',sContactNo).toString();
              prefs.setString('sToken',sToken).toString();
              prefs.setString('iUserType',iUserType).toString();
              prefs.setString('dLastLoginAt',dLastLoginAt).toString();

              print("Stored iUserId = ${prefs.getString('iUserId')}");
              print("Stored sUserName = ${prefs.getString('sUserName')}");
              print("Stored sContactNo = ${prefs.getString('sContactNo')}");
              print("Stored sToken = ${prefs.getString('sToken')}");



              /// todo here you uncoments

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashBoardSalesTrackerHome(),
                ),
              );


            }else {
              //displayToast(msg);
              displayToast(msg);

            }
          } else {
            if (_phoneNumberController.text.isEmpty) {
              phoneNumberfocus.requestFocus();
            } else if (passwordController.text.isEmpty) {
              passWordfocus.requestFocus();
            }
          }
        },
      ),
    );
  }
}



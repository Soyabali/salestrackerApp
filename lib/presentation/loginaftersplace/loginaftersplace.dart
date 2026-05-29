import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/loginRepo.dart';
import '../salestracker/dashboard/dashboard.dart';
import '../visitorList/visitorList.dart';
import '../vmsHome/vmsHome.dart';

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

  bool _isObscured = true;
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
  GeneralFunction generalFunction = GeneralFunction();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                    "assets/images/bg1.jpeg",
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

                                  padding: EdgeInsets.symmetric(
                                    horizontal: isTablet ? 40 : 18,
                                    vertical: 20,
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

          padding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),

          child: _loginCard(),
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

  //===========================================================
  // LOGIN CARD
  //===========================================================

  Widget _loginCard() {
    return Container(
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(24),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withOpacity(0.18),

            blurRadius: 30,

            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: GlassmorphicContainer(
        width: double.infinity,
        //height: 420,
        height: MediaQuery.of(context).size.height < 700 ? 470 : 420,

        borderRadius: 24,

        blur: 20,

        alignment: Alignment.center,

        border: 1.5,

        linearGradient: LinearGradient(

          begin: Alignment.topLeft,
          end: Alignment.bottomRight,

          colors: [

            const Color(0xFF1B4965).withOpacity(0.18),

            const Color(0xFF0F172A).withOpacity(0.10),

            Colors.black.withOpacity(0.05),
          ],
        ),

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
          padding: const EdgeInsets.all(24),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                /// TITLE
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),

                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(18),
                  //  // color: Colors.white.withOpacity(0.18),
                  //   //color: const Color(0xFF0F6FB5).withOpacity(0.5),
                  //   color: const Color(0xFF0B2FBD).withOpacity(0.5),
                  // ),

                  child: const Center(
                    child: Text(
                      "User Authentication",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// MOBILE FIELD
                TextFormField(
                  controller: _phoneNumberController,

                  focusNode: phoneNumberfocus,

                  keyboardType: TextInputType.phone,

                  textInputAction: TextInputAction.next,
                  // color white
                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  // inputFormatters: [
                  //   LengthLimitingTextInputFormatter(10),
                  //   FilteringTextInputFormatter.digitsOnly,
                  // ],

                  decoration: _inputDecoration(
                    label: "User Id",
                    icon: Icons.verified_user,
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter User Id';
                    }

                    if (value.length != 1) {
                      return 'User Id must be 1 digits';
                    }

                    // if (!RegExp(r'^[6-9]').hasMatch(value)) {
                    //   return 'Invalid mobile number';
                    // }

                    return null;
                  },
                ),

                const SizedBox(height: 22),

                /// PASSWORD FIELD
                TextFormField(
                  controller: passwordController,

                  focusNode: passWordfocus,

                  obscureText: _isObscured,

                  style: const TextStyle(
                    color: Colors.white,
                  ),

                  decoration: _inputDecoration(
                    label: "Password",
                    icon: Icons.lock,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },

                      icon: Icon(
                        _isObscured ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter password';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 35),

                /// LOGIN BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: const Color(0xFF0F6FB5),
                      backgroundColor: Color(0xFF0B2FBD).withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: ()async{
                      print("--------login ------");
                      // DashBoardSalesTrackerHome
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashBoardSalesTrackerHome(),
                        ),
                      );
                    },

                    /// todo here you uncomments this is a running code
                    ///
                    // onPressed: () async {
                    //   /// KEEP YOUR FULL LOGIN FUNCTIONALITY HERE
                    //   /// YOUR EXISTING API LOGIC WILL WORK SAME
                    //
                    //   String phone = _phoneNumberController.text.trim();
                    //   String password = passwordController.text.trim();
                    //
                    //   if (_formKey.currentState!.validate() &&
                    //       phone.isNotEmpty &&
                    //       password.isNotEmpty) {
                    //     /// YOUR LOGIN API
                    //     loginMap = await LoginRepo().login(
                    //       context,
                    //       phone,
                    //       password,
                    //     );
                    //     result = "${loginMap['Result']}";
                    //     msg = "${loginMap['Msg']}";
                    //     print("-------330----$loginMap");
                    //     if (result == "0") {
                    //       displayToast(msg);
                    //     }
                    //     if (result == "1") {
                    //       // to store the fetch data into the local database
                    //       var iUserId = loginMap["Data"][0]["iUserId"].toString();
                    //       var sUserName = loginMap["Data"][0]["sUserName"]
                    //           .toString();
                    //       var sContactNo = loginMap["Data"][0]["sContactNo"]
                    //           .toString();
                    //       var sToken = loginMap["Data"][0]["sToken"].toString();
                    //       var iUserType = loginMap["Data"][0]["iUserType"]
                    //           .toString();
                    //       var dLastLoginAt = loginMap["Data"][0]["dLastLoginAt"]
                    //           .toString();
                    //
                    //       // to store the value into the sharedPreference
                    //       SharedPreferences prefs =
                    //           await SharedPreferences.getInstance();
                    //       prefs.setString('iUserId', iUserId).toString();
                    //       prefs.setString('sUserName', sUserName).toString();
                    //       prefs.setString('sContactNo', sContactNo).toString();
                    //       prefs.setString('sToken', sToken).toString();
                    //       prefs.setString('iUserType', iUserType).toString();
                    //       prefs
                    //           .setString('dLastLoginAt', dLastLoginAt)
                    //           .toString();
                    //
                    //       if (iUserType == "2") {
                    //         //context.go('/VmsHome');
                    //         context.go('/VisitorDashboard');
                    //         // displayToast("Login ADmin Successfully $iUserType");
                    //       } else if (iUserType == "1") {
                    //         // context.go('/VisitorDashboard');
                    //        // context.go('/VmsHome');
                    //        //  Navigator.push(
                    //        //    context,
                    //        //    MaterialPageRoute(
                    //        //      builder: (context) => VmsHome(),
                    //        //    ),
                    //        //  );
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => VmsHome(),
                    //           ),
                    //         );
                    //         // displayToast("Login visitor Successfully $iUserType");
                    //       } else {}
                    //     }
                    //   }
                    // },

                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
  // INPUT DECORATION
  //===========================================================

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,

      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),

      prefixIcon: Icon(icon, color: Colors.white),

      suffixIcon: suffix,

      filled: true,

      fillColor: Colors.white.withOpacity(0.08),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.2)),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.white),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.red),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.red),
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

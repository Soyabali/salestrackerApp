import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import '../../services/VisitorOtpRepo.dart';
import '../resources/app_strings.dart';
import '../resources/values_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../visitorEntryNew2/visitorEntryNew2.dart';
import '../visitorloginEntry/visitorLoginEntry.dart';

class VisitorLoginOtp extends StatelessWidget {
  const VisitorLoginOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VisitorLoginOtpPage(),
    );
  }
}

class VisitorLoginOtpPage extends StatefulWidget {
  const VisitorLoginOtpPage({super.key});

  @override
  State<VisitorLoginOtpPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<VisitorLoginOtpPage> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
  GeneralFunction generalFunction = GeneralFunction();

  void getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    debugPrint("-------------Position-----------------");
    debugPrint(position.latitude.toString());

    lat = position.latitude;
    long = position.longitude;
    print('-----------105----$lat');
    print('-----------106----$long');
    // setState(() {
    // });
    debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
    debugPrint(position.toString());
  }

  turnOnLocationMsg() {
    if ((lat == null && lat == '') || (long == null && long == '')) {
      displayToast("Please turn on Location");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    // if (lat == null || lat == '') {
    //   turnOnLocationMsg();
    // }
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

  //   -----.
  // MOBILE UI
  //===========================================================

  Widget _mobileLayout() {

    return Column(

      mainAxisSize: MainAxisSize.min,

      children: [

        /// RESPONSIVE TOP SPACE
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),

        /// OTP CARD
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


  // Widget _mobileLayout() {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height,
  //
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //
  //       children: [
  //         /// TOP SECTION
  //         Expanded(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //
  //             children: [
  //               /// TOP SPACE
  //               const SizedBox(height: 190),
  //
  //               /// LOGIN CARD
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 18),
  //
  //                 child: _loginCard(),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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

                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.10,
                      ),

                      child: Container(

                        margin: const EdgeInsets.only(top: 50),

                        child: Image.asset(
                          "assets/images/loginupper.png",
                          width: 580,
                          fit: BoxFit.fill,
                        ),
                      ),
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

                      const SizedBox(height: 15),

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

        /// RESPONSIVE SPACE
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),

        /// RIGHT SIDE CARD
        Expanded(

          flex: 5,

          child: Padding(

            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.10,
              left: 1,
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


  // Widget _tabletLayout() {
  //   return Row(
  //     children: [
  //       /// LEFT SIDE
  //       Expanded(
  //         flex: 5,
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Expanded(
  //                 flex: 65,
  //                 child: Align(
  //                   alignment: Alignment.center,
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(top: 310),
  //                     child: Container(
  //                       margin: const EdgeInsets.only(top: 50),
  //                       child: Image.asset(
  //                         "assets/images/loginupper.png",
  //                         width: 580,
  //                         fit: BoxFit.fill,
  //                       ),
  //                     ),
  //                     // child: Image.asset(
  //                     //   "assets/images/loginupper.png",
  //                     //   width: 580,
  //                     //   fit: BoxFit.fill,
  //                     // ),
  //                   ),
  //                 ),
  //               ),
  //
  //               const SizedBox(height: 25),
  //
  //               /// TEXT SECTION
  //               Expanded(
  //                 flex: 35,
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     /// FIRST TEXT
  //                     const Text(
  //                       "Welcome Back",
  //                       style: TextStyle(
  //                         fontSize: 38,
  //                         fontWeight: FontWeight.w700,
  //                         color: Colors.white,
  //                         letterSpacing: 0.5,
  //                         height: 1.1,
  //                       ),
  //                     ),
  //
  //                     /// SPACE BETWEEN TEXTS
  //                     const SizedBox(height: 15),
  //
  //                     /// SECOND TEXT
  //                     Text(
  //                       "Secure login portal for Synergy Telematics.",
  //                       style: TextStyle(
  //                         fontSize: 18,
  //                         color: Colors.white.withOpacity(0.78),
  //                         fontWeight: FontWeight.w400,
  //                         height: 1.5,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       SizedBox(width: 120),
  //
  //       /// RIGHT SIDE CARD
  //       Expanded(
  //         flex: 5,
  //         child: Padding(
  //           padding: const EdgeInsets.only(top: 250, left: 1),
  //           child: Center(
  //             child: SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.5,
  //               child: _loginCard(),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

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
        height: MediaQuery.of(context).size.height < 700 ? 340 : 300,

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

                  child: const Center(
                    child: Text(
                      "Verify OTP",
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p15,
                  ),
                  child: SizedBox(
                    height: 75,
                    child: TextFormField(
                      focusNode: phoneNumberfocus,
                      controller: _phoneNumberController,
                      autofocus: true,

                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.phone,

                      style: const TextStyle(
                        color: Colors.white, // Typed text color
                      ),

                      cursorColor: Colors.white,

                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly,
                      ],

                      autovalidateMode: AutovalidateMode.onUserInteraction,

                      decoration: InputDecoration(
                        labelText: 'Enter OTP',

                        // Label Color
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),

                        // Icon Color
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: AppPadding.p10,
                          horizontal: AppPadding.p10,
                        ),

                        // Normal Border
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),

                        // Focus Border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),

                        // Error Border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        ),

                        // Focus Error Border
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),

                        // Error Text Style
                        errorStyle: const TextStyle(
                          color: Colors.red,
                          fontSize: 13,
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter OTP';
                        }

                        if (value.length < 4) {
                          return 'Enter 4-digit OTP';
                        }

                        return null;
                      },
                    ),
                    // child: TextFormField(
                    //   focusNode: phoneNumberfocus,
                    //   controller: _phoneNumberController,
                    //   autofocus: true,
                    //   textInputAction: TextInputAction.next,
                    //   keyboardType: TextInputType.phone,
                    //   style: const TextStyle(
                    //     color: Colors.white,
                    //   ),
                    //   inputFormatters: [LengthLimitingTextInputFormatter(4)],
                    //   decoration: const InputDecoration(
                    //     labelText: 'Enter OTP',
                    //     border: OutlineInputBorder(),
                    //     contentPadding: EdgeInsets.symmetric(
                    //       vertical: AppPadding.p10,
                    //       horizontal: AppPadding.p10,
                    //     ),
                    //     prefixIcon: Icon(Icons.phone, color: Color(0xFF255899)),
                    //   ),
                    //   autovalidateMode: AutovalidateMode.onUserInteraction,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return 'Enter OTP';
                    //     }
                    //     if (value.length > 1 && value.length < 4) {
                    //       return 'Enter 4-digit OTP';
                    //     }
                    //     return null;
                    //   },
                    // ),
                  ),
                ),

                // TextFormField(
                //   //focusNode: widget.phoneFocus,
                //   controller: _phoneNumberController,
                //   autofocus: true,
                //   textInputAction: TextInputAction.next,
                //   keyboardType: TextInputType.phone,
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(10),
                //     FilteringTextInputFormatter.digitsOnly,
                //   ],
                //   decoration: InputDecoration(
                //     labelText: "Enter OTP",
                //     border: const OutlineInputBorder(),
                //     prefixIcon: const Icon(
                //       Icons.phone,
                //       color: Color(0xFF255899),
                //     ),
                //     errorText: phoneError,
                //   ),
                //   onChanged: (value) {
                //     setState(() {
                //       if (value.isEmpty) {
                //         phoneError = 'Enter OTP';
                //       } else if (value.length > 4) {
                //         phoneError = 'OTP number must be 4 digits';
                //       } else if (!RegExp(r'^[6-9]').hasMatch(value)) {
                //         phoneError = 'The OTP number is not valid.';
                //       } else if (RegExp(r'^0+$').hasMatch(value)) {
                //         phoneError = 'The OTP number is not valid.';
                //       } else if (value.length < 4) {
                //         phoneError = 'OTP number must be 10 digits';
                //       } else {
                //         phoneError = null;
                //       }
                //     });
                //   },
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Enter mobile number';
                //     }
                //     if (value.length != 10) {
                //       return 'Mobile number must be 10 digits';
                //     }
                //     if (!RegExp(r'^[6-9]').hasMatch(value)) {
                //       return 'The mobile number is not valid.';
                //     }
                //     if (RegExp(r'^0+$').hasMatch(value)) {
                //       return 'The mobile number is not valid.';
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 22),

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

                    onPressed: () async {
                      /// KEEP YOUR FULL LOGIN FUNCTIONALITY HERE
                      /// YOUR EXISTING API LOGIC WILL WORK SAME

                      String phone = _phoneNumberController.text.trim();

                      if (_formKey.currentState!.validate() &&
                          phone.isNotEmpty) {
                        /// todo here you should have to call a otp api

                        loginMap = await VisitorOtpRepo().visitorOtp(
                          context,
                          phone,
                        );
                        result = "${loginMap['Result']}";
                        msg = "${loginMap['Msg']}";
                        print("---OTP response---$loginMap");
                        if (result == "0") {
                          displayToast(msg);
                        }
                        if (result == "1") {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitorEntryNew2(),
                            ),
                          );

                        } else {
                          displayToast(msg);
                        }
                      } else {
                        if (phone.isEmpty) {
                          // widget.phoneFocus.requestFocus();
                          displayToast("Please enter OTP number");
                        }
                      }
                    },

                    child: const Text(
                      "Submit",
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

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    /// TABLET DETECTION
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

            appBar: AppBar(

              title: const Text("VMS"),

              leading: IconButton(

                icon: const Icon(Icons.arrow_back_ios),

                onPressed: () {

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      const VisitorLoginEntry(),
                    ),
                  );
                },
              ),
            ),

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



// @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //
  //   /// Tablet Detection
  //   final bool isTablet = size.width >= 700;
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //
  //     home: WillPopScope(
  //       onWillPop: () async => false,
  //
  //       child: GestureDetector(
  //         onTap: () {
  //           FocusScope.of(context).unfocus();
  //         },
  //         child: Scaffold(
  //           resizeToAvoidBottomInset: false,
  //           // appbar
  //           appBar: AppBar(
  //             title: const Text("VMS"),
  //
  //             leading: IconButton(
  //               icon: const Icon(
  //                 Icons.arrow_back_ios,
  //               ),
  //               onPressed: () {
  //                 //Navigator.pop(context);
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder:
  //                         (context) => const VisitorLoginEntry(),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           body: AnimatedPadding(
  //             duration: const Duration(milliseconds: 250),
  //
  //             padding: EdgeInsets.only(
  //               bottom: MediaQuery.of(context).viewInsets.bottom,
  //             ),
  //
  //             child: Stack(
  //               children: [
  //                 /// BACKGROUND
  //                 Container(
  //                   width: double.infinity,
  //                   height: double.infinity,
  //                   decoration: const BoxDecoration(
  //                     image: DecorationImage(
  //                       //image: AssetImage("assets/images/bg.png"),
  //                       image: AssetImage("assets/images/bg1.jpeg"),
  //                       fit: BoxFit.cover,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 /// GLASS OVERLAY
  //                 Container(
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: [
  //                         Colors.white.withOpacity(0.10),
  //                         Colors.white.withOpacity(0.05),
  //                       ],
  //                       begin: Alignment.topLeft,
  //                       end: Alignment.bottomRight,
  //                     ),
  //                   ),
  //                 ),
  //
  //                 /// MAIN CONTENT
  //                 SafeArea(
  //                   child: LayoutBuilder(
  //                     builder: (context, constraints) {
  //                       return Center(
  //                         child: ConstrainedBox(
  //                           constraints: BoxConstraints(
  //                             maxWidth: isTablet ? 1000 : 500,
  //                           ),
  //
  //                           child: Padding(
  //                             padding: EdgeInsets.symmetric(
  //                               horizontal: isTablet ? 40 : 18,
  //                               vertical: 20,
  //                             ),
  //
  //                             child: isTablet
  //                                 ? _tabletLayout()
  //                                 : _mobileLayout(),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  //
  //   // return MaterialApp(
  //   //   debugShowCheckedModeBanner: false,
  //   //  // WillPopScope(
  //   //     //  onWillPop: () async => false,
  //   //   home: WillPopScope(
  //   //     onWillPop: () async {
  //   //       Navigator.of(context).pushAndRemoveUntil(
  //   //         MaterialPageRoute(builder: (context) => VisitorLoginEntry()),
  //   //             (route) => false, // Clears the entire back stack
  //   //       );
  //   //       return false;
  //   //     },
  //   //     child: GestureDetector(
  //   //       onTap: () {
  //   //         FocusScope.of(context).unfocus(); // Hide keyboard
  //   //       },
  //   //       child: Stack(
  //   //         children: [
  //   //           Padding(
  //   //             padding: const EdgeInsets.only(left: 13, right: 13),
  //   //             child: InkWell(
  //   //               child: Container(
  //   //                 width:
  //   //                 double.infinity, // Make container fill the width of its parent
  //   //                 height: AppSize.s45,
  //   //                 //  padding: EdgeInsets.all(AppPadding.p5),
  //   //                 decoration: BoxDecoration(
  //   //                   color: Color(0xFF255899), // Background color using HEX value
  //   //                   borderRadius: BorderRadius.circular(
  //   //                     AppMargin.m10,
  //   //                   ), // Rounded corners
  //   //                 ),
  //   //                 child: const Center(
  //   //                   child: Text(
  //   //                     AppStrings.txtLogin,
  //   //                     style: TextStyle(
  //   //                       fontSize: AppSize.s16,
  //   //                       color: Colors.white,
  //   //                     ),
  //   //                   ),
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           // Full-screen background image
  //   //           Positioned(
  //   //             top: 0, // Start from the top
  //   //             left: 0,
  //   //             right: 0,
  //   //             height: MediaQuery.of(context).size.height * 0.7, // 70% of screen height
  //   //             child: Image.asset(
  //   //               'assets/images/bg.png', // Replace with your image path
  //   //               fit: BoxFit.cover, // Covers the area properly
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             top: 85,
  //   //             left: 20,
  //   //             child: Center(
  //   //               child: Container(
  //   //                 height: 32,
  //   //                 //width: 140,
  //   //                 child: Image.asset(
  //   //                   'assets/images/synergylogo.png', // Replace with your image path
  //   //                   // Set height
  //   //                   fit: BoxFit.cover, // Ensures the image fills the given size
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             top: 140,
  //   //             left: 35,
  //   //             right: 35,
  //   //             child: Center(
  //   //               child: Image.asset(
  //   //                 'assets/images/loginupper.png', // Replace with your image path
  //   //                 fit: BoxFit.fill,
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             top: 400,
  //   //             left: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * 0.2 : 15,
  //   //             right: MediaQuery.of(context).size.width > 600 ? MediaQuery.of(context).size.width * 0.2 : 15,
  //   //             child: Card(
  //   //               shape: RoundedRectangleBorder(
  //   //                 borderRadius: BorderRadius.circular(20),
  //   //               ),
  //   //               elevation: 5,
  //   //               child: Container(
  //   //                 height: 220,
  //   //                 padding: EdgeInsets.all(10),
  //   //                 child: Column(
  //   //                   mainAxisAlignment: MainAxisAlignment.start,
  //   //                   crossAxisAlignment: CrossAxisAlignment.start,
  //   //                   children: <Widget>[
  //   //                     Padding(
  //   //                       padding: const EdgeInsets.symmetric(horizontal: 20),
  //   //                       child: Container(
  //   //                         width: double.infinity,
  //   //                         height: 35,
  //   //                         decoration: BoxDecoration(
  //   //                           color: Color(0xFFC9EAFE),
  //   //                           borderRadius: BorderRadius.circular(17),
  //   //                           boxShadow: const [
  //   //                             BoxShadow(
  //   //                               color: Colors.black26,
  //   //                               blurRadius: 3,
  //   //                               spreadRadius: 2,
  //   //                               offset: Offset(2, 4),
  //   //                             ),
  //   //                           ],
  //   //                         ),
  //   //                         alignment: Alignment.center,
  //   //                         child: const Text(
  //   //                           "Verify OTP",
  //   //                           style: TextStyle(
  //   //                             color: Colors.black45,
  //   //                             fontSize: 16,
  //   //                             fontWeight: FontWeight.bold,
  //   //                           ),
  //   //                         ),
  //   //                       ),
  //   //                     ),
  //   //                     SizedBox(height: 20),
  //   //                     GestureDetector(
  //   //                       onTap: () {
  //   //                         FocusScope.of(context).unfocus();
  //   //                       },
  //   //                       child: SingleChildScrollView(
  //   //                         child: Form(
  //   //                           key: _formKey,
  //   //                           child: Padding(
  //   //                             padding: const EdgeInsets.symmetric(horizontal: 10),
  //   //                             child: Column(
  //   //                               children: <Widget>[
  //   //                                 Padding(
  //   //                                   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
  //   //                                   child: SizedBox(
  //   //                                     height: 75,
  //   //                                     child: TextFormField(
  //   //                                       focusNode: phoneNumberfocus,
  //   //                                       controller: _phoneNumberController,
  //   //                                       autofocus: true,
  //   //                                       textInputAction: TextInputAction.next,
  //   //                                       keyboardType: TextInputType.phone,
  //   //                                       inputFormatters: [
  //   //                                         LengthLimitingTextInputFormatter(4),
  //   //                                       ],
  //   //                                       decoration: const InputDecoration(
  //   //                                         labelText: 'Enter OTP',
  //   //                                         border: OutlineInputBorder(),
  //   //                                         contentPadding: EdgeInsets.symmetric(
  //   //                                           vertical: AppPadding.p10,
  //   //                                           horizontal: AppPadding.p10,
  //   //                                         ),
  //   //                                         prefixIcon: Icon(Icons.phone, color: Color(0xFF255899)),
  //   //                                       ),
  //   //                                       autovalidateMode: AutovalidateMode.onUserInteraction,
  //   //                                       validator: (value) {
  //   //                                         if (value!.isEmpty) {
  //   //                                           return 'Enter OTP';
  //   //                                         }
  //   //                                         if (value.length > 1 && value.length < 4) {
  //   //                                           return 'Enter 4-digit OTP';
  //   //                                         }
  //   //                                         return null;
  //   //                                       },
  //   //                                     ),
  //   //                                   ),
  //   //                                 ),
  //   //                                 SizedBox(height: 0),
  //   //                                 Padding(
  //   //                                   padding: const EdgeInsets.symmetric(horizontal: 10),
  //   //                                   child: InkWell(
  //   //                                     onTap: () async {
  //   //                                       var phone = _phoneNumberController.text.trim();
  //   //                                       if (phone.isNotEmpty) {
  //   //                                         print("---API call here---");
  //   //                                         loginMap = await VisitorOtpRepo().visitorOtp(context, phone);
  //   //                                         result = "${loginMap['Result']}";
  //   //                                         msg = "${loginMap['Msg']}";
  //   //                                         print("---OTP response---$loginMap");
  //   //
  //   //                                         if (result == "1") {
  //   //                                           Navigator.push(
  //   //                                             context,
  //   //                                             MaterialPageRoute(builder: (context) => VisitorEntryNew2()),
  //   //                                           );
  //   //                                         } else {
  //   //                                           displayToast(msg);
  //   //                                         }
  //   //                                       } else {
  //   //                                         phoneNumberfocus.requestFocus();
  //   //                                       }
  //   //                                     },
  //   //                                     child: Container(
  //   //                                       height: 45,
  //   //                                       width: double.infinity,
  //   //                                       decoration: const BoxDecoration(
  //   //                                         color: Color(0xFF0f6fb5),
  //   //                                         borderRadius: BorderRadius.horizontal(
  //   //                                           left: Radius.circular(17),
  //   //                                           right: Radius.circular(17),
  //   //                                         ),
  //   //                                       ),
  //   //                                       child: const Center(
  //   //                                         child: Text(
  //   //                                           'Verify OTP',
  //   //                                           style: TextStyle(
  //   //                                             color: Colors.white,
  //   //                                             fontSize: 16,
  //   //                                             fontWeight: FontWeight.bold,
  //   //                                           ),
  //   //                                         ),
  //   //                                       ),
  //   //                                     ),
  //   //                                   ),
  //   //                                 ),
  //   //                               ],
  //   //                             ),
  //   //                           ),
  //   //                         ),
  //   //                       ),
  //   //                     ),
  //   //                   ],
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //           Positioned(
  //   //             bottom: 10, // Distance from the bottom
  //   //             left: 0,
  //   //             right: 0, // Ensures centering
  //   //             child: Center( // Centers the logo horizontally
  //   //               child: Padding(
  //   //                 padding: const EdgeInsets.symmetric(horizontal: 13),
  //   //                 child: Image.asset(
  //   //                   'assets/images/companylogo2.png',
  //   //                   fit: BoxFit.fill, // Stretches to fill the height & width
  //   //                   height: 50, // Increase height
  //   //                 ),
  //   //               ),
  //   //             ),
  //   //           ),
  //   //         ],
  //   //       ),
  //   //     ),
  //   //   ),
  //   // );
  // }
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

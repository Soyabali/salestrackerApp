
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import '../../services/OtpPageRegistration.dart';
import '../../services/citizenRegistrationRepo.dart';
import '../login/loginScreen_2.dart';
import '../resources/app_strings.dart';
import '../resources/app_text_style.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatelessWidget {

  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegistrationPage> {

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscured2 = true;
  var loginProvider;

  // focus
  FocusNode userNamefocus = FocusNode();
  FocusNode mobileNofocus = FocusNode();
  FocusNode emailfocus = FocusNode();
  FocusNode passwordfocus = FocusNode();


  bool passwordVisible = false;
  // Visible and Unvisble value
  int selectedId = 0;
  var msg;
  var result;
  var loginMap;
  double? lat, long;
  GeneralFunction generalFunction = GeneralFunction();
  String? _selectedGender;
  var sToken;

  // Gender options
  final List<String> _genderOptions = ["Male", "Female", "Other"];

  // void getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   debugPrint("-------------Position-----------------");
  //   debugPrint(position.latitude.toString());
  //
  //   lat = position.latitude;
  //   long = position.longitude;
  //   print('-----------105----$lat');
  //   print('-----------106----$long');
  //   // setState(() {
  //   // });
  //   debugPrint("Latitude: ----1056--- $lat and Longitude: $long");
  //   debugPrint(position.toString());
  // }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocation();
    Future.delayed(const Duration(milliseconds: 100), () {
      // requestLocationPermission();
      setState(() {
        // Here you can write your code for open new view
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _userNameController.dispose();
    _mobileNoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  void clearText() {
    _userNameController.clear();
    _mobileNoController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //onWillPop: _onWillPop,
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Pop Screen Disabled.'),
            backgroundColor: Colors.red,
          ),
        );
        return false; // Prevent the back button action
      },
    // return  WillPopScope(
    //   onWillPop: () async => false,
    // return WillPopScope(
    //     onWillPop: () async => false,
    // child: GestureDetector(
    // onTap: () {
    // FocusScope.of(context).unfocus();
    // },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              // statusBarColore
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Color(0xFF12375e),
                statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)
              ),
              // backgroundColor: Colors.blu
              backgroundColor: Color(0xFF255898),
              leading: GestureDetector(
                onTap: (){
                  print("------back---");
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen_2()),
                  );
                },
                child: Icon(Icons.arrow_back_ios,
                  color: Colors.white,),
              ),
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Registration',
                  style: AppTextStyle.font16OpenSansRegularWhiteTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              //centerTitle: true,
              elevation: 0, // Removes shadow under the AppBar
            ),
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // mention all widget here
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: <Widget>[
              //
              //               Container(
              //                 margin: const EdgeInsets.all(AppMargin.m10),
              //                 decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                     image: AssetImage("assets/images/roundcircle.png"),
              // //image: AssetImage("assets/images/roundcircle.png"), // Correct path to background image
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 width: AppSize.s50,
              //                 height: AppSize.s50,
              //                 child: Image.asset("assets/images/login_icon.png",
              //                   //ImageAssets.logintopleft,
              //                   width: AppSize.s50,
              //                   height: AppSize.s50,
              //                 ),
              //               ),
              //               Expanded(child: Container()),
              //               Container(
              //                 margin: const EdgeInsets.all(AppMargin.m10),
              //                 decoration: const BoxDecoration(
              //                   image: DecorationImage(
              //                     image: AssetImage("assets/images/roundcircle.png"), // Correct path to background image
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 width: AppSize.s50,
              //                 height: AppSize.s50,
              //                 child: Image.asset("assets/images/favicon.png",
              //                   // ImageAssets.toprightlogin,
              //                   width: AppSize.s50,
              //                   height: AppSize.s50,
              //                 ),
              //               ),
              //             ],
              //           ),
                        Container(
                          height: AppSize.s145,
                          width: AppSize.s145,
                          margin: const EdgeInsets.all(AppMargin.m20),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                ImageAssets.roundcircle,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(AppMargin.m16),
                            child: Center(
                              child: Image.asset(
                                "assets/images/login_icon.png",
                                // ImageAssets.iclauncher, // Replace with your image asset path
                                width: AppSize.s145,
                                height: AppSize.s145,
                                fit: BoxFit.contain, // Adjust as needed
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Align(
                            alignment: Alignment.centerLeft, // Align to the left
                            child: Text(
                              "Registration",
                              style: AppTextStyle.font14penSansBlackTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        /// Todo here we mention main code for a login ui.
                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: [
                                      // name
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p15, right: AppPadding.p15),
                                        // PHONE NUMBER TextField
                                        child: TextFormField(
                                          focusNode: userNamefocus,
                                          controller: _userNameController,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                         // keyboardType: TextInputType.phone,
                                          //inputFormatters: [LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                                            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                         // ],
                                          decoration: const InputDecoration(
                                            labelText: "User Name",
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p10,
                                              horizontal: AppPadding.p10, // Add horizontal padding
                                            ),

                                            prefixIcon: Icon(
                                              Icons.how_to_reg,
                                              color: Color(0xFF255899),
                                            ),
                                            // errorBorder
                                            // errorBorder: OutlineInputBorder(
                                            //     borderSide: BorderSide(color: Colors.green, width: 0.5))
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Enter User Name';
                                          //   }
                                          //   // if (value.length > 1 && value.length < 10) {
                                          //   //   return 'Enter 10 digit mobile number';
                                          //   // }
                                          //   return null;
                                          // },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Mobile no
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p15, right: AppPadding.p15),
                                        // PHONE NUMBER TextField
                                        child: TextFormField(
                                          focusNode: mobileNofocus,
                                          controller: _mobileNoController,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                          keyboardType: TextInputType.phone,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                                            //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                          ],
                                          decoration: const InputDecoration(
                                            labelText: AppStrings.txtMobile,
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p10,
                                              horizontal: AppPadding.p10, // Add horizontal padding
                                            ),

                                            prefixIcon: Icon(
                                              Icons.phone,
                                              color: Color(0xFF255899),
                                            ),
                                            // errorBorder
                                            // errorBorder: OutlineInputBorder(
                                            //     borderSide: BorderSide(color: Colors.green, width: 0.5))
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter mobile number';
                                            }
                                            if (value.length > 1 && value.length < 10) {
                                              return 'Enter 10 digit mobile number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // Email Id
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p15, right: AppPadding.p15),
                                        // PHONE NUMBER TextField
                                        child: TextFormField(
                                          focusNode: emailfocus,
                                          controller: _emailController,
                                          textInputAction: TextInputAction.next,
                                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                                         // keyboardType: TextInputType.phone,
                                         //  inputFormatters: [
                                         //    LengthLimitingTextInputFormatter(10), // Limit to 10 digits
                                         //    //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
                                         //  ],
                                          decoration: const InputDecoration(
                                            labelText: AppStrings.txtEmail,
                                            border: OutlineInputBorder(),
                                            contentPadding: EdgeInsets.symmetric(
                                              vertical: AppPadding.p10,
                                              horizontal: AppPadding.p10, // Add horizontal padding
                                            ),

                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: Color(0xFF255899),
                                            ),
                                            // errorBorder
                                            // errorBorder: OutlineInputBorder(
                                            //     borderSide: BorderSide(color: Colors.green, width: 0.5))
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          // validator: (value) {
                                          //   if (value!.isEmpty) {
                                          //     return 'Enter mobile number';
                                          //   }
                                          //   if (value.length > 1 && value.length < 10) {
                                          //     return 'Enter 10 digit mobile number';
                                          //   }
                                          //   return null;
                                          // },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      //password
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: AppPadding.p15, right: AppPadding.p15),
                                        // passWord TextFormField
                                        child: TextFormField(
                                          controller: _passwordController,
                                          decoration: InputDecoration(
                                            labelText: AppStrings.txtpassword,
                                            border: const OutlineInputBorder(),
                                            contentPadding: const EdgeInsets.symmetric(
                                              vertical: AppPadding.p10,
                                              horizontal: AppPadding.p10, // Add horizontal padding
                                            ),
                                            prefixIcon: const Icon(Icons.lock,
                                                color: Color(0xFF255899)),
                                            suffixIcon: IconButton(
                                              icon: Icon(_isObscured2
                                                  ? Icons.visibility
                                                  : Icons.visibility_off),
                                              onPressed: () {
                                                setState(() {
                                                  _isObscured2 = !_isObscured2;
                                                });
                                              },
                                            ),
                                          ),
                                          autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Enter password';
                                            }
                                            if (value.length < 1) {
                                              return 'Please enter Valid Name';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      // DropDown
                                       Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15),
                                      child: DropdownButtonFormField<String>(
                                                                value: _selectedGender,
                                                                items: _genderOptions.map((String value) {
                                                                  return DropdownMenuItem<String>(
                                                                    value: value,
                                                                    child: Text(value),
                                                                  );
                                                                }).toList(),
                                                                onChanged: (newValue) {
                                                                  setState(() {
                                                                    _selectedGender = newValue;
                                                                  });
                                                                  print("Selected Gender: $_selectedGender");
                                                                },
                                                                decoration: const InputDecoration(
                                                                  labelText: "Select Gender",
                                                                  border: OutlineInputBorder(),
                                                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                                                                ),
                                                              ),
                                    ),
                                      SizedBox(height: 10),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 13,right: 13),
                                        child: InkWell(
                                          onTap: () async {
                                             var name = _userNameController.text.trim();
                                            var mobileNo = _mobileNoController.text.trim();
                                            var email = _emailController.text.trim();
                                            var password = _passwordController.text.trim();
                                            print("Name -----$name");
                                             print("mobileNo -----$mobileNo");
                                             print("email -----$email");
                                             print("password -----$password");
                                             print("Selected Gender---$_selectedGender");

                                            if(_formKey.currentState!.validate() && name.isNotEmpty && mobileNo.isNotEmpty && password.isNotEmpty && _selectedGender!=null && _selectedGender!=''){
                                              // Call Api
                                              loginMap = await CitizenRegistrationRepo().citizenRegistration(context, name, mobileNo,email,password,_selectedGender);

                                              print('---567----$loginMap');
                                              result = "${loginMap['Result']}";
                                              msg = "${loginMap['Msg']}";
                                               sToken = "${loginMap['sToken']}";
                                              //var token="";
                                              print('---573----$result');
                                              print('---574----$msg');
                                              print('---575----$sToken');

                                            }else{
                                              if(name.isEmpty){
                                               displayToast("Please Enter Name");
                                               return;
                                              } if(mobileNo.isEmpty){
                                                displayToast("Please Enter Mobile Number");
                                                return;
                                              }if(email.isEmpty){
                                                displayToast("Please Enter Email");
                                                return;
                                              }if(password.isEmpty){
                                                displayToast("Please Enter Password");
                                                return;
                                              }
                                            } // condition to fetch a response form a api
                                            if(result=="1"){
                                              // to store the token
                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              prefs.setString('mobileNo',mobileNo);
                                              prefs.setString('sToken',sToken);

                                           // todo otp
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => OtpPageRegistration(phone:mobileNo)),
                                              );
                                            }else if(result=="0"){
                                              displayToast(msg);
                                            }
                                            else{
                                              //print('----373---To display error msg---');
                                              displayToast(msg);

                                            }
                                          },
                                          // onTap: () async {
                                          //  // getLocation();
                                          //   var phone = _phoneNumberController.text;
                                          //   var name = _userController.text;
                                          //   print("-----423---$phone");
                                          //   print("-----424---$name");
                                          //
                                          //   if(_formKey.currentState!.validate() && phone != null && name != null){
                                          //     // Call Api
                                          //
                                          //      loginMap = await CitizenRegistrationRepo().citizenRegistration(context, phone!, name);
                                          //
                                          //      print('---431----$loginMap');
                                          //
                                          //     result = "${loginMap['Result']}";
                                          //     msg = "${loginMap['Msg']}";
                                          //     print('---434----$result');
                                          //     print('---435----$msg');
                                          //   }else{
                                          //     if(name.isEmpty){
                                          //      // phoneNumberfocus.requestFocus();
                                          //       displayToast("Please enter User name");
                                          //       return;
                                          //     }else if(phone.isEmpty){
                                          //       //userfocus.requestFocus();
                                          //       displayToast("Please enter Mobile Number");
                                          //     }
                                          //   } // condition to fetch a response form a api
                                          //   if(result=="1"){
                                          //
                                          //     // var iCitizenCode = "${loginMap['Data'][0]['iCitizenCode']}";
                                          //     // var sContactNo = "${loginMap['Data'][0]['sContactNo']}";
                                          //     // var sCitizenName = "${loginMap['Data'][0]['sCitizenName']}";
                                          //     // var sToken = "${loginMap['Data'][0]['sToken']}";
                                          //     // // To store value in  a SharedPreference
                                          //     //
                                          //     // SharedPreferences prefs = await SharedPreferences.getInstance();
                                          //     // prefs.setString('iCitizenCode',iCitizenCode);
                                          //     // prefs.setString('sContactNo',sContactNo);
                                          //     // prefs.setString('sCitizenName',sCitizenName);
                                          //     // prefs.setString('sToken',sToken);
                                          //
                                          //      // navigate to login screen
                                          //      Navigator.pushReplacement(context,
                                          //        MaterialPageRoute(builder: (context) => LoginScreen_2()),);
                                          //
                                          //     if(iCitizenCode =="1"){
                                          //
                                          //       // Navigator.pushReplacement(
                                          //       //   context,
                                          //       //   MaterialPageRoute(builder: (context) => HomePage()),
                                          //       // );
                                          //
                                          //
                                          //
                                          //       // print('----xxxx--------493---');
                                          //     }else{
                                          //       // HomeScreen_2
                                          //       // Navigator.pushReplacement(
                                          //       //   context,
                                          //       //   MaterialPageRoute(builder: (context) => HomeScreen_2()),
                                          //       // );
                                          //       print('----xxxx--------500---');
                                          //
                                          //     }
                                          //     // Navigator.pushReplacement(
                                          //     //   context,
                                          //     //   MaterialPageRoute(builder: (context) => HomePage()),
                                          //     // );
                                          //
                                          //   }else{
                                          //     print('----373---To display error msg---');
                                          //     displayToast(msg);
                                          //
                                          //   }
                                          // },
                                          child: Container(
                                            width: double.infinity, // Make container fill the width of its parent
                                            height: AppSize.s45,
                                            //  padding: EdgeInsets.all(AppPadding.p5),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF255899), // Background color using HEX value
                                              borderRadius: BorderRadius.circular(
                                                  AppMargin.m10), // Rounded corners
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Sign up",
                                                style: TextStyle(
                                                    fontSize: AppSize.s16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 13,right: 13),
                                        child: Container(
                                          height: 45,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end, // Distribute space between texts
                                            children: [
                                              // GestureDetector(
                                              //   onTap: (){
                                              //     // Navigator.push(
                                              //     //   context,
                                              //     //   MaterialPageRoute(builder: (context) => OtpPage(phone: "987195081",)),
                                              //     // );
                                              //   },
                                              //   child: Container(
                                              //     child: Text(
                                              //       "Already a user ?",
                                              //       style: AppTextStyle.font14penSansBlackTextStyle,
                                              //     ),
                                              //   ),
                                              // ),
                                              GestureDetector(
                                                onTap: (){
                                                  // Registration
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => const LoginScreen_2()),
                                                  );

                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(10.0), // 10dp padding around the text
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Color(0xFF255899)), // Gray border color
                                                    borderRadius: BorderRadius.circular(8.0), // Rounded corners for the border
                                                  ),
                                                  child: Text(
                                                    "Login",
                                                    style: AppTextStyle.font14penSansBlackTextStyle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )

            ),
      );
  }
  // toast code
  void displayToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}



// import 'dart:io';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../app/generalFunction.dart';
// import '../../services/login_repo.dart';
// import '../homepage/homepage.dart';
// import '../login/loginScreen_2.dart';
// import '../otp/otpverification.dart';
// import '../resources/app_text_style.dart';
// import '../resources/custom_elevated_button.dart';
// import '../resources/values_manager.dart';
//
// class Registration extends StatelessWidget {
//   const Registration({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginPage(),
//     );
//   }
// }
//
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   TextEditingController _phoneNumberController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _isObscured = true;
//   var loginProvider;
//
//   // focus
//   FocusNode phoneNumberfocus = FocusNode();
//   FocusNode namefocus = FocusNode();
//
//   bool passwordVisible = false;
//
//   // Visible and Unvisble value
//   int selectedId = 0;
//   var msg;
//   var result;
//   var loginMap;
//   double? lat, long;
//   GeneralFunction generalFunction = GeneralFunction();
//
//   Future<bool> _onWillPop() async {
//     return (await showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(
//               'Are you sure?',
//               style: AppTextStyle.font14OpenSansRegularBlackTextStyle,
//             ),
//             content: new Text(
//               'Do you want to exit app',
//               style: AppTextStyle.font14OpenSansRegularBlackTextStyle,
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () => Navigator.of(context).pop(false),
//                 //<-- SEE HERE
//                 child: Text('No'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   exit(0);
//                 }, //Navigator.of(context).pop(true), // <-- SEE HERE
//                 child: Text('Yes'),
//               ),
//             ],
//           ),
//         )) ??
//         false;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // getLocation();
//     Future.delayed(const Duration(milliseconds: 100), () {
//       // requestLocationPermission();
//       setState(() {
//         // Here you can write your code for open new view
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _phoneNumberController.dispose();
//     nameController.dispose();
//     super.dispose();
//   }
//
//   void clearText() {
//     _phoneNumberController.clear();
//     nameController.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: _onWillPop,
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               backgroundColor: Colors.red,
//               elevation: 10,
//               shadowColor: Colors.orange,
//               toolbarOpacity: 0.5,
//               leading: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const HomePage()),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   // Adjust padding if necessary
//                   child: Image.asset(
//                     "assets/images/back.png",
//                     fit: BoxFit
//                         .contain, // BoxFit.contain ensures the image is not distorted
//                   ),
//                 ),
//               ),
//               title: Text(
//                 'Registration',
//                 style: AppTextStyle.font16penSansExtraboldWhiteTextStyle,
//               ),
//               centerTitle: true,
//             ),
//             drawer: generalFunction.drawerFunction(
//                 context, 'Suaib Ali', '9871950881'),
//             body: Padding(
//               padding: const EdgeInsets.only(top: 25),
//               child: Form(
//                         key: _formKey,
//                         child: SingleChildScrollView(
//                           child: Column(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               middleHeaderPuri(context, 'Citizen Services'),
//                               SizedBox(height: 10),
//                               Container(
//                                         height: AppSize.s145,
//                                         width: MediaQuery.of(context).size.width - 50,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(8.0),
//                                           image: const DecorationImage(
//                                             image: AssetImage(
//                                               'assets/images/temple_3.png',
//                                             ),
//                                             fit: BoxFit.fill,
//                                           ),
//                                         ),
//                                     ),
//                               SizedBox(height: 20),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: AppPadding.p15, right: AppPadding.p15),
//                                 // PHONE NUMBER TextField
//                                 child: TextFormField(
//                                   focusNode: namefocus,
//                                   controller: nameController,
//                                   textInputAction: TextInputAction.next,
//                                   onEditingComplete: () =>
//                                       FocusScope.of(context).nextFocus(),
//                                   decoration: const InputDecoration(
//                                     // labelText: 'Mobile',
//                                     label: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0), // Padding for the label
//                                       child: Text('User Name'),
//                                     ),
//                                     border: OutlineInputBorder(),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.orange),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.orange),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     prefixIcon: Icon(
//                                       Icons.account_box,
//                                       color: Colors.orange,
//                                     ),
//                                   ),
//                                   autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Enter user number';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: AppPadding.p15, right: AppPadding.p15),
//                                 // PHONE NUMBER TextField
//                                 child: TextFormField(
//                                   focusNode: phoneNumberfocus,
//                                   controller: _phoneNumberController,
//                                   textInputAction: TextInputAction.next,
//                                   onEditingComplete: () =>
//                                       FocusScope.of(context).nextFocus(),
//                                   keyboardType: TextInputType.phone,
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(10),
//                                     // Limit to 10 digits
//                                     //FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only allow digits
//                                   ],
//                                   decoration: const InputDecoration(
//                                     // labelText: 'Mobile',
//                                     label: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 8.0), // Padding for the label
//                                       child: Text('Mobile No'),
//                                     ),
//                                     border: OutlineInputBorder(),
//                                     focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.orange),
//                                     ),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.orange),
//                                     ),
//                                     contentPadding:
//                                         EdgeInsets.symmetric(vertical: 10.0),
//                                     prefixIcon: Icon(
//                                       Icons.call,
//                                       color: Colors.orange,
//                                     ),
//                                   ),
//                                   autovalidateMode:
//                                       AutovalidateMode.onUserInteraction,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Enter mobile number';
//                                     }
//                                     if (value.length > 1 && value.length < 10) {
//                                       return 'Enter 10 digit mobile number';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//
//                               ElevatedButton(
//                                 child: Text('SIGNUP'),
//                                 style: ElevatedButton.styleFrom(
//                                   foregroundColor: Colors.white,
//                                   backgroundColor: Colors.red,
//                                   shadowColor: Colors.red, // Custom shadow color
//                                   elevation: 5, // Text color
//                                 ).copyWith(
//                                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                                         (Set<MaterialState> states) {
//                                       if (states.contains(MaterialState.pressed)) {
//                                         return Colors.yellow; // Splash color when pressed
//                                       }
//                                       return null; // Default splash color
//                                     },
//                                   )),
//                                 onPressed: () async {
//                                   var phone = _phoneNumberController.text;
//                                   var name = nameController.text;
//                                   if (_formKey.currentState!.validate() &&
//                                       name != null &&
//                                       name != null) {
//                                     print('----name---$name');
//                                     print('----phone---$phone');
//                                     print('---call Api---');
//
//                                     loginMap = await RegistrationRepo()
//                                         .authenticate(context, phone!, name!);
//                                     print('-----280---$loginMap');
//                                     result = "${loginMap['Result']}";
//                                     msg = "${loginMap['Msg']}";
//                                     print('----283---msg--$msg');
//                                   } else {
//                                     if (nameController.text.isEmpty) {
//                                       namefocus.requestFocus();
//                                     } else if (_phoneNumberController
//                                         .text.isEmpty) {
//                                       phoneNumberfocus.requestFocus();
//                                     }
//                                   }
//                                   if(result=="1"){
//                                               print('----Success---');
//                                              // displayToast(msg);
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(builder: (context) => OtpPage(phone: phone)),
//                                               );
//                                               Fluttertoast.showToast(
//                                                      msg: msg,
//                                                      toastLength: Toast.LENGTH_SHORT,
//                                                      gravity: ToastGravity.CENTER,
//                                                      timeInSecForIosWeb: 1,
//                                                      textColor: Colors.white,
//                                                      fontSize: 16.0
//                                                  );
//                                   }else{
//                                     Fluttertoast.showToast(
//                                         msg: msg,
//                                         toastLength: Toast.LENGTH_SHORT,
//                                         gravity: ToastGravity.CENTER,
//                                         timeInSecForIosWeb: 1,
//                                         textColor: Colors.white,
//                                         fontSize: 16.0
//                                     );
//                                   }
//                                 },
//                               ),
//                               SizedBox(height: 10),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 15, right: 15),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const Text(
//                                       'Already a user ?',
//                                       style: TextStyle(fontSize: 16),
//                                     ),
//                                     SizedBox(width: 8),
//                                     // Add some spacing between the texts
//                                     GestureDetector(
//                                       onTap: () {
//                                         //Handle the click event
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   LoginScreen_2()),
//                                         );
//                                       },
//                                       child: const Text(
//                                         'Login',
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.blue,
//                                           decoration: TextDecoration.underline,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                              // SizedBox(height: 10),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     // Spacer(),
//                     // Padding(
//                     //   padding: const EdgeInsets.only(left: 80),
//                     //   child: Align(
//                     //     alignment: Alignment.bottomCenter,
//                     //     child: Padding(
//                     //         padding: EdgeInsets.only(bottom: 5.0, left: 15),
//                     //         child: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.start,
//                     //           children: [
//                     //             Padding(
//                     //               padding: const EdgeInsets.only(right: 80),
//                     //               child: Text('Powered by :',
//                     //                   style: AppTextStyle
//                     //                       .font14OpenSansRegularBlackTextStyle),
//                     //             ),
//                     //             Row(
//                     //               mainAxisAlignment: MainAxisAlignment.start,
//                     //               children: <Widget>[
//                     //                 const Text(
//                     //                   'Synergy Telmatics Pvt.Ltd.',
//                     //                   style: TextStyle(
//                     //                     fontFamily: 'Montserrat',
//                     //                     color: Color(0xffF37339), //#F37339
//                     //                     fontSize: 14.0,
//                     //                     fontWeight: FontWeight.bold,
//                     //                   ),
//                     //                 ),
//                     //                 SizedBox(width: 10),
//                     //                 Padding(
//                     //                   padding:
//                     //                       EdgeInsets.only(right: AppSize.s10),
//                     //                   child: SizedBox(
//                     //                     width: 25,
//                     //                     height: 25,
//                     //                     child: Image.asset(
//                     //                       'assets/images/favicon.png',
//                     //                       width: 25,
//                     //                       height: 25,
//                     //                       fit: BoxFit
//                     //                           .fill, // Changed BoxFit to fill
//                     //                     ),
//                     //                   ),
//                     //                 ),
//                     //               ],
//                     //             ),
//                     //           ],
//                     //         )),
//                     //   ),
//                     // ),
//             )
//                 ));
//
//
//   }
//
//   void _showToast(BuildContext context, String msg) {
//     final scaffold = ScaffoldMessenger.of(context);
//     scaffold.showSnackBar(
//       SnackBar(
//         content: Text('$msg'),
//         action: SnackBarAction(
//             label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
//       ),
//     );
//   }
//
//   // toast code
//   void displayToast(String msg) {
//     Fluttertoast.showToast(
//         msg: msg,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }
// }

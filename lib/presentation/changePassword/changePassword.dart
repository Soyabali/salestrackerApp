import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import '../../app/sakestrackingtypography.dart';
import '../../services/changePassWordRepo.dart';
import '../loginaftersplace/loginaftersplace.dart';
import '../resources/app_text_style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../salestracker/dashboard/dashboard.dart';

class ChangePassword extends StatelessWidget {
  final name;
  const ChangePassword({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: changePassWordPage(),
    );
  }
}

class changePassWordPage extends StatefulWidget {
  const changePassWordPage({super.key});

  @override
  State<changePassWordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<changePassWordPage> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;
  bool _isObscured2 = true;
  bool _isObscured3 = true;
  var loginProvider;

  // focus
  FocusNode _oldPasswordfocus = FocusNode();
  FocusNode _newPasswordfocus = FocusNode();
  FocusNode _confirmPasswordfocus = FocusNode();
  // FocusNode userfocus = FocusNode();

  bool passwordVisible = false;
  // Visible and Unvisble value
  int selectedId = 0;
  var msg;
  var result;
  var loginMap;
  double? lat, long;
  GeneralFunction generalFunction = GeneralFunction();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocalDatabase();
    Future.delayed(const Duration(milliseconds: 100), () {
      // requestLocationPermission();
      setState(() {
        // Here you can write your code for open new view
      });
    });
  }

  getLocalDatabase() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? iUserType = prefs.getString('iUserType');
    print("-----81-----$iUserType");
    if (iUserType == "1") {
      print("-------83-----Card---$iUserType");
    } else {
      print("-------85-----Admin----$iUserType");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void clearText() {
    _oldPasswordController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }
  // WillPopScope(
  // onWillPop: () async => false,
  //
  // child: Scaffold

  Widget _customHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Image.asset('assets/images/bg_banner.png', fit: BoxFit.cover),
          // child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),

        ),
        SafeArea(
          child: Row(
            children: [
              const SizedBox(width: 20),

              InkWell(
                onTap: () {
                  // DashBoardSalesTrackerHome
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DashBoardSalesTrackerHome(),
                    ),
                        (route) => false,
                  );
                },
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),

              const SizedBox(width: 16),
              const Expanded(
                child: Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // const Text(
              //   "Change Password",
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },

        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Header
              _customHeader(context),

              SizedBox(height: 150),

              /// Form Card
              Transform.translate(
                offset: const Offset(0, -70),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// Title
                        Text(
                          "Change Password",
                          style: AppTextStyle.font14penSansBlackTextStyle
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                        ),

                        const SizedBox(height: 25),

                        /// Old Password
                        TextFormField(
                          focusNode: _oldPasswordfocus,
                          controller: _oldPasswordController,
                          obscureText: _isObscured,

                          decoration: InputDecoration(
                            labelText: "Old Password",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFc07bdb),
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),

                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        /// New Password
                        TextFormField(
                          focusNode: _newPasswordfocus,
                          controller: _newPasswordController,
                          obscureText: _isObscured2,

                          decoration: InputDecoration(
                            labelText: "New Password",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFc07bdb),
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),

                              onPressed: () {
                                setState(() {
                                  _isObscured2 = !_isObscured2;
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        /// Confirm Password
                        TextFormField(
                          focusNode: _confirmPasswordfocus,
                          controller: _confirmPasswordController,
                          obscureText: _isObscured3,

                          decoration: InputDecoration(
                            labelText: "Confirm Password",

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),

                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFc07bdb),
                            ),

                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscured3
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),

                              onPressed: () {
                                setState(() {
                                  _isObscured3 = !_isObscured3;
                                });
                              },
                            ),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        /// Update Button
                        commonGradientButton(
                          label: "Update",
                          onPressed: () async {

                            var oldPassword = _oldPasswordController.text.trim();
                            var newPassword = _newPasswordController.text.trim();
                            var confirmPassword = _confirmPasswordController.text.trim();

                            if (_formKey.currentState!.validate() &&
                                oldPassword.isNotEmpty &&
                                newPassword.isNotEmpty &&
                                confirmPassword.isNotEmpty) {

                              if (newPassword == confirmPassword) {

                                print("--Call Api---");

                                loginMap = await ChangePasswordRepo().changePasswrod(
                                  context,
                                  oldPassword,
                                  newPassword,
                                );

                                print('---358------xxxx-------$loginMap');

                                result = "${loginMap['Result']}";
                                msg = "${loginMap['Msg']}";

                                print('---361----$result');
                                print('---362----$msg');

                              } else {

                                print("--ConfirmPassword does not match---");

                                displayToast(
                                  "Confirm Password does not match",
                                );
                              }

                            } else {

                              if (_oldPasswordController.text.isEmpty) {

                                _oldPasswordfocus.requestFocus();
                                displayToast("Please Enter Old Password");
                                return;

                              } else if (_newPasswordController.text.isEmpty) {

                                _newPasswordfocus.requestFocus();
                                displayToast("Please Enter New Password");
                                return;

                              } else if (_confirmPasswordController.text.isEmpty) {

                                _confirmPasswordfocus.requestFocus();
                                displayToast("Please Enter Confirm Password");
                                return;
                              }
                            }

                            if (result == "1") {

                              print("----login success---");

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Loginaftersplace(),
                                ),
                                    (route) => false,
                              );

                            } else {

                              displayToast(msg);
                            }
                          },
                        ),
                        // SizedBox(
                        //   width: double.infinity,
                        //   height: 50,
                        //
                        //   child: ElevatedButton(
                        //     onPressed: () async {
                        //       //KEEP YOUR EXISTING API CODE HERE
                        //       var oldPassword = _oldPasswordController.text
                        //           .trim();
                        //       var newPassword = _newPasswordController.text
                        //           .trim();
                        //       var confirmPassword = _confirmPasswordController
                        //           .text
                        //           .trim();
                        //
                        //       if (_formKey.currentState!.validate() &&
                        //           oldPassword.isNotEmpty &&
                        //           newPassword.isNotEmpty &&
                        //           confirmPassword.isNotEmpty) {
                        //         if (newPassword == confirmPassword) {
                        //           print("--Call Api---");
                        //
                        //           loginMap = await ChangePasswordRepo()
                        //               .changePasswrod(
                        //                 context,
                        //                 oldPassword,
                        //                 newPassword,
                        //               );
                        //           print('---358------xxxx-------$loginMap');
                        //           result = "${loginMap['Result']}";
                        //           msg = "${loginMap['Msg']}";
                        //
                        //           print('---361----$result');
                        //           print('---362----$msg');
                        //         } else {
                        //           print("--ConfirmPassword does not match---");
                        //           displayToast(
                        //             "Confirm Password does not match",
                        //           );
                        //         }
                        //       } else {
                        //         if (_oldPasswordController.text.isEmpty) {
                        //           _oldPasswordfocus.requestFocus();
                        //           displayToast("Please Enter Old Password");
                        //           return;
                        //         } else if (_newPasswordController
                        //             .text
                        //             .isEmpty) {
                        //           _newPasswordfocus.requestFocus();
                        //           displayToast("Please Enter New Password");
                        //           return;
                        //         } else if (_confirmPasswordController
                        //             .text
                        //             .isEmpty) {
                        //           _confirmPasswordfocus.requestFocus();
                        //           displayToast("Please Enter Confirm Password");
                        //           return;
                        //         }
                        //       }
                        //       if (result == "1") {
                        //         print("----login success---");
                        //
                        //
                        //         Navigator.pushAndRemoveUntil(
                        //           context,
                        //           MaterialPageRoute(
                        //             builder: (context) => Loginaftersplace(),
                        //           ),
                        //               (route) => false,
                        //         );
                        //
                        //       } else {
                        //         displayToast(msg);
                        //         // toast to display error msg
                        //       }
                        //     },
                        //
                        //     style: ElevatedButton.styleFrom(
                        //       backgroundColor: const Color(0xFF255899),
                        //
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //     ),
                        //
                        //     child: const Text(
                        //       "Update",
                        //       style: TextStyle(
                        //         fontSize: 16,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return  WillPopScope(
  //     onWillPop: () async => false,
  //
  //     child: Scaffold(
  //         backgroundColor: Colors.white,
  //         body: GestureDetector(
  //           onTap: (){
  //             FocusScope.of(context).unfocus();
  //           },
  //           child: Padding(
  //               padding: const EdgeInsets.only(top: 25),
  //               child: SingleChildScrollView(
  //                 child: Center(
  //                   child: Column(
  //                     children: <Widget>[
  //                       _customHeader(context),
  //
  //                       SizedBox(height: 150),
  //
  //
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 25),
  //                         child: Align(
  //                           alignment: Alignment.centerLeft, // Align to the left
  //                           child: Text(
  //                             "Change Password",
  //                             style: AppTextStyle.font14penSansBlackTextStyle,
  //                           ),
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       /// Todo here we mention main code for a login ui.
  //                       GestureDetector(
  //                         onTap: () {
  //                           FocusScope.of(context).unfocus();
  //                         },
  //                         child: Form(
  //                           key: _formKey,
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(left: 10,right: 10),
  //                             child: Column(
  //                               children: <Widget>[
  //                                 Column(
  //                                   children: [
  //                                     // old Password
  //                                     Padding(padding: const EdgeInsets.only(left: AppPadding.p15, right: AppPadding.p15),
  //                                       // passWord TextFormField
  //                                       child: TextFormField(
  //                                         focusNode: _oldPasswordfocus,
  //                                         controller: _oldPasswordController,
  //                                         obscureText: _isObscured,
  //                                         decoration: InputDecoration(
  //                                           labelText: "Old Password",
  //                                           border: const OutlineInputBorder(),
  //                                           contentPadding: const EdgeInsets.symmetric(
  //                                             vertical: AppPadding.p10,
  //                                             horizontal: AppPadding.p10, // Add horizontal padding
  //                                           ),
  //                                           prefixIcon: const Icon(Icons.lock,
  //                                               color: Color(0xFF255899)),
  //                                           suffixIcon: IconButton(
  //                                             icon: Icon(_isObscured
  //                                                 ? Icons.visibility
  //                                                 : Icons.visibility_off),
  //                                             onPressed: () {
  //                                               setState(() {
  //                                                 _isObscured = !_isObscured;
  //                                               });
  //                                             },
  //                                           ),
  //                                         ),
  //                                         autovalidateMode:
  //                                         AutovalidateMode.onUserInteraction,
  //                                         validator: (value) {
  //                                           if (value!.isEmpty) {
  //                                             return 'Enter password';
  //                                           }
  //                                           if (value.length < 1) {
  //                                             return 'Please enter Valid Name';
  //                                           }
  //                                           return null;
  //                                         },
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 10),
  //                                     // new Password
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                       left: AppPadding.p15, right: AppPadding.p15),
  //                                       // passWord TextFormField
  //                                       child: TextFormField(
  //                                         focusNode: _newPasswordfocus,
  //                                         controller: _newPasswordController,
  //                                         obscureText: _isObscured2,
  //                                         decoration: InputDecoration(
  //                                           labelText: "New Password",
  //                                           border: const OutlineInputBorder(),
  //                                           contentPadding: const EdgeInsets.symmetric(
  //                                             vertical: AppPadding.p10,
  //                                             horizontal: AppPadding.p10, // Add horizontal padding
  //                                           ),
  //                                           prefixIcon: const Icon(Icons.lock,
  //                                               color: Color(0xFF255899)),
  //                                           suffixIcon: IconButton(
  //                                             icon: Icon(_isObscured2
  //                                                 ? Icons.visibility
  //                                                 : Icons.visibility_off),
  //                                             onPressed: () {
  //                                               setState(() {
  //                                                 _isObscured2 = !_isObscured2;
  //                                               });
  //                                             },
  //                                           ),
  //                                         ),
  //                                         autovalidateMode: AutovalidateMode.onUserInteraction,
  //                                         validator: (value) {
  //                                           if (value!.isEmpty) {
  //                                             return 'Enter password';
  //                                           }
  //                                           if (value.length < 1) {
  //                                             return 'Please enter Valid Name';
  //                                           }
  //                                           return null;
  //                                         },
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 10),
  //                                     // ConfirePassword
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(
  //                                       left: AppPadding.p15, right: AppPadding.p15),
  //                                       // confirm Password TextFormField
  //                                       child: TextFormField(
  //                                         focusNode: _confirmPasswordfocus,
  //                                         controller: _confirmPasswordController,
  //                                         obscureText: _isObscured3,
  //                                         decoration: InputDecoration(
  //                                           labelText: "Confirm Password",
  //                                           border: const OutlineInputBorder(),
  //                                           contentPadding: const EdgeInsets.symmetric(
  //                                             vertical: AppPadding.p10,
  //                                             horizontal: AppPadding.p10, // Add horizontal padding
  //                                           ),
  //                                           prefixIcon: const Icon(Icons.lock,
  //                                               color: Color(0xFF255899)),
  //                                           suffixIcon: IconButton(
  //                                             icon: Icon(_isObscured3
  //                                                 ? Icons.visibility
  //                                                 : Icons.visibility_off),
  //                                             onPressed: () {
  //                                               setState(() {
  //                                                 _isObscured3 = !_isObscured3;
  //                                               });
  //                                             },
  //                                           ),
  //                                         ),
  //                                         autovalidateMode: AutovalidateMode.onUserInteraction,
  //                                         validator: (value) {
  //                                           if (value!.isEmpty) {
  //                                             return 'Enter password';
  //                                           }
  //                                           if (value.length < 1) {
  //                                             return 'Please enter Valid Name';
  //                                           }
  //                                           return null;
  //                                         },
  //                                       ),
  //                                     ),
  //                                     SizedBox(height: 10),
  //
  //                                     Padding(
  //                                       padding: const EdgeInsets.only(left: 13,right: 13),
  //                                       child: InkWell(
  //
  //                                         onTap: () async {
  //
  //                                              var oldPassword = _oldPasswordController.text.trim();
  //                                              var newPassword = _newPasswordController.text.trim();
  //                                              var confirmPassword = _confirmPasswordController.text.trim();
  //
  //                                           print("---oldPassword--$oldPassword");
  //                                           print("----newPassword ---$newPassword");
  //                                           print("----confirmPassword ---$confirmPassword");
  //
  //                                           if(_formKey.currentState!.validate() && oldPassword.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty){
  //                                             // Call Api
  //                                             //again condition
  //
  //                                             if(newPassword==confirmPassword){
  //                                                 print("--Call Api---");
  //
  //                                                   loginMap = await ChangePasswordRepo().changePasswrod(context, oldPassword,newPassword);
  //                                                   print('---358----$loginMap');
  //                                                   result = "${loginMap['Result']}";
  //                                                   msg = "${loginMap['Msg']}";
  //                                                   print('---361----$result');
  //                                                   print('---362----$msg');
  //
  //                                               }else{
  //                                                 print("--ConfirmPassword does not match---");
  //                                                 displayToast("Confirm Password does not match");
  //                                               }
  //
  //                                           }else{
  //                                             if(_oldPasswordController.text.isEmpty){
  //                                               _oldPasswordfocus.requestFocus();
  //                                               displayToast("Please Enter Old Password");
  //                                               return;
  //                                             }else if(_newPasswordController.text.isEmpty){
  //                                               _newPasswordfocus.requestFocus();
  //                                               displayToast("Please Enter New Password");
  //                                               return;
  //                                             }else if(_confirmPasswordController.text.isEmpty){
  //                                               _confirmPasswordfocus.requestFocus();
  //                                               displayToast("Please Enter Confirm Password");
  //                                               return;
  //                                             }
  //                                           } // condition to fetch a response form a api
  //                                           if(result=="1") {
  //
  //                                             SharedPreferences prefs = await SharedPreferences.getInstance();
  //                                             var iUserType = prefs.getString('iUserType');
  //                                             print("------133---$iUserType");
  //                                             if(iUserType=="1"){
  //                                               print("------Gard-----$iUserType");
  //
  //                                               // Navigator.push(
  //                                               //   context,
  //                                               //   MaterialPageRoute(builder: (context) => VisitorLoginEntry()),
  //                                               // );
  //                                               Navigator.push(
  //                                                 context,
  //                                                 MaterialPageRoute(builder: (context) => VmsHome()),
  //                                               );
  //
  //                                             }else{
  //                                               print("------Admin-----$iUserType");
  //
  //                                               Navigator.push(
  //                                                 context,
  //                                                 MaterialPageRoute(builder: (context) => VisitorDashboard()),
  //                                               );
  //                                             }
  //
  //
  //                                             // Navigator.pushReplacement(
  //                                             //         context,
  //                                             //         MaterialPageRoute(builder: (context) => LoginScreen_2()),
  //                                             //       );
  //
  //
  //                                           }else{
  //                                             print('----373---To display error msg---');
  //                                             displayToast(msg);
  //                                           }
  //                                         },
  //                                         /// todo remoe this comments
  //                                         // onTap: () async {
  //                                         //   var oldPassword = _oldPasswordController.text.trim();
  //                                         //   var newPassword = _newPasswordController.text.trim();
  //                                         //   var confirmPassword = _confirmPasswordController.text.trim();
  //                                         //
  //                                         //   print("Old Password -----$oldPassword");
  //                                         //   print("newPassword -----$newPassword");
  //                                         //   print("confirmPassword -----$confirmPassword");
  //                                         //
  //                                         //   if(newPassword==confirmPassword){
  //                                         //     print("--Call Api---");
  //                                         //
  //                                         //       loginMap = await ChangePasswordRepo().changePasswrod(context, oldPassword!,newPassword);
  //                                         //       print('---358----$loginMap');
  //                                         //       result = "${loginMap['Result']}";
  //                                         //       msg = "${loginMap['Msg']}";
  //                                         //       print('---361----$result');
  //                                         //       print('---362----$msg');
  //                                         //
  //                                         //   }else{
  //                                         //     print("--ConfirmPassword does not match---");
  //                                         //     displayToast("Confirm Password does not match");
  //                                         //   }
  //                                         //   if(result=="1"){
  //                                         //     // to login PAGE
  //                                         //       Navigator.pushReplacement(
  //                                         //         context,
  //                                         //         MaterialPageRoute(builder: (context) => LoginScreen_2()),
  //                                         //       );
  //                                         //   }else{
  //                                         //     // SAME PAGE WITH NOTIFICATION
  //                                         //     displayToast(msg);
  //                                         //   }
  //                                         //
  //                                         //   },
  //
  //                                         child: Container(
  //                                           width: double.infinity, // Make container fill the width of its parent
  //                                           height: AppSize.s45,
  //                                           //  padding: EdgeInsets.all(AppPadding.p5),
  //                                           decoration: BoxDecoration(
  //                                             color: Color(0xFF255899), // Background color using HEX value
  //                                             borderRadius: BorderRadius.circular(
  //                                                 AppMargin.m10), // Rounded corners
  //                                           ),
  //                                           child: const Center(
  //                                             child: Text(
  //                                               "Update",
  //                                               style: TextStyle(
  //                                                   fontSize: AppSize.s16,
  //                                                   color: Colors.white),
  //                                             ),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //
  //                                   ],
  //                                 ),
  //
  //                               ],
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               )),
  //         )),
  //   );
  // }
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
}

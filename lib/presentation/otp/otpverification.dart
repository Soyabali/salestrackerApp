import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/verifyCitizenOTP.dart';
import '../forgotPassword/forgotPassword.dart';
import '../login/loginScreen_2.dart';
import '../resources/app_text_style.dart';
import '../resources/values_manager.dart';

class OtpPage extends StatefulWidget {

  final phone;
  const OtpPage({super.key,required this.phone});

  @override
  State<OtpPage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<OtpPage> {

  var phoneNumber;
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPassWordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  //  _nameController
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController>? controllers;
  List<FocusNode>? focusNodes;
  FocusNode _contactNofocus = FocusNode();
  var otpverificationResponse;
  var result ;
  var msg ;
  var verifyCitizenOtpMap;
  bool _isObscured = true;
  bool _isObscured2 = true;

  void clearText() {
    _newPasswordController.clear();
    _confirmPassWordController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('------45----${widget.phone}');
    phoneNumber = "${widget.phone}";
    _contactNofocus = FocusNode();
    controllers = List.generate(4, (_) => TextEditingController());
    focusNodes = List.generate(4, (_) => FocusNode());
    focusNodes?[0].requestFocus();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _contactNofocus.dispose();
    _newPasswordController.dispose();
    _confirmPassWordController.dispose();
    for (var controller in controllers!) {
      controller.dispose();
    }
    for (var node in focusNodes!) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pop Screen Disabled.',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.white,
        ),
      );
      return false; // Prevent the back button action
    },
      child: Scaffold(
        backgroundColor: Colors.white,
        //appBar: getAppBarBack(context,"OTP Verification"),
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
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
              );
            },
            child: const Icon(Icons.arrow_back_ios,
              color: Colors.white,),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'OTP Verification',
              style: AppTextStyle.font16OpenSansRegularWhiteTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          //centerTitle: true,
          elevation: 0, // Removes shadow under the AppBar
        ),

        // drawer
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Security Check',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff3f617d),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Your password is safe with us.',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff3f617d),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'OTP has been sent on : ${widget.phone}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                color: Color(0xff3f617d),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 120.0),
                            Container(
                              //color: Colors.white,
                              height: 400,
                              decoration: BoxDecoration(
                                // Set container color
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(20), // Set border radius
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15.0, right: 15.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 10.0),
                                      Center(
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(40),
                                              // border: Border.all(color: Colors.black),
                                              // Just for visualization
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white.withOpacity(0.5), // Set shadow color
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: const Icon(
                                              Icons.phone,
                                              size: 35,
                                              //color: Color(0xFF255899),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: List.generate(4, (index) {
                                            return SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 5, top: 0),
                                                child: Center(
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    child: TextField(
                                                      controller: controllers?[index],
                                                      focusNode: focusNodes?[index],
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(1),
                                                      ],
                                                      onChanged: (value) {
                                                        if (value.isNotEmpty &&
                                                            index < 3) {
                                                          FocusScope.of(context)
                                                              .requestFocus(focusNodes?[
                                                                  index + 1]);
                                                        } else if (value.isEmpty &&
                                                            index > 0) {
                                                          FocusScope.of(context)
                                                              .requestFocus(focusNodes?[
                                                                  index - 1]);
                                                        }
                                                      },
                                                     // maxLength: 1,
                                                      textAlign: TextAlign.center,
                                                      keyboardType: TextInputType.number,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Form(
                                          key: _formKey,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: AppPadding.p15, right: AppPadding.p15),
                                                  // passWord TextFormField
                                                  child: TextFormField(
                                                    controller:_newPasswordController,
                                                    obscureText: _isObscured,
                                                    decoration: InputDecoration(
                                                      labelText: "New Password",
                                                      border: const OutlineInputBorder(),
                                                      contentPadding: const EdgeInsets.symmetric(
                                                        vertical: AppPadding.p10,
                                                        horizontal: AppPadding.p10, // Add horizontal padding
                                                      ),
                                                      prefixIcon: const Icon(Icons.lock,
                                                          color: Color(0xFF255899)),
                                                      suffixIcon: IconButton(
                                                        icon: Icon(_isObscured
                                                            ? Icons.visibility
                                                            : Icons.visibility_off),
                                                        onPressed: () {
                                                          setState(() {
                                                            _isObscured = !_isObscured;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    autovalidateMode:
                                                    AutovalidateMode.onUserInteraction,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return 'Enter New password';
                                                      }
                                                      if (value.length < 1) {
                                                        return 'Please enter Valid Name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: AppPadding.p15, right: AppPadding.p15),
                                                  // passWord TextFormField
                                                  child: TextFormField(
                                                     controller: _confirmPassWordController,
                                                    obscureText: _isObscured2,
                                                    decoration: InputDecoration(
                                                      labelText: "Confirm Password",
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
                                                        return 'Enter Confirm password';
                                                      }
                                                      if (value.length < 1) {
                                                        return 'Please enter Valid Name';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                InkWell(
                                                  onTap: () async {

                                                    String otp = '';
                                                    for (var controller in controllers!)
                                                    {
                                                      otp += controller.text;
                                                    }
                                                    // Now you have the OTP value in the 'otp' variable
                                                    print('OTP---260: $otp');

                                                    var newPassword = _newPasswordController.text.trim();
                                                    var confirmPassword = _confirmPassWordController.text.trim();



                                                    if (_formKey.currentState!.validate() &&
                                                        otp != null && phoneNumber != null)
                                                      {
                                                        print('----otp----276---$otp');
                                                        print('----contactNo----269---${{widget.phone}}');
                                                        if(newPassword==confirmPassword){
                                                          verifyCitizenOtpMap = await VerifyCitizenOtpRepo().verifyCitizenOtp(context, otp,newPassword,phoneNumber);
                                                          print('-----otp response----362---$verifyCitizenOtpMap');
                                                          result = "${verifyCitizenOtpMap['Result']}";
                                                          msg = "${verifyCitizenOtpMap['Msg']}";
                                                          print('---410----$result');

                                                        }else{
                                                          _showToast(context,"Password mismatch");
                                                        }

                                                      }
                                                     else{
                                                      if(_nameController.text.isEmpty){
                                                        _contactNofocus.requestFocus();
                                                      }
                                                    }// condition to fetch response and take a action behafe of action
                                                    if(result=="1"){

                                                          // var sContactNo = "${verifyCitizenOtpMap['Data'][0]['sContactNo']}";
                                                          // var sCitizenName = "${verifyCitizenOtpMap['Data'][0]['sCitizenName']}";
                                                          // var sGender = "${verifyCitizenOtpMap['Data'][0]['sGender']}";
                                                          // var sEmailId = "${verifyCitizenOtpMap['Data'][0]['sEmailId']}";
                                                          // var sToken = "${verifyCitizenOtpMap['Data'][0]['sToken']}";
                                                          // // to store the value in local dataBase
                                                          //
                                                          // SharedPreferences prefs = await SharedPreferences.getInstance();
                                                          // prefs.setString('sGender',sGender);
                                                          // prefs.setString('sContactNo',sContactNo);
                                                          // prefs.setString('sCitizenName',sCitizenName);
                                                          // prefs.setString('sEmailId',sEmailId);
                                                          // prefs.setString('sToken',sToken);
                                                          //
                                                          // String? token = prefs.getString('sToken');
                                                         // print('---321-----token---$token');

                                                          //  LoginScreen_2

                                                          // Navigator.push(
                                                          //   context,
                                                          //   MaterialPageRoute(builder: (context) => const ComplaintHomePage()),
                                                          // );
                                                         _showToast(context,msg);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(builder: (context) => const LoginScreen_2()),
                                                          );
                                                           controllers?.clear();
                                                          _newPasswordController.clear();
                                                          _confirmPassWordController.clear();

                                                    }else{
                                                      _showToast(context,msg);
                                                    }
                                                    },

                                                  child: Container(
                                                    width: double
                                                        .infinity, // Make container fill the width of its parent
                                                    height: 45,
                                                    padding:
                                                        const EdgeInsets.all(5.0),
                                                    decoration: BoxDecoration(
                                                      color: const Color(0xFF255899), // Background color using HEX value
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0), // Rounded corners
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        'Submit',
                                                        style: TextStyle(
                                                            fontFamily: 'Montserrat',
                                                            color: Colors.white,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showToast(BuildContext context,String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text('$msg'),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/registration/registration.dart';
import '../presentation/resources/app_text_style.dart';
import 'CitizenVerifiedOTP/CitizenVerifiedOTPREPO.dart';


class OtpPageRegistration extends StatefulWidget {

  final phone;
  const OtpPageRegistration({super.key,required this.phone});

  @override
  State<OtpPageRegistration> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<OtpPageRegistration> {

  var phoneNumber;
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  List<TextEditingController>? controllers;
  List<FocusNode>? focusNodes;
  FocusNode _contactNofocus = FocusNode();
  var otpverificationResponse;
  var result ;
  var msg ;
  var verifyCitizenOtpMap;

  void clearText() {
    _nameController.clear();
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Colors.red,
        backgroundColor: Color(0xFF255899),
        elevation: 10,
        shadowColor: Colors.orange,
        toolbarOpacity: 0.5,
        leading: InkWell(
          onTap: () {
            //  HomePage
            //Navigator.pop(context);

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Registration()),
            );

          },
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Adjust padding if necessary
            child: Image.asset(
              "assets/images/back.png",
              fit: BoxFit.contain, // BoxFit.contain ensures the image is not distorted
            ),
          ),
        ),
        title: Text(
          'OTP Verification',
          style: AppTextStyle.font16penSansExtraboldWhiteTextStyle,
        ),
        centerTitle: true,
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
                            height: 300,
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
                                              InkWell(
                                                onTap: () async {

                                                  String otp = '';
                                                  for (var controller in controllers!)
                                                  {
                                                    otp += controller.text;
                                                  }
                                                  // Now you have the OTP value in the 'otp' variable
                                                  print('OTP---260: $otp');
                                                  if (_formKey.currentState!.validate() && otp != null)
                                                  {
                                                    print('----otp----276---$otp');
                                                    print('----contactNo----269---${{widget.phone}}');

                                                    //verifyCitizenOtpMap = await VerifyCitizenOtpRepo().verifyCitizenOtp(context, otp!);
                                                    verifyCitizenOtpMap = await CitizenVerifiedOtpRepo().citizenVerifyOtp(context, otp,phoneNumber);
                                                    print('-----verifyCityzen----269---$verifyCitizenOtpMap');

                                                    result = "${verifyCitizenOtpMap['Result']}";
                                                    msg = "${verifyCitizenOtpMap['Msg']}";
                                                    print('---410----$result');

                                                  }
                                                  else{
                                                    if(_nameController.text.isEmpty){
                                                      _contactNofocus.requestFocus();
                                                    }
                                                  }// condition to fetch response and take a action behafe of action
                                                  if(result=="1"){

                                                    var iCitizenCode = "${verifyCitizenOtpMap['Data'][0]['iCitizenCode']}";
                                                    var sContactNo =
                                                        "${verifyCitizenOtpMap['Data'][0]['sContactNo']}";
                                                    var sCitizenName =
                                                        "${verifyCitizenOtpMap['Data'][0]['sCitizenName']}";
                                                    var sToken =
                                                        "${verifyCitizenOtpMap['Data'][0]['sToken']}";
                                                    // to store the value in local dataBase

                                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                                    prefs.setString('iCitizenCode',iCitizenCode);
                                                    prefs.setString('sContactNo',sContactNo);
                                                    prefs.setString('sCitizenName',sCitizenName);
                                                    prefs.setString('sToken',sToken);
                                                    String? token = prefs.getString('sToken');
                                                    print('---321-----token---$token');

                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(builder: (context) => const ComplaintHomePage()),
                                                    // );
                                                    controllers?.clear();

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

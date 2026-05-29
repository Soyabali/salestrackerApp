
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import '../../app/generalFunction.dart';
import '../../services/forgotpassword.dart';
import '../login/loginScreen_2.dart';
import '../otp/otpverification.dart';
import '../resources/app_strings.dart';
import '../resources/app_text_style.dart';
import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatelessWidget {

  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPassWordPage(),
    );
  }
}

class ForgotPassWordPage extends StatefulWidget {

  const ForgotPassWordPage({super.key});

  @override
  State<ForgotPassWordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ForgotPassWordPage> {

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
  var sToken;
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
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
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
  turnOnLocationMsg(){
    if((lat==null && lat=='') ||(long==null && long=='')){
      displayToast("Please turn on Location");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
    if(lat==null || lat==''){
      turnOnLocationMsg();
    }
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
    return WillPopScope(
      //onWillPop: _onWillPop,
        onWillPop: () async => false,
    child: GestureDetector(
    onTap: (){
    FocusScope.of(context).unfocus();
    },
      child: Scaffold(
          backgroundColor: Colors.white,
          // appBar
          appBar: AppBar(
            // statusBarColore
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF12375e),
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.light, // For iOS (dark icons)
            ),
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
              child: const Icon(Icons.arrow_back_ios,
                color: Colors.white,),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'Forgot Password',
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
                            "Forgot Password",
                            style: AppTextStyle.font14penSansBlackTextStyle,
                          ),
                        ),
                      ),
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
                                    SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: AppPadding.p15, right: AppPadding.p15),
                                      // PHONE NUMBER TextField
                                      child: TextFormField(
                                        focusNode: phoneNumberfocus,
                                        controller: _phoneNumberController,
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
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13,right: 13),
                                      child: InkWell(
                                        onTap: ()async{
                                          var phone = _phoneNumberController.text.trim();
                                          if(_formKey.currentState!.validate() && phone.isNotEmpty){
                                            // Call Api
                                            loginMap = await ForgotPasswordRepo().forgotFassWord(context, phone);

                                            print('---417----$loginMap');

                                            result = "${loginMap['Result']}";
                                            msg = "${loginMap['Msg']}";
                                            sToken = "${loginMap['sToken']}";

                                            print('---361----$result');
                                            print('---362----$msg');
                                          }else{
                                            if(_phoneNumberController.text.isEmpty){
                                              phoneNumberfocus.requestFocus();
                                            }
                                          } // condition to fetch a response form a api
                                          if(result=="1"){
                                            // todo here you shuld save a token and used otpPage
                                           // var sToken = "${loginMap['Data'][0]['sToken']}";
                                            // to store the value in local dataBase

                                              // SharedPreferences prefs = await SharedPreferences.getInstance();
                                             //prefs.setString('sToken',sToken);

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => OtpPage(phone:phone)),
                                            );

                                          }else{
                                            print('----373---To display error msg---');
                                            displayToast(msg);
                                        }
                                        },
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
                                              "Send Otp",
                                              style: TextStyle(
                                                  fontSize: AppSize.s16,
                                                  color: Colors.white),
                                            ),
                                          ),
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
          )),
    ));
  }
  // toast code
  void displayToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}


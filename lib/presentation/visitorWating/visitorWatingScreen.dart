import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../app/generalFunction.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../vmsHome/vmsHome.dart';


class VisitorWatingScreenPage extends StatefulWidget {

  final sSubmitMessage,sProgressImg;

  VisitorWatingScreenPage(this.sSubmitMessage, this.sProgressImg, {super.key});

  @override
  State<VisitorWatingScreenPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<VisitorWatingScreenPage> {

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async => false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Hide keyboard
          },
          child: Stack(
            children: [
              // Full-screen background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg1.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned(
              //   top: 0, // Start from the top
              //   left: 0,
              //   right: 0,
              //   height:
              //   MediaQuery.of(context).size.height *
              //       0.7, // 70% of screen height
              //   child: Image.asset(
              //     'assets/images/bg1.jpeg', // Replace with your image path
              //     fit: BoxFit.cover, // Covers the area properly
              //   ),
              // ),
              // Top image (height: 80, margin top: 20)
              Positioned(
                top: 70,
                left: 20,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    print("------262--------");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VmsHome()),
                    );
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/backtop.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // company logo on a top
              // Positioned(
              //   top: 85,
              //   left: 95,
              //   child: Center(
              //     child: Container(
              //       height: 32,
              //       //width: 140,
              //       child: Image.asset(
              //         'assets/images/synergylogo.png', // Replace with your image path
              //         // Set height
              //         fit: BoxFit.cover, // Ensures the image fills the given size
              //       ),
              //     ),
              //   ),
              // ),

              // Positioned(
              //   top: 130,
              //   left: 35,
              //   right: 35,
              //   child: Center(
              //     child: Image.asset(
              //       'assets/images/loginupper.png', // Replace with your image path
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              // ),
              // Positioned(
              //   top: 400,
              //
              //   left: MediaQuery.of(context).size.width > 600
              //       ? MediaQuery.of(context).size.width * 0.2
              //       : 15,
              //
              //   right: MediaQuery.of(context).size.width > 600
              //       ? MediaQuery.of(context).size.width * 0.2
              //       : 15,
              //
              //   child: SingleChildScrollView(
              //     keyboardDismissBehavior:
              //     ScrollViewKeyboardDismissBehavior.onDrag,
              //
              //     child: GlassmorphicContainer(
              //       height: 350,
              //
              //       width: double.infinity,
              //
              //       borderRadius: 22,
              //
              //       blur: 15,
              //
              //       alignment: Alignment.center,
              //
              //       border: 1.5,
              //
              //       linearGradient: LinearGradient(
              //         begin: Alignment.topLeft,
              //         end: Alignment.bottomRight,
              //
              //         colors: [
              //           Colors.white.withOpacity(0.20),
              //           Colors.white.withOpacity(0.08),
              //         ],
              //       ),
              //
              //       borderGradient: LinearGradient(
              //         colors: [
              //           Colors.white.withOpacity(0.4),
              //           Colors.white.withOpacity(0.1),
              //         ],
              //       ),
              //
              //       child: Padding(
              //         padding: const EdgeInsets.all(15),
              //
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //
              //           children: [
              //
              //             /// TOP STATUS CONTAINER
              //             Padding(
              //               padding:
              //               const EdgeInsets.symmetric(horizontal: 15),
              //
              //               child: Container(
              //                 width: double.infinity,
              //                 height: 38,
              //
              //                 decoration: BoxDecoration(
              //                   color: Colors.white.withOpacity(0.18),
              //
              //                   borderRadius:
              //                   BorderRadius.circular(18),
              //
              //                   border: Border.all(
              //                     color: Colors.white.withOpacity(0.25),
              //                   ),
              //                 ),
              //
              //                 alignment: Alignment.center,
              //
              //                 child: const Text(
              //                   "Request in Progress",
              //
              //                   style: TextStyle(
              //                     color: Colors.white,
              //                     fontSize: 16,
              //                     fontWeight: FontWeight.bold,
              //                     letterSpacing: 0.3,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //
              //             const SizedBox(height: 12),
              //
              //             /// FORM AREA
              //             Expanded(
              //               child: GestureDetector(
              //                 onTap: () {
              //                   FocusScope.of(context).unfocus();
              //                 },
              //
              //                 child: Form(
              //                   key: _formKey,
              //
              //                   child: Padding(
              //                     padding: const EdgeInsets.symmetric(
              //                       horizontal: 10,
              //                     ),
              //
              //                     child: Column(
              //                       mainAxisSize: MainAxisSize.min,
              //
              //                       children: [
              //
              //                         /// MESSAGE
              //                         Text(
              //                           '${widget.sSubmitMessage}',
              //
              //                           textAlign: TextAlign.center,
              //
              //                           style: const TextStyle(
              //                             color: Colors.white,
              //                             fontSize: 16,
              //                             height: 1.4,
              //                             fontWeight: FontWeight.w500,
              //                           ),
              //
              //                           maxLines: 3,
              //                           overflow: TextOverflow.ellipsis,
              //                         ),
              //
              //                         const SizedBox(height: 20),
              //
              //                         /// IMAGE
              //                         Expanded(
              //                           child: Center(
              //                             child: Container(
              //                               padding:
              //                               const EdgeInsets.all(12),
              //
              //                               decoration: BoxDecoration(
              //                                 shape: BoxShape.circle,
              //
              //                                 color: Colors.white
              //                                     .withOpacity(0.08),
              //
              //                                 border: Border.all(
              //                                   color: Colors.white
              //                                       .withOpacity(0.20),
              //                                 ),
              //                               ),
              //
              //                               child: Image.network(
              //                                 '${widget.sProgressImg}',
              //
              //                                 fit: BoxFit.contain,
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Positioned(
                top: 400,
                left: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.width * 0.2 // 20% padding on tablets
                    : 15, // 15px padding on mobile
                right: MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.width * 0.2 // 20% padding on tablets
                    : 15, // 15px padding on mobile
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Container(
                      height: 350,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              width: double.infinity,
                              height: 35,
                              // decoration: BoxDecoration(
                              //   color: Color(0xFFC9EAFE),
                              //   borderRadius: BorderRadius.circular(17),
                              //   boxShadow: const [
                              //     BoxShadow(
                              //       color: Colors.black26,
                              //       blurRadius: 3,
                              //       spreadRadius: 2,
                              //       offset: Offset(2, 4),
                              //     ),
                              //   ],
                              // ),
                              alignment: Alignment.center,
                              child: const Text(
                                "Request in Progress",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    color: Colors.white,
                                    child: SingleChildScrollView( // Allows scrolling when content overflows
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min, // Prevents unnecessary stretching
                                        children: <Widget>[
                                          SizedBox(height: 10),
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              return ConstrainedBox(
                                                constraints: BoxConstraints(
                                                  maxWidth: constraints.maxWidth * 0.9, // 90% of parent width
                                                ),
                                                child: Text(
                                                  '${widget.sSubmitMessage}',
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16, // Reduce font size slightly for better fit
                                                  ),
                                                  softWrap: true,
                                                  maxLines: 3, // Limits text to 3 lines
                                                  overflow: TextOverflow.ellipsis, // Adds "..." if text is too long
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10),
                                          Center(
                                            child: LayoutBuilder(
                                              builder: (context, constraints) {
                                                double imageSize = constraints.maxWidth * 0.4; // Image adjusts to 40% of width
                                                return Container(
                                                  height: imageSize.clamp(80, 150), // Min 80px, Max 150px
                                                  width: imageSize.clamp(80, 150),
                                                  child: Image.network(
                                                    '${widget.sProgressImg}',
                                                    fit: BoxFit.contain, // Ensures the full image is visible
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Positioned(
              //   bottom: 10, // Distance from the bottom
              //   left: 0,
              //   right: 0, // Ensures centering
              //   child: Center( // Centers the logo horizontally
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 13),
              //       child: Image.asset(
              //         'assets/images/companylogo2.png',
              //         fit: BoxFit.fill, // Stretches to fill the height & width
              //         height: 50, // Increase height
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
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

import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:puri/presentation/salestracker/dashboard/payslippdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/customdrawer.dart';
import '../../../app/generalFunction.dart';
import '../../../app/loader_helper.dart';
import '../../../main.dart';
import '../../../model/OpportunityListModel.dart';
import '../../../services/OpportunityDetailsRepo.dart';
import '../../../services/baseurl.dart';
import '../../../services/vmsUpdateGsmId.dart';
import 'package:dotted_border/dotted_border.dart';

import '../updateServy/updateservy.dart';


class DashBoardSalesTrackerHome extends StatefulWidget {
  const DashBoardSalesTrackerHome({super.key});

  @override
  State<DashBoardSalesTrackerHome> createState() => _DashBoardSalesTrackerHomeState();
}

class _DashBoardSalesTrackerHomeState extends State<DashBoardSalesTrackerHome> {

  GeneralFunction generalFunction = GeneralFunction();
  var sUserName;
  var sContactNo;
  var token;
  AudioPlayer player = AudioPlayer();
  var result,msg;
  File? image;
  List<OpportunityData> opportunityList = [];
  List<String> uploadedDocuments = [];
  var uplodedImage;
  var sUserName2;
  String? uplodedImage2;



  Future<void> getUploadedImage() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String? imageUrl = prefs.getString('uplodedImage');

    print("Retrieved Image URL -xxxxx---x => $imageUrl");

    setState(() {
      uplodedImage2 = imageUrl;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getUploadedImage();
    setupPushNotifications();
    OpportunityDetails();
    toGetLocalData();

    super.initState();
  }
   // callOpportunityDetails

  toGetLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     sUserName2 = prefs.getString('sUserName');
    print("----UserName-----$sUserName2");

  }

  void OpportunityDetails() async {

    var opportunity =
    await OpportunitydetailsRepo().opportunity(context);

    result = "${opportunity['Result']}";
    msg = "${opportunity['Msg']}";

    if (result == "1") {

      List data = opportunity["Data"];

      setState(() {

        opportunityList = data
            .map((e) => OpportunityData.fromJson(e))
            .toList();

        uploadedDocuments.clear();

        for (var item in opportunityList) {

          List<String> docs = [
            item.sUploadDoc1 ?? "",
            item.sUploadDoc2 ?? "",
            item.sUploadDoc3 ?? "",
            item.sUploadDoc4 ?? "",
            item.sUploadDoc5 ?? "",
            item.sUploadDoc6 ?? "",
          ];

          uploadedDocuments.addAll(
            docs.where(
                  (doc) =>
              doc.isNotEmpty &&
                  !doc.contains("NoDocUploaded"),
            ),
          );
        }
      });

      print("Document List = $uploadedDocuments");
      print("Document Count = ${uploadedDocuments.length}");
    }
  }
  //-------xxx-----notification code---------

  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;
    await fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    token = await fcm.getToken();
    print("📌 Token: $token");
    // call Gsmid
    updateGsmid();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("📦 Data Payload: ${message.data}");
      playNotificationSound();

      if (message.notification != null) {
        var title = message.notification!.title ?? "New Notification";
        var body = message.notification!.body ?? "You have received a new message";

        print("🔔 Foreground Notification Received: $title - $body");
        playNotificationSound();
        // Show notification dialog (User must click "OK" to proceed)
        _showNotificationDialog(title, body);
      }
    });
  }
  //
  updateGsmid()async{
    if(token!=null){
      var UpdateGsmid = await VmsUpdateGsmid().vmsUpdateGsmid(context,token);
      print("-------Update Gsmid--------105-----$UpdateGsmid");
    }else{

    }
  }
  // notification Dialog
  void _showNotificationDialog(String title, String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      barrierDismissible: false, // Prevents user from closing manually
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Rounded Dialog
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent], // Attractive gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Notification Icon
                Icon(Icons.notifications_active, size: 50, color: Colors.white),
                SizedBox(height: 10),

                // Title
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),

                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 15),

                // Custom Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded button
                    ),
                    backgroundColor: Colors.amberAccent, // Attractive button color
                    elevation: 5,
                  ),
                  onPressed: () {
                    _stop(); // Stop sound
                    // call api
                    // getLocatDataBase();
                    Navigator.pop(context); // Close Dialog
                    //_navigateToVisitorList(title, message); // Navigate to new screen
                  },
                  child: Text(
                    "View",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  //
  Future<void> _stop() async {
    await player.stop();// Force stop the sound
  }
  // play notification
  void playNotificationSound() async {
    await player.stop(); // Stop any previous sound
    await player.release(); // Release resources
    await player.setVolume(0.5);
    await player.play(AssetSource('sounds/coustom_sound.wav'), mode: PlayerMode.mediaPlayer);

    // Automatically stop the sound after 2 seconds
    Future.delayed(Duration(seconds: 2), () async {
      await player.stop();
    });
  }

 // mainCard
  Widget bidCard(OpportunityData item) {

    print("------234---${item}");

    return Card(
      color: Colors.white, // Background Color
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// HEADER ROW
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text(
                  "BID",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff651FFF),
                  ),
                ),
                const SizedBox(width: 10),
                statusContainer(item),
                const SizedBox(width: 10),
                dateContainer(item),
              ],
            ),
            // Row(
            //   children: [
            //     const Text(
            //      "BID",    //item.sUserName ?? "Ali",
            //       style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.bold,
            //         color: Color(0xff651FFF),
            //       ),
            //     ),
            //
            //     const Spacer(),
            //     statusContainer(item),
            //     const SizedBox(width: 10),
            //
            //     dateContainer(item),
            //   ],
            // ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            remarkRow2(item),
            const SizedBox(height: 5),
            remarkRow(item),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),

            //attachmentList(),
            attachmentList(item),
          ],
        ),
      ),
    );
  }
  // status container
  Widget statusContainer(OpportunityData item) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        "Submitted",
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  // data Container
  Widget dateContainer(OpportunityData item) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Important
        children: [
          const Icon(
            Icons.calendar_month,
            size: 18,
            color: Colors.deepPurple,
          ),

          const SizedBox(width: 6),

          Text(
            item.sCreatedAt ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
  // Remark Revew
  Widget remarkRow2(OpportunityData item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Icon(
          Icons.shopping_bag,
          color: Color(0xff651FFF),
          size: 20,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Name/Ref No.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "${item.sUserName}",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  Widget remarkRow(OpportunityData item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Icon(
          Icons.shopping_bag,
          color: Color(0xff651FFF),
          size: 20,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                "Remark",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                "${item.sRemarks}",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  // attach
  Widget attachmentList(OpportunityData item) {

    List<String> docs = [
      item.sUploadDoc1 ?? "",
      item.sUploadDoc2 ?? "",
      item.sUploadDoc3 ?? "",
      item.sUploadDoc4 ?? "",
      item.sUploadDoc5 ?? "",
    ];

    // docs = docs.where(
    //       (e) =>
    //   e.isNotEmpty &&
    //       !e.contains("NoDocUploaded"),
    // ).toList();
    docs = docs.where((e) => e.isNotEmpty).toList();

    print("Docs Count => ${docs.length}");

    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: docs.length,
        itemBuilder: (context, index) {

          // String fileUrl = docs[index];
          //
          // bool isPdf =
          // fileUrl.toLowerCase().contains(".pdf");
          String fileUrl = docs[index];

          bool isPdf =
          fileUrl.toLowerCase().endsWith(".pdf");

          bool isNoDoc =
          fileUrl.contains("NoDocUploaded");

           String fileName = fileUrl.split('/').last;
          //
          // bool isPdf =
          // fileUrl.toLowerCase().contains(".pdf");

          return GestureDetector(
            onTap: (){

              String fileUrl = docs[index];
              bool isPdf =
              fileUrl.toLowerCase().endsWith('.pdf');

              if (isPdf) {

                print("Open PDF => $fileUrl");
                print("--475-pdf  --$fileUrl");

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaySlipPdf(pdfFile: fileUrl)),
                );
                // Open PDF Screen

              } else {
                // print("Open Image => $fileUrl");
                print("--475-image  --$fileUrl");
                openFullScreenDialog(
                    context,
                    fileUrl);

              // Open Image Screen
              }
            },
            child: attachmentCard(
              fileUrl,
              fileName,
              isPdf,
              isNoDoc,
            ),
          );
        },
      ),
    );
  }

  Widget attachmentCard(
      String fileUrl,
      String fileName,
      bool isPdf,
      bool isNoDoc,
      ) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),

      child: isPdf

      /// PDF ICON
          ? const Center(
        child: Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
          size: 40,
        ),
      )

      /// IMAGE
          : ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          fileUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder:
              (context, child, progress) {
            if (progress == null) {
              return child;
            }
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          },
          errorBuilder:
              (context, error, stackTrace) {
            return const Icon(
              Icons.broken_image,
              size: 35,
            );
          },
        ),
      ),
    );
  }

  Widget createNewBidButton({
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: DottedBorder(
        options: const RoundedRectDottedBorderOptions(
          radius: Radius.circular(20),
          color: Color(0xFF8B5CF6),
          strokeWidth: 1.5,
          dashPattern: [8, 4],
        ),
        child: Container(
          width: double.infinity,
          height: 35, // Reduced from 85
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF651FFF),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF651FFF,
                        ).withOpacity(0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              const Text(
                "Create New Bid",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF651FFF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // code
  //  image Camra

  Future pickImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? iUserId = prefs.getString('iUserId');


    // sVisitorImage=null;
    // uplodedImage=null;
    try {
      final pickFileid = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 65,
      );
      if (pickFileid != null) {
        image = File(pickFileid.path);
        // to store in a shared Prefernce
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', image!.path);

        setState(() {});
        print('Image File path Id Proof-------109----->$image');
        // multipartProdecudre();
        print('---Token----682--$sToken');
        print('---iUserId----682--$iUserId');
        print('---image----682--$image');

        uploadImage(sToken!, image!);

        //uploadImage(sToken!,iUserId!,image! as String);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  // uplodeimage
  Future<void> uploadImage(String token, File imageFile) async {

    var baseURL = BaseRepo().baseurl;
    var endPoint = "PostMultipleImage/PostMultipleImage";
    var uplodeImageApi = "$baseURL$endPoint";

    try {

      showLoader();

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          uplodeImageApi,
        ),
      );

      request.headers['token'] = token;

      request.files.add(
        await http.MultipartFile.fromPath(
          'sImagePath',
          imageFile.path,
        ),
      );

      var streamedResponse = await request.send();

      var response = await http.Response.fromStream(streamedResponse);

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {

        Map<String, dynamic> responseData =
        jsonDecode(response.body);

        print("Decoded Response: $responseData");

        if (responseData['Data'] != null &&
            responseData['Data'].isNotEmpty) {

          setState(() {
            uplodedImage2 = responseData['Data'][0]['sImagePath'];
          });
          print("-------748-----$uplodedImage2");
          if(uplodedImage2!=null){
            print("-------748---xx----xx--$uplodedImage");
            // to store a image
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('uplodedImage',uplodedImage2!).toString();
            String? imageUrl = prefs.getString('uplodedImage');

            print("Retrieved Image URL => $imageUrl");

            setState(() {
              uplodedImage2 = imageUrl;
            });

          }else{

          }

          print("Uploaded Image Path:----747--- $uplodedImage");
        }

      } else {
        print("API Error: ${response.reasonPhrase}");
      }

      hideLoader();

    } catch (e) {

      hideLoader();
      print("Error uploading image: $e");

    }
  }


  @override
  Widget build(BuildContext context) {
    print("Opportunity List Length = ${opportunityList.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Sales Tracker"), actions: <Widget>[
        ],),
      drawer: const CustomDrawer(),

      body:SingleChildScrollView(
        child: Column(
            children: <Widget>[
               // this is a banner Section
              Stack(
                children: [
                  Image.asset(
                    "assets/images/banner_dash.png",
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (uplodedImage2 == null ||
                                uplodedImage2!.isEmpty) {
                              pickImage();
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: SizedBox(
                                width: 60,
                                height: 60,
                                child: uplodedImage2 != null &&
                                    uplodedImage2!.isNotEmpty
                                    ? Image.network(
                                  uplodedImage2!,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(
                                      "assets/images/profile.jpg",
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                    : Image.asset(
                                  "assets/images/profile.jpg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                sUserName2 ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                              const SizedBox(height: 4),

                              const Text(
                                "Here's your bidding overview",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // mainCards
              opportunityList.isEmpty ?
              const Text("No Data availabel",style: TextStyle(
                color: Colors.black45,
                fontSize: 18
              ),)
              :
              Column(
               children: <Widget>[
                 ListView.builder(
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: opportunityList.length,
                   itemBuilder: (context, index) {
                     // print("------647-------${opportunityList.length}");
                     OpportunityData item = opportunityList[index];
                     return bidCard(item);
                   },
                 ),
                 SizedBox(height: 5),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                     horizontal: 12,
                     vertical: 8,
                   ),
                   child: createNewBidButton(
                     onTap: () {
                       print("Create New Bid Click");
                       Navigator.pushAndRemoveUntil(
                         context,
                         MaterialPageRoute(
                           builder: (context) => const UpdateServeSalesTracker(),
                         ),
                             (route) => false,
                       );
                     },
                   ),
                 ),
                 SizedBox(height: 10),
               ],
             )
            ]
          ),
      ),
    );
  }
}


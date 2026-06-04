import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart' as fp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/generalFunction.dart';
import '../../../app/loader_helper.dart';
import '../../../app/sakestrackingtypography.dart' hide displayToast;
import '../../../services/baseurl.dart';
import '../../../services/reimbursement.dart';
import '../../loginaftersplace/loginaftersplace.dart';
import '../dashboard/dashboard.dart';

class UpdateServeSalesTracker extends StatefulWidget {
  const UpdateServeSalesTracker({super.key});

  @override
  State<UpdateServeSalesTracker> createState() =>
      _DashBoardSalesTrackerHomeState();
}

class _DashBoardSalesTrackerHomeState extends State<UpdateServeSalesTracker> {
  var _dropDownSector;
  final sectorFocus = GlobalKey();
  var distList, _selectedSectorId;
  GeneralFunction generalFunction = GeneralFunction();
  List<dynamic> whomToMeet = [];
  final TextEditingController dateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();
  File? image, image2, image3, image4,image5;
  File? selectedFile;
  String? selectedFileName;
  bool isPdf = false;
  bool isPdf2 = false;
  bool isPdf3 = false;
  bool isPdf4 = false;
  bool isPdf5 = false;


  String? fileName;
  var msg;
  var result;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var uplodedImage, uplodedImage2, uplodedImage3, uplodedImage4,uplodedImage5;
  void clearAllImages() {
    setState(() {
      image = null;
      image2 = null;
      image3 = null;
      image4 = null;
      image5 = null;
    });
  }
  //

  // DropDownHomeToMeet
  Future<void> pickDocument_1() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      fp.FilePickerResult? result =
      await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
      );

      if (result != null) {
        selectedFile = File(result.files.single.path!);
        fileName = result.files.single.name;

        isPdf = fileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File: $fileName");
        print("Path: ${selectedFile!.path}");

        uploadImage(sToken!, selectedFile!);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
  // pdf set
  Widget buildPreview() {
    if (selectedFile == null) {
      return const Text("");
    }

    if (isPdf) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
              size: 50,
            ),
            Text(fileName ?? ''),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        selectedFile!,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }



  @override
  void initState() {
    //whoomToWidget();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    super.dispose();
  }
  Future pickImage() async {
    image=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');
    try {
      final pickFileid = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        image = File(pickFileid.path);
        setState(() {
          image = File(pickFileid.path);
        });
        //  print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage(sToken!, image!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  Future pickImage2() async {
    // clearAllImages();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');
    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        image2 = File(pickFileid.path);
        setState(() {
          image2 = File(pickFileid.path);
        });
        print('Image File path Id Proof--camra-----195----->$image2');
        // multipartProdecudre();
        print('token----$sToken');
        print('Images----$image2');

        uploadImage2(sToken!, image2!);

      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  Future pickImage3() async {
    image3=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');
    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {
        setState(() {
          image3 = File(pickFileid.path);
        });
        print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage3(sToken!, image3!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  Future pickImage4() async {
    image4=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');
    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {

        setState(() {
          image4 = File(pickFileid.path);
        });
        print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage4(sToken!, image4!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  Future pickImage5() async {
    image5=null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    print('---Token----113--$sToken');
    try {
      final pickFileid = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 65);
      if (pickFileid != null) {

        setState(() {
          image5 = File(pickFileid.path);
        });
        print('Image File path Id Proof-------167----->$image');
        // multipartProdecudre();
        uploadImage5(sToken!, image5!);
      } else {
        print('no image selected');
      }
    } catch (e) {}
  }
  // you shold add 1 more

  // pick image from a Gallery
  Future<void> pickImageGallery() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      final result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        image = File(result.files.single.path!);
        selectedFileName = result.files.single.name;

        isPdf = selectedFileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File Name: $selectedFileName");
        print("Selected File Path: ${image!.path}");
        print("Is PDF: $isPdf");

        uploadImage(sToken!, image!);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  Future<void> pickImageGallery2() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      final result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        image2 = File(result.files.single.path!);
        selectedFileName = result.files.single.name;

        isPdf2 = selectedFileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File Name: $selectedFileName");
        print("Selected File Path: ${image2!.path}");
        print("Is PDF: $isPdf2");

        uploadImage2(sToken!, image2!);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }
  Future<void> pickImageGallery3() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      final result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        image3 = File(result.files.single.path!);
        selectedFileName = result.files.single.name;

        isPdf3 = selectedFileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File Name: $selectedFileName");
        print("Selected File Path: ${image3!.path}");
        print("Is PDF: $isPdf3");

        uploadImage3(sToken!, image3!);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }
  Future<void> pickImageGallery4() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      final result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        image4 = File(result.files.single.path!);
        selectedFileName = result.files.single.name;

        isPdf4 = selectedFileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File Name: $selectedFileName");
        print("Selected File Path: ${image4!.path}");
        print("Is PDF: $isPdf4");

        uploadImage4(sToken!, image4!);
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }
  Future<void> pickImageGallery5() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');

      final result = await fp.FilePicker.platform.pickFiles(
        type: fp.FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        image5 = File(result.files.single.path!);
        selectedFileName = result.files.single.name;

        isPdf5 = selectedFileName!.toLowerCase().endsWith('.pdf');

        setState(() {});

        print("Selected File Name: $selectedFileName");
        print("Selected File Path: ${image5!.path}");
        print("Is PDF: $isPdf5");

        uploadImage5(sToken!, image5!);

      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

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
            uplodedImage = responseData['Data'][0]['sImagePath'];
          });

          print("Uploaded Image Path: $uplodedImage");
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
 Future<void> uploadImage2(String token, File imageFile) async {

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
            uplodedImage2 =
            responseData['Data'][0]['sImagePath'];
          });
          print("Uploaded Image Path: $uplodedImage2");
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
 Future<void> uploadImage3(String token, File imageFile) async {

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
           uplodedImage3 =
           responseData['Data'][0]['sImagePath'];
         });

          print("Uploaded Image Path: $uplodedImage");
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
  Future<void> uploadImage4(String token, File imageFile) async {

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
           uplodedImage4 =
           responseData['Data'][0]['sImagePath'];
         });
         print("Uploaded Image Path: $uplodedImage4");
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
  Future<void> uploadImage5(String token, File imageFile) async {

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
            uplodedImage5 = responseData['Data'][0]['sImagePath'];
          });

          print("Uploaded Image Path: $uplodedImage5");
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
  // clearAllData
  void clearFormData() {
    _expenseController.clear();

    image = null;
    image2 = null;
    image3 = null;
    image4 = null;
    image5 = null;

    uplodedImage = null;
    uplodedImage2 = null;
    uplodedImage3 = null;
    uplodedImage4 = null;
    uplodedImage5 = null;

    selectedFile = null;
    selectedFileName = null;
    fileName = null;

    isPdf = false;
    isPdf2 = false;
    isPdf3 = false;
    isPdf4 = false;
    isPdf5 = false;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            // TOP IMAGE
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset('assets/images/bg_banner.png', fit: BoxFit.cover),
             // child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
            ),
            SafeArea(
              child: Column(
                children: [
                  // HEADER (FIXED)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                           // Navigator.pop(context);

                             Navigator.push(
                               context,
                               MaterialPageRoute(
                                 builder: (context) => const DashBoardSalesTrackerHome(),
                               ),
                             );
                           //  Navigator.push(
                           //    context,
                           //    MaterialPageRoute(
                           //      builder: (context) => const Loginaftersplace(),
                           //    ),
                           //  );

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
                            'Opportunity',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SCROLLABLE AREA
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Push form below image
                            const SizedBox(height: 120),

                            // FORM CARD
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    // Continue remaining widgets...
                                    Container(
                                      height: 50,
                                      color: Colors.white,
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.ac_unit,
                                            size: 20,
                                            color: Color(0xFF6503AB),
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'Supporting Documents',
                                                style: TextStyle(
                                                  color: Color(0xFF6503AB),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              Text(
                                                'Upload up to 5 supporting documents',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "Supported Documents - 1",
                                      style: TextStyle(
                                        // color: Color(0xFF6503AB),
                                        color: Color(0xFF6503AB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    uploadDocumentCard(
                                      onCameraTap: () {
                                        print("Open Camera");
                                        pickImage();

                                      },
                                      onGalleryTap: () {
                                        print("Open Gallery");

                                        //pickDocument_1();
                                        pickImageGallery();
                                      },
                                    ),

                                    // here to apply a conditon if a image is not null then set a images as a file
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        image != null
                                            ? Stack(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {},
                                              child: Container(
                                                height: 100,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: isPdf
                                                    ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                    Text(
                                                      fileName ?? "PDF",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image!,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image = null;
                                                    fileName = null;
                                                    isPdf = false;
                                                    uplodedImage = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),
                                                                     buildPreview(),
                                  //  SizedBox(height: 5),
                                    const Text(
                                      "Supported Documents - 2",
                                      style: TextStyle(
                                        // color: Color(0xFF6503AB),
                                        color: Color(0xFF6503AB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    uploadDocumentCard(
                                      onCameraTap: () {
                                        print("Open Camera");
                                        pickImage2();
                                      },
                                      onGalleryTap: () {
                                        print("Open Gallery");
                                        pickImageGallery2();
                                      },
                                    ),
                                   // SizedBox(height: 5),
                                    //  set a images
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        image2 != null
                                            ? Stack(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {},
                                              child: Container(
                                                height: 100,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: isPdf2
                                                    ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                    Text(
                                                      fileName ?? "PDF",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image2!,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image2 = null;
                                                    fileName = null;
                                                    isPdf2 = false;
                                                    uplodedImage2 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      "Supported Documents - 3",
                                      style: TextStyle(
                                        // color: Color(0xFF6503AB),
                                        color: Color(0xFF6503AB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    uploadDocumentCard(
                                      onCameraTap: () {
                                        print("Open Camera");
                                        pickImage3();
                                      },
                                      onGalleryTap: () {
                                        print("Open Gallery");
                                        pickImageGallery3();
                                      },
                                    ),
                                    // set a document 3
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        image3 != null
                                            ? Stack(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {},
                                              child: Container(
                                                height: 100,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: isPdf3
                                                    ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                    Text(
                                                      fileName ?? "PDF",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image3!,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image3 = null;
                                                    fileName = null;
                                                    isPdf3 = false;
                                                    uplodedImage3 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    const Text(
                                      "Supported Documents - 4",
                                      style: TextStyle(
                                        // color: Color(0xFF6503AB),
                                        color: Color(0xFF6503AB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    uploadDocumentCard(
                                      onCameraTap: () {
                                        print("Open Camera");
                                        pickImage4();
                                      },
                                      onGalleryTap: () {
                                        print("Open Gallery");
                                        pickImageGallery4();
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    // set a image 4
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        image4 != null
                                            ? Stack(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {},
                                              child: Container(
                                                height: 100,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: isPdf4
                                                    ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                    Text(
                                                      fileName ?? "PDF",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image4!,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image4 = null;
                                                    fileName = null;
                                                    isPdf4 = false;
                                                    uplodedImage4 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    const Text(
                                      "Supported Documents - 5",
                                      style: TextStyle(
                                        // color: Color(0xFF6503AB),
                                        color: Color(0xFF6503AB),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    uploadDocumentCard(
                                      onCameraTap: () {
                                        print("Open Camera");
                                        pickImage5();
                                      },
                                      onGalleryTap: () {
                                        print("Open Gallery");
                                        pickImageGallery5();
                                      },
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        image5 != null
                                            ? Stack(
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.translucent,
                                              onTap: () {},
                                              child: Container(
                                                height: 100,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: isPdf5
                                                    ? Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(
                                                      Icons.picture_as_pdf,
                                                      color: Colors.red,
                                                      size: 50,
                                                    ),
                                                    Text(
                                                      fileName ?? "PDF",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                )
                                                    : ClipRRect(
                                                  borderRadius: BorderRadius.circular(8),
                                                  child: Image.file(
                                                    image5!,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              top: -5,
                                              right: -5,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    image5 = null;
                                                    fileName = null;
                                                    isPdf5 = false;
                                                    uplodedImage5 = null;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 24,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                            : const SizedBox(),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          child: TextFormField(
                                            controller: _expenseController,
                                            maxLines: null,
                                            expands: true,
                                            maxLength: 500,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                            decoration: InputDecoration(
                                              hintText: "Enter Remarks",
                                              contentPadding: const EdgeInsets.only(
                                                left: 12,
                                                right: 12,
                                                top: 12,
                                                bottom: 12,
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              counterText: "",
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(
                                                  12,
                                                ),
                                              ),
                                            ),
                                            onChanged: (_) {
                                              setState(() {});
                                            },
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 4,
                                            right: 8,
                                          ),
                                          child: Text(
                                            "${_expenseController.text.length}/500",
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    commonGradientButton(
                                      label: "Submit",

                                      onPressed: () async {
                                        String expense = _expenseController.text.trim();

                                        print("----uplodedImage----$uplodedImage");
                                        print("----uplodedImage2----$uplodedImage2");
                                        print("----uplodedImage3----$uplodedImage3");
                                        print("----uplodedImage4----$uplodedImage4");
                                        print("----uplodedImage5----$uplodedImage5");
                                        print("-----1126---$expense");


                                        if (uplodedImage == null ) {
                                          displayToast("Please upload document");
                                          return;
                                        }
                                        if (expense.isEmpty) {
                                          displayToast("Please Enter Remarks");
                                          return;
                                        }

                                        if (!_formKey.currentState!.validate()) {
                                          return;
                                        }

                                        try {
                                          SharedPreferences prefs = await SharedPreferences.getInstance();

                                          String? iUserId = prefs.getString('iUserId');

                                          print('----iUserId----$iUserId');
                                          print("-----call api----");

                                          var hrmsPopWarning =
                                          await HrmsPostReimbursementRepo().hrmsPostReimbursement(
                                            context,
                                            uplodedImage,
                                            uplodedImage2,
                                            uplodedImage3,
                                            uplodedImage4,
                                            uplodedImage5,
                                            expense,
                                          );

                                          print('--------Response----$hrmsPopWarning');

                                          String result = "${hrmsPopWarning['Result']}";
                                           msg = "${hrmsPopWarning['Msg']}";


                                          // clear textfield
                                          // _expenseController.clear();
                                          // image=null;
                                          // image2=null;
                                          // image3=null;
                                          // image4=null;
                                          // image5=null;
                                          // uplodedImage=null;
                                          // uplodedImage2=null;
                                          // uplodedImage3=null;
                                          // uplodedImage4=null;
                                          // uplodedImage5=null;
                                          // selectedFile = null;
                                          // selectedFileName = null;
                                          // fileName = null;
                                          //
                                          // isPdf = false;
                                          // isPdf2 = false;
                                          // isPdf3 = false;
                                          // isPdf4 = false;
                                          // isPdf5 = false;
                                          // setState(() {
                                          //
                                          // });

                                          if (result == "1") {
                                            displayToast2(msg);
                                            clearFormData();
                                          }else{
                                            displayToast2(msg);
                                          }
                                        } catch (e) {
                                          print("Error: $e");
                                          displayToast(msg);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
      ),
    );
  }
  void displayToast2(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

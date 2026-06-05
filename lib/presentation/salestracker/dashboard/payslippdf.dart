import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart' as Fluttertoast;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../app/generalFunction.dart';


class PaySlipPdf extends StatefulWidget {

  var pdfFile;

  PaySlipPdf({super.key, this.pdfFile});

  @override
  State<PaySlipPdf> createState() => _PolicydocScreenState();
}

class _PolicydocScreenState extends State<PaySlipPdf> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late GeneralFunction generalFunction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if (state == AppLifecycleState.paused) {
      FocusScope.of(context).unfocus();  // Unfocus when app is paused
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar
      // appBar: AppBar(
      //   // statusBarColore
      //   systemOverlayStyle: const SystemUiOverlayStyle(
      //     // Status bar color  // 2a697b
      //     statusBarColor: Color(0xFF2a697b),
      //     // Status bar brightness (optional)
      //     statusBarIconBrightness: Brightness.dark,
      //     // For Android (dark icons)
      //     statusBarBrightness: Brightness.light, // For iOS (dark icons)
      //   ),
      //   // backgroundColor: Colors.blu
      //   backgroundColor: Color(0xFF0098a6),
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //       // Navigator.push(
      //       //   context,
      //       //   MaterialPageRoute(builder: (context) => const PaySlip()),
      //       // );
      //     },
      //     child: const Padding(
      //       padding: EdgeInsets.only(left: 5.0),
      //       child: Icon(
      //         Icons.arrow_back_ios,
      //         size: 24,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      //   title: const Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 16.0),
      //     child: Text(
      //       'Pay Slip',
      //       style: TextStyle(
      //         color: Colors.white,
      //         fontSize: 18,
      //         fontWeight: FontWeight.normal,
      //         fontFamily: 'Montserrat',
      //       ),
      //       textAlign: TextAlign.center,
      //     ),
      //   ),
      //   // Removes shadow under the AppBar
      //   actions: [
      //     IconButton(
      //       icon: const Icon(
      //         Icons.download, // Use any download icon
      //         color: Colors.white,
      //       ),
      //       onPressed: () {
      //         downloadPDF();
      //         // downlodeFile();
      //         // Action to download PDF
      //         // downloadPDF();
      //       },
      //     ),
      //   ],
      //
      // ),
      body: Stack(
        children: [
          /// HEADER IMAGE
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg_banner.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                /// TOP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(21),
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      const Text(
                        'PDF Viewer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                /// SPACE TO KEEP HEADER HEIGHT 250
                const SizedBox(height: 160),

                /// PDF SECTION
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                      child: SfPdfViewer.network(
                        widget.pdfFile,
                        key: _pdfViewerKey,
                        enableDoubleTapZooming: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Stack(
      //   children: [
      //     // TOP IMAGEin
      //     Container(
      //       height: 250,
      //       width: MediaQuery.of(context).size.width,
      //       decoration: const BoxDecoration(
      //         image: DecorationImage(
      //           image: AssetImage('assets/images/bg_banner.png'),
      //           fit: BoxFit.cover,
      //           alignment: Alignment.center,
      //         ),
      //       ),
      //     ),
      //
      //     SafeArea(
      //         child: Column(
      //           children: [
      //             Padding(
      //               padding: const EdgeInsets.all(16),
      //               child: Row(
      //                 children: [
      //                   GestureDetector(
      //                     onTap: () {
      //                       // Navigator.pop(context);
      //
      //                       // Navigator.push(
      //                       //   context,
      //                       //   MaterialPageRoute(
      //                       //     builder: (context) => const DashBoardSalesTrackerHome(),
      //                       //   ),
      //                       // );
      //                     },
      //                     child: Container(
      //                       height: 42,
      //                       width: 42,
      //                       decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(21),
      //                       ),
      //                       child: const Icon(Icons.arrow_back_ios_new, size: 18),
      //                     ),
      //                   ),
      //
      //                   const SizedBox(width: 16),
      //
      //                   const Expanded(
      //                     child: Text(
      //                       'Pdf',
      //                       style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 18,
      //                         fontWeight: FontWeight.w700,
      //                       ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             SizedBox(height: 5),
      //             // to open pdf
      //             Expanded(
      //               child: Container(
      //                 child: SfPdfViewer.network(
      //                     '${widget.pdfFile}',
      //                     key: _pdfViewerKey,
      //                     enableDoubleTapZooming: true,
      //                   ),
      //               ),
      //             ),
      //             SizedBox(height: 5),
      //
      //           ],
      //         ))
      //   ],
      // ),

      // body: SfPdfViewer.network(
      //   '${widget.pdfFile}',
      //   key: _pdfViewerKey,
      //   enableDoubleTapZooming: true,
      // ),
    );
  }


  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     // appBar
  //     appBar: AppBar(
  //       // statusBarColore
  //       systemOverlayStyle: const SystemUiOverlayStyle(
  //         // Status bar color  // 2a697b
  //         statusBarColor: Color(0xFF2a697b),
  //         // Status bar brightness (optional)
  //         statusBarIconBrightness: Brightness.dark,
  //         // For Android (dark icons)
  //         statusBarBrightness: Brightness.light, // For iOS (dark icons)
  //       ),
  //       // backgroundColor: Colors.blu
  //       backgroundColor: Color(0xFF0098a6),
  //       leading: InkWell(
  //         onTap: () {
  //            Navigator.pop(context);
  //           // Navigator.push(
  //           //   context,
  //           //   MaterialPageRoute(builder: (context) => const PaySlip()),
  //           // );
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.only(left: 5.0),
  //           child: Icon(
  //             Icons.arrow_back_ios,
  //             size: 24,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //       title: const Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 16.0),
  //         child: Text(
  //           'Pay Slip',
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 18,
  //             fontWeight: FontWeight.normal,
  //             fontFamily: 'Montserrat',
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       // Removes shadow under the AppBar
  //       actions: [
  //         IconButton(
  //           icon: const Icon(
  //             Icons.download, // Use any download icon
  //             color: Colors.white,
  //           ),
  //           onPressed: () {
  //             downloadPDF();
  //            // downlodeFile();
  //             // Action to download PDF
  //            // downloadPDF();
  //           },
  //         ),
  //       ],
  //
  //     ),
  //
  //     body: SfPdfViewer.network(
  //       '${widget.pdfFile}',
  //       key: _pdfViewerKey,
  //       enableDoubleTapZooming: true,
  //     ),
  //   );
  // }




  // pdf downllode file  code
  Future<void> downloadPDF() async {
    const pdfUrl = 'http://49.50.76.136/HRMS/Policies/04132024041329.pdf';
    final fileName = pdfUrl.split('/').last;

    // Check and request permission for storage (Android only)
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        print("Permission Denied!");
        return;
      }
    }

    // Get the Downloads directory
    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else if (Platform.isIOS) {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    if (downloadsDirectory != null) {
      final savePath = '${downloadsDirectory.path}/$fileName';
      try {
        Dio dio = Dio();

        await dio.download(
          pdfUrl,
          savePath,
          onReceiveProgress: (received, total) {
            if (total != -1) {
              // Calculate download progress percentage
              double progress = received / total;
              // Show progress bar in console
              showProgressBar(progress);
            }
          },
        );
        displayToast(savePath);

        print('\nFile downloaded to: $savePath');
      } catch (e) {
        displayToast('Error downloding file : $e');
        print('Error downloading file: $e');
      }
    }
  }

  // downlode file
  void downlodeFile() async{
    var dio = Dio();
    Directory directory = await getApplicationDocumentsDirectory();
    var response = await dio.download("http://49.50.76.136/HRMS/Policies/04132024041329.pdf",
        '${directory.path}/file.pdf');
    print(response.statusCode);
    print(response);
    print('xxxxxxxxxxxxxx......');
  }
  // toast
  void displayToast(String msg) {
    Fluttertoast.showToast(
      msg,
      duration: Duration(seconds: 1),
      position: Fluttertoast.ToastPosition.center,
      backgroundColor: Colors.black45,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    );
  }
  // show prograssbar logic
  void showProgressBar(double progress) {
    int progressBarLength = 50; // Total length of progress bar
    int filledLength = (progressBarLength * progress).round(); // Filled length based on progress
    String bar = '=' * filledLength + '-' * (progressBarLength - filledLength); // Bar construction

    stdout.write('\r[$bar] ${(progress * 100).toStringAsFixed(0)}%');
  }
}


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/generalFunction.dart';
import '../../../app/sakestrackingtypography.dart';
import '../../../services/BindWhomToMeetVisitor.dart';
import '../../loginaftersplace/loginaftersplace.dart';
import '../../resources/app_text_style.dart';

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
  var _dropDownWhomToValue;
  var _selectedWhomToMeetValue;
  final TextEditingController dateController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _expenseController = TextEditingController();

  whoomToWidget() async {
    whomToMeet = await BindWhomToMeetVisitorRepo().getbindWhomToMeetVisitor();
    print("$whomToMeet");
    setState(() {});
  }

  //

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      dateController.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }

  // DropDownHomeToMeet
  Widget _WhomToMeet() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),

      child: InkWell(
        borderRadius: BorderRadius.circular(10),

        onTap: () {
          FocusScope.of(context).unfocus();

          showDialog(
            context: context,

            builder: (context) {
              return Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Container(
                  width: 400,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 18,
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      /// TITLE
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Whom To Meet",

                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// DIVIDER
                      const Divider(height: 1, thickness: 1),

                      /// LIST
                      SizedBox(
                        height: 300,

                        child: ListView.separated(
                          padding: EdgeInsets.zero,

                          itemCount: whomToMeet.length,

                          separatorBuilder: (context, index) {
                            return const Divider(height: 1, thickness: 0.8);
                          },

                          itemBuilder: (context, index) {
                            final item = whomToMeet[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  _dropDownWhomToValue = item['sUserName'];

                                  _selectedWhomToMeetValue = item['iUserId'];
                                });

                                print(
                                  "----whom To meet --149--xx-->>>..xxx.---$_selectedWhomToMeetValue",
                                );

                                Navigator.pop(context);
                              },

                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),

                                child: Text(
                                  item['sUserName'].toString(),

                                  overflow: TextOverflow.ellipsis,

                                  style: AppTextStyle
                                      .font14OpenSansRegularBlack45TextStyle,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },

        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 42,

          padding: const EdgeInsets.symmetric(horizontal: 10),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Expanded(
                child: Text(
                  _dropDownWhomToValue ?? "Whom To Meet",

                  overflow: TextOverflow.ellipsis,

                  style: AppTextStyle.font14OpenSansRegularBlack45TextStyle,
                ),
              ),

              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    whoomToWidget();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // TOP IMAGE
          Container(
            height: 200,
            width: double.infinity,
            child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),

            // child: Image.asset(
            //   'assets/images/updateseverbg.png',
            //   fit: BoxFit.cover,
            // ),
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
                              builder: (context) => const Loginaftersplace(),
                            ),
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
                          'Add Reimbursement',
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
                                SizedBox(height: 5),
                                uploadDocumentCard(
                                  onCameraTap: () {
                                    print("Open Camera");
                                  },
                                  onGalleryTap: () {
                                    print("Open Gallery");
                                  },
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "Supported Documents - 2",
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
                                  },
                                  onGalleryTap: () {
                                    print("Open Gallery");
                                  },
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "Supported Documents - 3",
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
                                  },
                                  onGalleryTap: () {
                                    print("Open Gallery");
                                  },
                                ),
                                SizedBox(height: 5),
                                const Text(
                                  "Supported Documents - 4",
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
                                  },
                                  onGalleryTap: () {
                                    print("Open Gallery");
                                  },
                                ),
                                SizedBox(height: 5),
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
                                  },
                                  onGalleryTap: () {
                                    print("Open Gallery");
                                  },
                                ),
                                SizedBox(height: 5),
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
                                          hintText: "Enter Expense Details",
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
                                  label: "Submit Reimbursement",
                                  onPressed: () {
                                    print("Submit Reimbursement");
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
              ],
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   body: Stack(
    //         children: [
    //           Positioned.fill(
    //             child: Image.asset(
    //               'assets/images/updateseverbg.png',
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           // Content Above Image
    //           SafeArea(
    //             child:Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Column(
    //                   //crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // header part
    //                     Row(
    //                         children: [
    //                           GestureDetector(
    //                             //onTap: () => Navigator.pop(context),
    //                             onTap: (){
    //                               //print('-------45-----');
    //                               Navigator.push(
    //                                 context,
    //                                 MaterialPageRoute(
    //                                   builder: (context) => const LoginPageAfterSplace(),
    //                                 ),
    //                               );
    //                             },
    //                             child:Container(
    //                               height: 42,
    //                               width: 42,
    //                               decoration: BoxDecoration(
    //                                 color: Colors.white,
    //                                 borderRadius: BorderRadius.circular(21),
    //                               ),
    //                               child: const Center(
    //                                 child: Icon(
    //                                   Icons.arrow_back_ios_new,
    //                                   size: 18,
    //                                   color: Colors.black87,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //
    //                           const SizedBox(width: 16),
    //                           const Expanded(
    //                             child: Text(
    //                               'Add Reimbursement',
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 18,
    //                                 fontWeight: FontWeight.w700,
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //
    //
    //                     // Scrollable Part
    //                     Expanded(
    //                       child: SingleChildScrollView(
    //                         child: Column(
    //                           children: [
    //                             //const SizedBox(height: 180),
    //                             Container(
    //                               width: double.infinity,
    //                               child: Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Column(
    //                                   // widget
    //                                   children: [
    //                                     // Supporting Documents
    //                                     SizedBox(height: 200),
    //                                     Container(
    //                                       height: 50,
    //                                       color: Colors.white,
    //                                       child: const Row(
    //                                         mainAxisAlignment: MainAxisAlignment.start,
    //                                         children: <Widget>[
    //                                           Icon(Icons.ac_unit,size: 20,
    //                                               color: Color(0xFF6503AB)),
    //                                           SizedBox(width: 20),
    //                                           Column(
    //                                             mainAxisAlignment: MainAxisAlignment.start,
    //                                             crossAxisAlignment: CrossAxisAlignment.start,
    //                                             children: <Widget>[
    //                                               Text(
    //                                                 'Supporting Documents',
    //                                                 style: TextStyle(
    //                                                   color: Color(0xFF6503AB),
    //                                                   fontSize: 14,
    //                                                   fontWeight: FontWeight.w400,
    //                                                 ),
    //                                               ),
    //                                               Text(
    //                                                 'Upload up to 5 supporting documents',
    //                                                 style: TextStyle(
    //                                                   color: Colors.grey,
    //                                                   fontSize: 12,
    //                                                   fontWeight: FontWeight.w400,
    //                                                 ),
    //                                               ),
    //                                             ],
    //                                           ),
    //
    //                                         ],
    //                                       ),
    //                                     ),
    //                                     const Text(
    //                                       "Supported Documents - 1",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Color(0xFF6503AB),
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     uploadDocumentCard(
    //                                       onCameraTap: () {
    //                                         print("Open Camera");
    //                                       },
    //                                       onGalleryTap: () {
    //                                         print("Open Gallery");
    //                                       },
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     const Text(
    //                                       "Supported Documents - 2",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Color(0xFF6503AB),
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     uploadDocumentCard(
    //                                       onCameraTap: () {
    //                                         print("Open Camera");
    //                                       },
    //                                       onGalleryTap: () {
    //                                         print("Open Gallery");
    //                                       },
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     const Text(
    //                                       "Supported Documents - 3",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Color(0xFF6503AB),
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     uploadDocumentCard(
    //                                       onCameraTap: () {
    //                                         print("Open Camera");
    //                                       },
    //                                       onGalleryTap: () {
    //                                         print("Open Gallery");
    //                                       },
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     const Text(
    //                                       "Supported Documents - 4",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Color(0xFF6503AB),
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     uploadDocumentCard(
    //                                       onCameraTap: () {
    //                                         print("Open Camera");
    //                                       },
    //                                       onGalleryTap: () {
    //                                         print("Open Gallery");
    //                                       },
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     const Text(
    //                                       "Supported Documents - 5",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Color(0xFF6503AB),
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     uploadDocumentCard(
    //                                       onCameraTap: () {
    //                                         print("Open Camera");
    //                                       },
    //                                       onGalleryTap: () {
    //                                         print("Open Gallery");
    //                                       },
    //                                     ),
    //
    //
    //                                     const Text(
    //                                       "Expense Details",
    //                                       style: TextStyle(
    //                                         // color: Color(0xFF6503AB),
    //                                         color: Colors.black,
    //                                         fontSize: 14,
    //                                         fontWeight: FontWeight.w400,
    //                                       ),
    //                                     ),
    //                                     SizedBox(height: 5),
    //                                     Column(
    //                                       crossAxisAlignment: CrossAxisAlignment.end,
    //                                       children: [
    //                                         SizedBox(
    //                                           height: 120,
    //                                           child: TextFormField(
    //                                             controller: _expenseController,
    //                                             maxLines: null,
    //                                             expands: true,
    //                                             maxLength: 500,
    //                                             textAlignVertical: TextAlignVertical.top,
    //                                             decoration: InputDecoration(
    //                                               hintText: "Enter Expense Details",
    //                                               contentPadding: const EdgeInsets.only(
    //                                                 left: 12,
    //                                                 right: 12,
    //                                                 top: 12,
    //                                                 bottom: 12,
    //                                               ),
    //                                               filled: true,
    //                                               fillColor: Colors.white,
    //                                               counterText: "",
    //                                               border: OutlineInputBorder(
    //                                                 borderRadius: BorderRadius.circular(12),
    //                                               ),
    //                                             ),
    //                                             onChanged: (_) {
    //                                               setState(() {});
    //                                             },
    //                                           ),
    //                                         ),
    //
    //                                         Padding(
    //                                           padding: const EdgeInsets.only(
    //                                             top: 4,
    //                                             right: 8,
    //                                           ),
    //                                           child: Text(
    //                                             "${_expenseController.text.length}/500",
    //                                             style: const TextStyle(
    //                                               color: Colors.grey,
    //                                               fontSize: 12,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     SizedBox(height: 10),
    //                                     commonGradientButton(
    //                                         label: "Submit Reimbursement",
    //                                         onPressed: (){
    //                                           print("Submit Reimbursement");
    //                                         }
    //                                     ),
    //                                   ],
    //                                 ),
    //                               ),
    //                             )
    //
    //                           ],
    //                         ),
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //             ),
    //             ),
    //         ],
    //
    //     )
    // );
  }
}

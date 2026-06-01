import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../app/generalFunction.dart';
import '../../../services/BindWhomToMeetVisitor.dart';
import '../../resources/app_text_style.dart';


class UpdateServeSalesTracker extends StatefulWidget {
  const UpdateServeSalesTracker({super.key});

  @override
  State<UpdateServeSalesTracker> createState() => _DashBoardSalesTrackerHomeState();
}


class _DashBoardSalesTrackerHomeState extends State<UpdateServeSalesTracker> {
  var _dropDownSector;
  final sectorFocus = GlobalKey();
  var distList,_selectedSectorId;
  GeneralFunction generalFunction = GeneralFunction();
  List<dynamic> whomToMeet = [];
  var _dropDownWhomToValue;
  var _selectedWhomToMeetValue;

  whoomToWidget() async {
    whomToMeet = await BindWhomToMeetVisitorRepo().getbindWhomToMeetVisitor();
    print("$whomToMeet");
    setState(() {});
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
                      const Text(
                        "Whom To Meet",

                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// DIVIDER
                      const Divider(
                        height: 1,
                        thickness: 1,
                      ),

                      /// LIST
                      SizedBox(
                        height: 300,

                        child: ListView.separated(
                          padding: EdgeInsets.zero,

                          itemCount: whomToMeet.length,

                          separatorBuilder: (context, index) {

                            return const Divider(
                              height: 1,
                              thickness: 0.8,
                            );
                          },

                          itemBuilder: (context, index) {

                            final item = whomToMeet[index];

                            return InkWell(

                              onTap: () {

                                setState(() {

                                  _dropDownWhomToValue =
                                  item['sUserName'];

                                  _selectedWhomToMeetValue =
                                  item['iUserId'];
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

                                  style:
                                  AppTextStyle
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

                  style:
                  AppTextStyle
                      .font14OpenSansRegularBlack45TextStyle,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/updateseverbg.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Content Above Image
              SafeArea(
                child:Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            children: [
                              GestureDetector(
                                //onTap: () => Navigator.pop(context),
                                onTap: (){
                                  print('-------45-----');
                                },
                                child:Container(
                                  height: 42,
                                  width: 42,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(21),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      size: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 16),

                              const Expanded(
                                child: Text(
                                  'Add Reimbursement',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        // Add more widgets here--
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 40),
                            Text('Submit Your expenses',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                            ),),
                            Text('and get reimbursed',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                            ),),
                            Text('easily',style: TextStyle(
                                color: Colors.black,
                                fontSize: 14
                            ),),

                          ],
                        ),
                        SizedBox(height: 100),
                        Container(
                          height: 50,
                          color: Colors.white,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Icon(Icons.ac_unit,size: 20,
                                color: Color(0xFF6503AB)),
                              SizedBox(width: 20),
                              Text(
                                'Basic Information',
                                style: TextStyle(
                                  color: Color(0xFF6503AB),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),

                            ],
                          ),
                        ),
                        const Text(
                          'Select Project',
                          style: TextStyle(
                           // color: Color(0xFF6503AB),
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  //color: const Color(0xFF6503AB),
                                  color: Colors.white,
                                  child: Icon(Icons.ac_unit,color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                flex: 8,
                                child: _WhomToMeet(),


                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                ),
                ),
            ],

        )
    );
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Center(
      //       child: Text('Update Serve', style: TextStyle(
      //           color: Colors.black,
      //           fontSize: 20
      //       ),),
      //     )
      //   ],
      // ),


  }
}


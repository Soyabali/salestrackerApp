import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/changePassword/changePassword.dart';
import '../presentation/loginaftersplace/loginaftersplace.dart';
import '../presentation/resources/app_text_style.dart';
import '../presentation/resources/assets_manager.dart';
import '../presentation/resources/values_manager.dart';
import '../presentation/salestracker/dashboard/dashboard.dart';
import '../presentation/salestracker/updateServy/updateservy.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {

  String sUserName = "";
  String sContactNo = "";

  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  Future<void> getLocalData() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    setState(() {
      sUserName =
          prefs.getString('sUserName') ?? "";
      sContactNo =
          prefs.getString('sContactNo') ?? "";
    });

    print("Name -------35--: $sUserName");
    print("Mobile -------36: $sContactNo");
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/bg_banner.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.end,
              children: [

                ClipOval(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      'assets/images/human.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  sUserName,
                  style: AppTextStyle
                      .font16OpenSansRegularBlackTextStyle,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.call,
                      size: 18,
                      color: Color(0xFFC07BDB),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      sContactNo,
                      style: AppTextStyle
                          .font14OpenSansRegularBlack45TextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Rest of your drawer code...
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DashBoardSalesTrackerHome(),
                        ),
                      );

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        // Image.asset('assets/images/home_nw.png',
                        //   width: 25,
                        //   height: 25,
                        //   fit: BoxFit.fill,
                        // ),
                        const Icon(
                          Icons.microwave,
                          size: 25,
                          color: Color(0xFFC07BDB),
                        ),
                        // color: Colors.red),
                        const SizedBox(width: 10),
                        Text('Home',
                            style: AppTextStyle
                                .font16penSansExtraboldBlackTextStyle),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  const Divider(
                    height: 1, // space above & below divider
                    thickness: 1, // actual line thickness
                    color: Colors.grey, // line color
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {

                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => UpdateServeSalesTracker()),
                        );
                      });

                    },

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.data_exploration,
                          size: 25,
                          color: Color(0xFFC07BDB),
                        ),
                        // Image.asset('assets/images/opportunative.png',
                        //   width: 25,
                        //   height: 25,
                        //   fit: BoxFit.fill,
                        // ),
                        // color: Colors.red),
                        const SizedBox(width: 10),
                        Text('Opportunity',
                            style: AppTextStyle
                                .font16penSansExtraboldBlackTextStyle),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  const Divider(
                    height: 1, // space above & below divider
                    thickness: 1, // actual line thickness
                    color: Colors.grey, // line color
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ChangePassword(name: null,)));
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.manage_accounts,
                          size: 25,
                          color: Color(0xFFC07BDB),
                        ),
                        // Image.asset('assets/images/changePassword.png',
                        //   width: 25,
                        //   height: 25,
                        //   fit: BoxFit.fill,
                        // ),
                        // color: Colors.red),
                        const SizedBox(width: 10),
                        Text('Change Password',
                            style: AppTextStyle.font16penSansExtraboldBlackTextStyle),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    height: 1, // space above & below divider
                    thickness: 1, // actual line thickness
                    color: Colors.grey, // line color
                  ),
                  const SizedBox(height: 10),
                  // const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () async {
                      // clear all store SharedPreferenceValue :
                      // _logoutDiuCitizen(context);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear(); // This removes all stored data
                      Future.delayed(Duration.zero, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Loginaftersplace()));
                      });


                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.logout,
                          size: 25,
                          color: Color(0xFFC07BDB),
                        ),
                        // Image.asset(
                        //   'assets/images/logout_new.png',
                        //   width: 25,
                        //   height: 25,
                        //   fit: BoxFit.fill,
                        // ),
                        const SizedBox(width: 10),
                        Text('Logout',
                            style: AppTextStyle.font16penSansExtraboldBlackTextStyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.0,left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('Synergy Telematics Pvt.Ltd.',style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color(0xffF37339),//#F37339
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),),
                    const SizedBox(width: 0),
                    Padding(
                      padding: EdgeInsets.only(right: AppSize.s10),
                      child: Container(
                        margin: EdgeInsets.all(AppSize.s10),
                        child: Image.asset(
                          ImageAssets.favicon,
                          //width: AppSize.s50,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
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
    );
  }
}
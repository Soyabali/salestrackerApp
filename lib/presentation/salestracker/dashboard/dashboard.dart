import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/generalFunction.dart';


class DashBoardSalesTrackerHome extends StatefulWidget {
  const DashBoardSalesTrackerHome({super.key});

  @override
  State<DashBoardSalesTrackerHome> createState() => _DashBoardSalesTrackerHomeState();
}

class _DashBoardSalesTrackerHomeState extends State<DashBoardSalesTrackerHome> {

  GeneralFunction generalFunction = GeneralFunction();
  var sUserName;
  var sContactNo;

  @override
  void initState() {
    // TODO: implement initState
    getLocaData();
    super.initState();
  }
  getLocaData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    sUserName = prefs.getString('sUserName');
    sContactNo = prefs.getString('sContactNo');
    setState(() {

    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Sales Tracker"), actions: <Widget>[
        ],),
      drawer: generalFunction.drawerFunction_2(context,"$sUserName","$sContactNo"),


      body: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Center(
             child: Text('Container', style: TextStyle(
               color: Colors.black,
               fontSize: 20
             ),),
           )
        ],
      ),

    );
  }
}


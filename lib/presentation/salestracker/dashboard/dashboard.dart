import 'package:flutter/material.dart';

import '../../../app/generalFunction.dart';


class DashBoardSalesTrackerHome extends StatefulWidget {
  const DashBoardSalesTrackerHome({super.key});

  @override
  State<DashBoardSalesTrackerHome> createState() => _DashBoardSalesTrackerHomeState();
}

class _DashBoardSalesTrackerHomeState extends State<DashBoardSalesTrackerHome> {

  GeneralFunction generalFunction = GeneralFunction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Sales Tracker"), actions: <Widget>[
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Stack(
        //     clipBehavior: Clip.none,
        //     children: [
        //       IconButton(
        //         icon: const Icon(Icons.notifications,size: 30,color: Colors.red,),
        //         tooltip: 'Setting Icon',
        //         onPressed: () async {
        //           print("-------xxxxxxx-----445------xxxxxxxxx-------$iUserId");
        //           if(iUserId!=null){
        //             // call api
        //             var  checkVisitorDetail = await CheckVisitorDetailsRepo().checkVisitorDetail(context,iUserId);
        //             print("-------checkVisitorDertails------449---$checkVisitorDetail");
        //             result = '${checkVisitorDetail['Result']}';
        //             msg  = '${checkVisitorDetail['Msg']}';
        //             print('-----result----xxxxx----xxxxx--x-$result');
        //             setState(() {
        //             });
        //
        //             if(result=="1"){
        //               // Open a new Widget to show a Detail
        //               // VisitorList
        //               result=null;
        //
        //               Navigator.push(
        //                 context,
        //                 MaterialPageRoute(builder: (context) => VisitorList(payload:"")),
        //               );
        //               // CheckVisitorDetailsRepo().checkVisitorDetail(context,iUserId);
        //             }else{
        //               displayToast(msg);
        //             }
        //           }else{
        //             displayToast("There is not a UserId");
        //           }
        //         },
        //       ),
        //     ],
        //
        //   ),
        // ),
      ],),
      drawer: generalFunction.drawerFunction_2(context,"Soyab","Ali"),


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


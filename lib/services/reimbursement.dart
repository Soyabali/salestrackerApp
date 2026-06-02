import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app/generalFunction.dart';
import '../app/loader_helper.dart';
import 'baseurl.dart';


class HrmsPostReimbursementRepo {
  // this is a loginApi call functin

  GeneralFunction generalFunction = GeneralFunction();
  Future hrmsPostReimbursement(
      BuildContext context, uplodedImage, uplodedImage2, uplodedImage3, uplodedImage4, uplodedImage5, String expense,

      ) async {
    try {
      //uplodedImage2, uplodedImage3, uplodedImage4
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? sToken = prefs.getString('sToken');
      String? iUserId = prefs.getString('iUserId');

      print('----sToken--18---$sToken');
      print('----uplodeimage---$uplodedImage');
      print('----uplodedImage2---$uplodedImage2');
      print('----uplodedImage2---$uplodedImage3');
      print('----uplodedImage2---$uplodedImage4');
      print('----uplodedImage2---$uplodedImage5');
      print('----expense---$expense');

      //
      var baseURL = BaseRepo().baseurl;
      var endPoint = "PostOpportunityReview/PostOpportunityReview";
      var hrmsPostReimbursementApi = "$baseURL$endPoint";
      print('------------17---hrmsPostReimbursementApi---$hrmsPostReimbursementApi');

      showLoader();
      var headers = {'token': '$sToken', 'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('$hrmsPostReimbursementApi'));

      request.body = json.encode({
        "sOpportunityRevId": "",
        "sOpportunityRevName": "",

        "sUploadDoc1":uplodedImage ?? "",
        "sUploadDoc2":uplodedImage2 ?? "",
        "sUploadDoc3":uplodedImage3 ?? "",
        "sUploadDoc4": uplodedImage4 ?? "",
        "sUploadDoc5": uplodedImage5 ?? "",
        "sUploadDoc6":"NA",
        "sRemarks":expense,
        "sCreatedBy":iUserId


        //"sItemArray": consumableList ?? '[{"":""}]',
        //"sItemArray": (consumableList == null || consumableList.isEmpty) ? [] : consumableList,

        // "sItemArray":consumableList ?? "",
        // "sItemArray":'[{"SrNo":"1","sItemName":"Pencil Box","sUoM":"Box","fQty":"4","fAmount":"400"},{"SrNo":"2","sItemName":"Laptop Bag","sUoM":"Bags","fQty":"2","fAmount":"4400"}]',


      });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---login RESPONSE----$map');
      if (response.statusCode == 200) {
        hideLoader();
        print('----------71-----$map');
        return map;
      }
      else if(response.statusCode==401){
        generalFunction.logout(context);
      }
      else {
        print('----------74--hrmsPostReimbursement----$map');
        hideLoader();
        print(response.reasonPhrase);
        return map;
      }
    } catch (e) {
      hideLoader();
      debugPrint("exception: $e");
      throw e;
    }
  }
}
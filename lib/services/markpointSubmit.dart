import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app/generalFunction.dart';
import '../app/loader_helper.dart';
import 'baseurl.dart';

class OnlineComplaintFormRepo {
  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future onlineComplaintFormApi(
      BuildContext context,
      String random20digitNumber,
      selectedSubCategoryId,
      selectedWardId,
      String address,
      String landmark,
      String mentionYourConcerns,
      uplodedImage,
      String? sContactNo,
      double? lat,
      double? long,
      ) async {
    // sharedP
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('sToken');

    try {
      print('----iCompCode---$random20digitNumber');
      print('----iSubCategoryCode---$selectedSubCategoryId');
      print('----sWardCode---$selectedWardId');
      print('----sAddress---$address');
      print('----sLandmark---$landmark');
      print('----sComplaintDetails---$mentionYourConcerns');
      print('----sComplaintPhoto---$uplodedImage');
      print('----sPostedBy---$sContactNo');
      print('----fLatitude---$lat');
      print('----fLongitude---$long');

      var baseURL = BaseRepo().baseurl;

      /// TODO CHANGE HERE
      var endPoint = "CitizenPostComplaint/CitizenPostComplaint";
      var markPointSubmitApi = "$baseURL$endPoint";
      print('------------39---markPointSubmitApi---$markPointSubmitApi');

       String jsonResponse =
          '{"sArray":[{"iCompCode":"$random20digitNumber","iSubCategoryCode":$selectedSubCategoryId,"sWardCode":$selectedWardId,"sAddress":"$address","sLandmark":"$landmark","sComplaintDetails":"$mentionYourConcerns","sComplaintPhoto":"$uplodedImage","sPostedBy":"$sContactNo","fLatitude":"$lat","fLongitude":"$long"}]}';
      //------------

      // Parse the JSON response
      Map<String, dynamic> parsedResponse = jsonDecode(jsonResponse);

// Get the array value
      List<dynamic> sArray = parsedResponse['sArray'];

// Convert the array to a string representation
      String sArrayAsString = jsonEncode(sArray);

// Update the response object with the string representation of the array
      parsedResponse['sArray'] = sArrayAsString;

// Convert the updated response object back to JSON string
      String updatedJsonResponse = jsonEncode(parsedResponse);

// Print the updated JSON response (optional)
      print(updatedJsonResponse);
      print('---70-----$updatedJsonResponse');

//Your API call
      var headers = {'token': '$token', 'Content-Type': 'application/json'};

      var request = http.Request(
          'POST',
          Uri.parse(
              'http://115.244.7.153/diucitizenapi/api/CitizenPostComplaint/CitizenPostComplaint'));
      request.body =
          updatedJsonResponse; // Assign the JSON string to the request body
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('-------89--$map');
      print('---90---${response.statusCode}');
      // var response;
      // var map;
      //print('----------20---LOGINaPI RESPONSE----$map');
      if (response.statusCode == 200) {
        print('------92----xxxxxxxxxxxxxxx----');
        hideLoader();
        print('----------96-----$map');
        return map;
      } else if(response.statusCode==401)
      {
        generalFunction.logout(context);
      }else{
        print('----------99----$map');
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

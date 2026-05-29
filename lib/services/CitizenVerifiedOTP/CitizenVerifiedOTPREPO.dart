import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/generalFunction.dart';
import '../../app/loader_helper.dart';
import '../baseurl.dart';


class CitizenVerifiedOtpRepo {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future citizenVerifyOtp(BuildContext context, String otp, phoneNumber) async {
    // sharedPreference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    String? mobileNo = prefs.getString('mobileNo');
    //String? mobileNo = prefs.getString('mobileNo');


    try {
      print('----otp-----17--$otp');
      print('----mobileNo------18-$mobileNo');
      print('----sToken------18-$sToken');
      print('----phoneNumber------18-$phoneNumber');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "CitizenVerifiedOTP/CitizenVerifiedOTP";
      var registrationApi = "$baseURL$endPoint";
      print('------------17---registrationApi---$registrationApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      // var headers = {
      //   'token': '$sToken',
      //   'Content-Type': 'application/json'
      // };

      var request = http.Request('POST', Uri.parse('$registrationApi'));
      request.body = json.encode(
          {
            "sContactNo": phoneNumber,
            "sOtp": otp,
          });
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      var map;
      var data = await response.stream.bytesToString();
      map = json.decode(data);
      print('----------20---LOGINaPI RESPONSE----$map');

      if (response.statusCode == 200) {
        // create an instance of auth class
        print('----44-${response.statusCode}');
        hideLoader();
        print('----------22-----$map');
        return map;
      } else {
        print('----------29---LOGINaPI RESPONSE----$map');
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

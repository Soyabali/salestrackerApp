import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app/generalFunction.dart';
import '../app/loader_helper.dart';
import 'baseurl.dart';


class RegistrationRepo {

  // this is a loginApi call functin
  GeneralFunction generalFunction = GeneralFunction();

  Future authenticate(BuildContext context, String phone, String name) async {

    try {
      print('----phone-----17--$phone');
      print('----password------18-$name');

      var baseURL = BaseRepo().baseurl;
      var endPoint = "CitizenRegistration/CitizenRegistration";
      var registrationApi = "$baseURL$endPoint";
      print('------------17---registrationApi---$registrationApi');

      showLoader();
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request(
          'POST',
          Uri.parse('$registrationApi'));
      request.body = json.encode({"sContactNo": phone, "sCitizenName": name});
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

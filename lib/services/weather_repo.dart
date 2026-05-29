
import 'package:flutter/cupertino.dart';
import '../app/generalFunction.dart';
import '../app/loader_helper.dart';
import 'baseurl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRepo {
  GeneralFunction generalFunction = GeneralFunction();
  Future<List<Map<String, dynamic>>?> getWeatherInfo(BuildContext context) async {

    try {
      var baseURL = BaseRepo().baseurl;
       var endPoint = "GetWetherDetails/GetWetherDetails";
       var weatherApi = "$baseURL$endPoint";

       showLoader();

      // var headers = {
      //   'token': '$sToken',
      //   'Content-Type': 'application/json'
      // };
      var request = http.Request('GET', Uri.parse('$weatherApi'));
     // request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      // if(response.statusCode ==401){
      //   generalFunction.logout(context);
      // }
      if (response.statusCode == 200) {
        hideLoader();
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);
        List<dynamic>? dataList = parsedJson['Data'];

        if (dataList != null) {
          List<Map<String, dynamic>> notificationList = dataList.cast<Map<String, dynamic>>();
          print("xxxxx------46----: $notificationList");
          return notificationList;
        } else{
          return null;
        }
      } else {
        hideLoader();
        return null;
      }
    } catch (e) {
      hideLoader();
      debugPrint("Exception: $e");
      throw e;
    }
  }
}

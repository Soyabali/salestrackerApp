import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../app/loader_helper.dart';
import 'baseurl.dart';


class MarkLocationRepo
{
  List marklocationList = [];
  Future<List> getmarklocation() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? sToken = prefs.getString('sToken');
    try
    {
      showLoader();
      var baseURL = BaseRepo().baseurl;
      var endPoint = "BindPointTypeForMarkLocation/BindPointTypeForMarkLocation";
      var marklocationApi = "$baseURL$endPoint";
      var headers = {
        'token': '$sToken'
      };
      var request = http.Request('GET', Uri.parse('$marklocationApi'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200)
      {
        hideLoader();
        var data = await response.stream.bytesToString();
        Map<String, dynamic> parsedJson = jsonDecode(data);
        marklocationList = parsedJson['Data'];
        print("Dist list Marklocation Api ----71------>:$marklocationList");
        return marklocationList;
      } else
      {
        hideLoader();
        return marklocationList;
      }
    } catch (e)
    {
      hideLoader();
      throw (e);
    }
  }
}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../app/generalFunction.dart';
import '../app/loader_helper.dart';
import '../model/OpportunityListModel.dart';
import 'baseurl.dart';

class OpportunityRepo {
  GeneralFunction generalFunction = GeneralFunction();

  Future<List<OpportunityData>> opportunityList(
      BuildContext context) async {

    SharedPreferences prefs =
    await SharedPreferences.getInstance();

    String? sToken = prefs.getString('sToken');
    String? sCreatedBy = prefs.getString('iUserId');

    print("----sCreatedBy----$sCreatedBy");
    print("----sToken----$sToken");

    showLoader();

    var baseURL = BaseRepo().baseurl;
    var endPoint = "OpportunityDetails/OpportunityDetails";
    var opportunityApi = "$baseURL$endPoint";

    try {
      var headers = {
        'token': sToken ?? '',
        'Content-Type': 'application/json',
      };

      var request =
      http.Request('POST', Uri.parse(opportunityApi));

      request.body = jsonEncode({
        "sCreatedBy": sCreatedBy,
      });

      request.headers.addAll(headers);

      http.StreamedResponse response =
      await request.send();

      print(
          "----Status Code----${response.statusCode}");

      if (response.statusCode == 200) {
        hideLoader();

        String responseBody =
        await response.stream.bytesToString();

        print(
            "----Opportunity Response----$responseBody");

        Map<String, dynamic> jsonResponse =
        jsonDecode(responseBody);

        OpportunityListModel model =
        OpportunityListModel.fromJson(
            jsonResponse);

        return model.data ?? [];
      }
      else if (response.statusCode == 401) {
        hideLoader();
        generalFunction.logout(context);
        throw Exception("Unauthorized access");
      }
      else {
        hideLoader();
        throw Exception(
            "Failed to load opportunity list");
      }
    } catch (e) {
      hideLoader();
      throw Exception(
          "An error occurred: $e");
    } finally {
      hideLoader();
    }
  }
}
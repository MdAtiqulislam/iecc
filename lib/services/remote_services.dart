import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/constraints/api_end_points.dart';
import 'local_services.dart';

class RemoteServices {
  static var clint = http.Client();
  static var baseURL = APIEndPoints.baseURL;

  static var token = "";

  //http post request
  static Future<dynamic> postRequest(
      {required String endPoint, Map<dynamic, dynamic>? body}) async {
    token = await LocalServices.getToken() ?? "";

    if (kDebugMode) {
      print(token);
    }
    var uri = Uri.parse(baseURL + endPoint);
    var requestBody = body;
    var requestHeader = {"Authorization": "Bearer $token"};

    if (kDebugMode) {
      print(baseURL + endPoint);
      print(body);
    }
    try {
      http.Response response = await http.post(
        uri,
        body: requestBody,
        headers: requestHeader,
      );
      // print(body);
        var r = json.decode(response.body);
        if (kDebugMode) {
          print(response.body);
          print(response.statusCode);
        }

        if (r["status"] ?? false) {
          if (kDebugMode) {
            print(r["msg"]);
            print(r);
          }
          return r;
        }
        else {
          String message = r.toString().contains("msg")
              ? r["msg"]
              : "Something went wrong. Please try again later.";
          if (kDebugMode) {
            print(r["msg"]);
          }
          APIEndPoints.httpErrorMSG.value = message;
          return null;
        }

    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
        APIEndPoints.httpErrorMSG.value ="Something went wrong. Please try again later.";
      }
      return null;
    }
  }

  //http post request with Json Data
  static Future<dynamic> postRequestWithJsonData(
      {required String endPoint, Map<dynamic, dynamic>? body}) async {
    //var uri = Uri.parse(baseURL+endPoint);
    token = await LocalServices.getToken() ?? "";
    var uri = Uri.parse(baseURL + endPoint);
    var requestBody = body;
    var requestHeader = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
    };
    if (kDebugMode) {
      print(baseURL + endPoint);
    }
    try {
      http.Response response = await http.post(uri,
          body: json.encode(requestBody),
          headers: requestHeader,
          encoding: Encoding.getByName("utf-8"));
      var r = json.decode(response.body);

      if (r["status"] ?? true) {
        if (kDebugMode) {
          print(r["msg"]);
        }
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        APIEndPoints.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  //http post request with Direct link
  static Future<dynamic> postRequestWithFullLink({required String url}) async {
    token = await LocalServices.getToken() ?? "";
    var requestHeader = {"Authorization": "Bearer $token"};
    try {
      var uri = Uri.parse(url);
      if (kDebugMode) {
        print(url);
      }
      http.Response response = await http.post(uri, headers: requestHeader);
      //print("Response:   ${response.body}");
      var r = json.decode(response.body);

      if (r["status"]) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        APIEndPoints.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  //http get request
  static Future<dynamic> getRequest(
      {required String endPoint,
      Map<String, dynamic>? body,
      Map<String, dynamic>? parameters}) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);

    token = await LocalServices.getToken() ?? "";
    if (kDebugMode) {
      print("Token: $token");
      print(baseURL+endPoint);
    }
    var headers = {"Authorization": "Bearer $token"};
    try {
      var response = await clint.get(
          Uri.parse(baseURL + endPoint).replace(queryParameters: parameters),
          headers: headers);
      var r = json.decode(response.body);

      if (kDebugMode) {
        print(
            Uri.parse(baseURL + endPoint).replace(queryParameters: parameters));
        print(response.body);
      }

      if (r["status"] ?? false) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        APIEndPoints.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  //http get request with full Link
  static Future<dynamic> getRequestLoadMore(
      {required String url, Map<String, dynamic>? body}) async {
    // var response=await clint.get(Uri.parse(baseURL+endPoint),headers:header);
    token = await LocalServices.getToken() ?? "";
    var headers = {"Authorization": "Bearer $token"};

    try {
      var response = await clint.get(Uri.parse(url), headers: headers);
      var r = json.decode(response.body);

      if (kDebugMode) {
        print(url);
        print(response.body);
      }
      if (r["status"]) {
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        APIEndPoints.httpErrorMSG.value = message;
        return null;
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  static Future<List<SingleCountry>?> getCountryList() async {
    var countryListModel = CountryListModel();
    var countryList = <SingleCountry>[];

    try {
      await LocalServices.getCountryList().then((value) async {
        if (value != null) {
          countryList = value.data ?? [];
        } else {
          var endPoint = APIEndPoints.countryList;
          await getRequest(endPoint: endPoint).then((value) async {
            if (value != null) {
              countryListModel = CountryListModel.fromJson(value);
              await LocalServices().storeCountryList(countryListModel);
              countryList = countryListModel.data ?? [];
            }
          });
        }
      });
    } catch (e) {
      var endPoint = APIEndPoints.countryList;
      await getRequest(endPoint: endPoint).then((value) async {
        if (value != null) {
          countryListModel = CountryListModel.fromJson(value);
          await LocalServices().storeCountryList(countryListModel);
          countryList = countryListModel.data ?? [];
        }
      });
    }

    return countryList;
  }

  static Future<dynamic> uploadImages(
      {required File image,
      required endPoint,
      Map<String, String>? body}) async {
    var uri = Uri.parse(baseURL + endPoint);
    var headers = {"Authorization": "Bearer $token"};
    try {
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields.addAll(body ?? {});
      var fileStream = http.ByteStream(image.openRead());
      var length = await image.length();
      var multipartFile = http.MultipartFile(
        'file',
        fileStream,
        length,
        filename: image.path.split('/').last,
      );
      request.files.add(multipartFile);
      var response = await http.Response.fromStream(await request.send());
      var r = json.decode(response.body);
      if (response.statusCode == 200) {
        // Upload successful
        if (kDebugMode) {
          print('Images uploaded successfully');
        }
        return r;
      } else {
        String message = r.toString().contains("msg") ? r["msg"] : "";
        APIEndPoints.httpErrorMSG.value = message;
        if (kDebugMode) {
          print(message);
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return null;
    }
  }
}

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ResponseHandler {
  static Future<T> handleResponse<T>(http.Response response,{ T Function(Map<String, dynamic> data)? successCallback, T Function(String error)? errorCallback })
  async {
    final connectivityResult = await(Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none)
    {
        return errorCallback!( 'No Internt Connection');
    }
    if (response.statusCode == 200)
    {
      try {
        final responseData = json.decode(response.body);
        return successCallback!(responseData);
      }
      catch (e)
      {
        return errorCallback!('Error parsing response data.');
      }
    }
    else if (response.statusCode == 401)
    {
      return errorCallback!('Unauthorized');
    }
    else if (response.statusCode == 408)
    {
      return errorCallback!('Request Timeout');
    } 
    else if (response.statusCode >= 400 && response.statusCode < 500)
    {
      return errorCallback!('Client Error: ${response.statusCode}');
    } 
    else if (response.statusCode >= 500)
    {
      return  errorCallback!('Server Error: ${response.statusCode}');
    }
    else
    {
      return  errorCallback!('Unknown Error: ${response.statusCode}');
    }
  }
}
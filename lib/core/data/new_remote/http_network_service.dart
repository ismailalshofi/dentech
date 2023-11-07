import 'dart:convert';

import 'package:dentech/core/data/new_remote/Enumerations/body_type.dart';
import 'package:dentech/core/data/new_remote/Enumerations/http_method.dart';
import 'package:dentech/core/data/new_remote/network_service.dart';
import 'package:dentech/core/data/new_remote/response_handler.dart';
import 'package:dentech/core/data/new_remote/response_model.dart';
import 'package:dentech/core/utils/functions.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class HttpNetworkService extends NetworkService {

  @override
  Future sendRequest(String endPoint, {HttpMethod method = HttpMethod.get, Map? body, BodyType bodyType = BodyType.formData ,Map<String, String>? queryParameters}) async
  {
      var headers = buildRequestHeaders();
      Uri url = buildRequestUrl(endPoint);
      
      if (queryParameters != null) 
      {
        url = url.replace(queryParameters: queryParameters);
      }
      if(bodyType == BodyType.json)
      {
        jsonEncode(body);
      }
      Printer.print(url.toString());

      Response response;
      switch (method) {
        case HttpMethod.post:
          response = await http.post(
          url,
          body: body,
          headers: headers,
          encoding: Encoding.getByName("utf-8"),
        );
          break;
          case HttpMethod.get:
          response = await http.get(url, headers: headers);
      
          break;
          case HttpMethod.delete:
           response = await http.delete(url, headers: headers);
          break;
          case HttpMethod.put:
           response = await http.put(url, body: body, headers: headers);
          break;
        default:
          response = await get(url, headers: headers);
      }
      
      Printer.print('Response (${method.name.toString()}) ${response.statusCode.toString()}:==> ${response.body.toString()}');
      
    ResponseHandler.handleResponse<ResponseModel>(
      response,
      successCallback: (data) => ResponseModel.fromJson(data),
      errorCallback: (error) => throw Exception(error),
    );

  }
  
  @override
  Future sendMultipartRequest(String endPoint, {HttpMethod method = HttpMethod.get, Map? body, Map<String, String>? queryParameters})
   {
    throw UnimplementedError();
   }

}
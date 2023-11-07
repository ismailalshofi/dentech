



import 'package:dentech/core/data/new_remote/Enumerations/body_type.dart';
import 'package:dentech/core/data/new_remote/Enumerations/http_method.dart';
import 'package:dentech/core/data/new_remote/server_config.dart';

abstract class NetworkService {

  Map<String, String> buildRequestHeaders()
  {
    Map<String, String> header = {};
    return header;
  }

  Uri buildRequestUrl(String endPoint)
  {
    Uri url = Uri.parse(endPoint);
    if (!endPoint.startsWith('http')) url = Uri.parse('${ServerConfig.baseUrl}$endPoint');
    return url;
  }

  Future sendRequest(String endPoint,{HttpMethod method = HttpMethod.get, Map? body, BodyType bodyType, Map<String, String>? queryParameters});
  
  Future sendMultipartRequest(String endPoint,{HttpMethod method = HttpMethod.get, Map? body, Map<String, String>? queryParameters,});

}



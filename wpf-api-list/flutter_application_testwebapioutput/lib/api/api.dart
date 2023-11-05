import 'package:dio/dio.dart';
import 'package:flutter_application_testwebapioutput/api/models/Items.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: 'https://localhost:7080/')
abstract class RestClient {
  factory RestClient(Dio dio, String baseUrl) = _RestClient;

  @GET('/getitems')
  Future<List<Items>> getTasks();
}
 
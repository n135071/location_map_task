import 'package:dio/dio.dart';
import 'package:location_map_task/model/response_model.dart';

import '../model/location_server.dart';


class LocationService {
  Dio dio=Dio();

  Future<ResponseModel<LocationServer>> getLocationServer2() async {
    try {
      final response = await dio.get(
          'https://run.mocky.io/v3/a0d53941-c8e8-4d6b-bac6-e62b6ec6d01f');
      return ResponseModel.complete(
          data: LocationServer.fromJson(response.data));
    } on DioException catch (e) {
      String? message = e.message;
      if (e.type == DioExceptionType.connectionError) {
        return ResponseModel.withError(message: message ?? '');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        return ResponseModel.withError(message: 'please check your connection');
      }
      return ResponseModel.withError(message: message ?? '');
    } catch (e) {
      return ResponseModel.withError(message: e.toString());
    }
  }

}
import 'package:dio/dio.dart';
import 'package:final_proj/core/network/ApiConstants.dart';
import 'package:final_proj/core/network/ApiResult.dart';
import 'package:final_proj/core/network/AppException.dart';
import 'package:final_proj/core/network/DioConfig.dart';
import '../models/restaurant_model.dart';

class HomeService {
  final Dio _dio = DioConfig.getDio();

  Future<ApiResult<dynamic>> getRestaurants() async {
    try {
      final response = await _dio.get(ApiConstants.restaurantsEndPoint);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final restaurants = data.map((e) => RestaurantModel.fromJson(e)).toList();
        return Success(data: restaurants);
      }

      return Failure(AppException(errorMessage: "Failed to load restaurants"));
    } on DioException catch (e) {
      return Failure(AppException.fromDioException(e));
    } catch (e) {
      return Failure(AppException(errorMessage: e.toString()));
    }
  }
}
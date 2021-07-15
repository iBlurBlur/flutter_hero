import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_hero/src/app.dart';
import 'package:flutter_hero/src/configs/routes/app_route.dart';
import 'package:flutter_hero/src/constants/network_api.dart';
import 'package:flutter_hero/src/models/product.dart';
import 'package:http_parser/http_parser.dart';

class NetworkService {
  NetworkService._internal();

  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final Dio _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        options.baseUrl = NetworkAPI.baseURL;
        options.connectTimeout = 5000;
        options.receiveTimeout = 3000;
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response);
      }, onError: (DioError e, handler) {
        switch (e.response?.statusCode) {
          case 301:
            break;
          case 401:
          case 403:
            navigatorState.currentState!.pushNamedAndRemoveUntil(
              AppRoute.login,
              (route) => false,
            );
            break;
          case 404:
            break;
          default:
        }
        return handler.next(e);
      }),
    );

  Future<List<Product>> productAll() async {
    final response = await _dio.get(NetworkAPI.product);
    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    }
    throw Exception();
  }

  Future<String> addProduct(Product product, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response = await _dio.post(NetworkAPI.product, data: data);
    if (response.statusCode == 201) {
      return 'Add Successfully';
    }
    throw Exception();
  }

  Future<String> editProduct(Product product, {File? imageFile}) async {
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        ),
    });

    final response =
        await _dio.put('${NetworkAPI.product}/${product.id}', data: data);
    if (response.statusCode == 200) {
      return 'Edit Successfully';
    }
    throw Exception();
  }

  Future<String> deleteProduct(int id) async {
    final response = await _dio.delete('${NetworkAPI.product}/$id');
    if (response.statusCode == 204) {
      return 'Delete Successfully';
    }
    throw Exception();
  }
}

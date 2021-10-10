import 'dart:developer';

import 'package:chopper/chopper.dart';

import '../../data/models/movie_model.dart';
import '../constants/api_constants.dart';
import '../util/json_to_type.dart';

const get = 'GET';
const post = 'POST';
const put = ' PUT';
const delete = 'DELETE';

abstract class OutSideWorld {
  Future<T> request<T>(
      {required String url,
      String? baseUrl,
      required String method,
      Map<String, dynamic>? body,
      Map<String, String>? headers,
      Map<String, dynamic>? params});
}

class LinkToOutSideWorld extends OutSideWorld {
  final client = ChopperClient(
      baseUrl: ApiConstants.BASE_URL,
      converter: JsonSerializableConverter({
        MoviesModel: (jsonData) => MoviesModel.fromJson(jsonData),
      }),
      interceptors: [
        HttpLoggingInterceptor(),
      ]);

  @override
  Future<T> request<T>(
      {required String url,
      String? baseUrl,
      required String method,
      Map<String, dynamic>? body,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? params,
      bool? isMultipart,
      List<PartValue>? partValue}) async {
    log(T.toString());

    final defaultParams = params ?? {} 
    ..addAll({
      'api_key': ApiConstants.API_KEY
    });

    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});

    final request = Request(method, url, baseUrl ?? client.baseUrl,
        headers: defaultHeaders,
        parameters: defaultParams,
        body: body,
        multipart: isMultipart ?? false,
        parts: partValue ?? []);

    final Response<T> response;
    // try {
    response =
        await client.send<T, T>(request).timeout(const Duration(seconds: 15));
    // } catch (e) {
    //   throw Exception(e);
    // }
    return _handleResponse(response) as T;
  }

  dynamic _handleResponse(Response response) {
    return response.statusCode == 200 && response.body != null
        ? response.body
        : throw Exception(response.error);
  }
}

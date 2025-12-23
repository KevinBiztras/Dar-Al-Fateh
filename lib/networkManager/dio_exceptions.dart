/*
 * *
 *
 *  Webkul Software.
 *
 *  @package Mobikul App
 *
 *  @Category Mobikul
 *
 *  @author Webkul <support@webkul.com>
 *
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *
 *  @license https://store.webkul.com/license.html ASL Licence
 *
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:dio/dio.dart';
import 'package:flutter_project_structure/main.dart';

import '../customWidgtes/dialog_helper.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.unknown:
        message = "Connection to API server failed due to internet connection";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response?.statusCode ?? 400);
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
      case 403:
        return "Unauthorized request";
      case 404:
        return "Not found";
      case 409:
        return "Error due to a conflict";
      case 408:
        return "Connection request timeout";
      case 500:
        return 'Internal server error';
      case 503:
        return "Service unavailable";
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message ?? '';
}

void retryApiFromClient(
  DioError e,
  RequestOptions? reqOptions,
  Dio dio,
  ErrorInterceptorHandler handler,
) {
  // In demo/offline mode (example.com placeholder), skip dialog/retry to avoid noisy popups
  if ((reqOptions?.baseUrl ?? '').contains('example.com')) {
    return;
  }

  var message = DioExceptions.fromDioError(e);
  if (navigatorKey.currentContext != null) {
    DialogHelper.showExceptionDialog(
      message.message ?? "Something Went Wrong",
      navigatorKey.currentContext!,
      onConfirm: () {
        if (reqOptions != null) {
          dio
              .request(
                reqOptions!.path,
                data: reqOptions!.data,
                queryParameters: reqOptions!.queryParameters,
                options: Options(
                  method: reqOptions!.method,
                  receiveTimeout: reqOptions!.receiveTimeout,
                  sendTimeout: reqOptions!.sendTimeout,
                  extra: reqOptions!.extra,
                  headers: reqOptions!.headers,
                  responseType: reqOptions!.responseType,
                  contentType: reqOptions!.contentType,
                  validateStatus: reqOptions!.validateStatus,
                  receiveDataWhenStatusError:
                      reqOptions!.receiveDataWhenStatusError,
                  followRedirects: reqOptions!.followRedirects,
                  maxRedirects: reqOptions!.maxRedirects,
                  requestEncoder: reqOptions!.requestEncoder,
                  responseDecoder: reqOptions!.responseDecoder,
                  listFormat: reqOptions!.listFormat,
                ),
              )
              .then((value) {
                return handler.resolve(value);
              });
        }
      },
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_order_request_model.dart';
import 'package:travelly/data/models/responses/create_order_response_model.dart';
import 'package:travelly/data/models/responses/order_response_model.dart';
import 'package:http/http.dart' as http;

class OrderRemoteDatasource {
  Future<Either<String, CreateOrderResponseModel>> createOrder(
      CreateOrderRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/order'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
      body: jsonEncode(model.toJson()),
    );
    log("Model : ${model.toJson()}");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Right(
          CreateOrderResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, OrderResponseModel>> getOrdersByUser() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders/user/${authData.data!.user!.id!}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("Auth Token: ${authData.toJson()}");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Right(OrderResponseModel.fromJson(data));
    } else {
      return const Left('Failed to get orders');
    }
  }

  Future<Either<String, OrderResponseModel>> getOrdersByUserVendor() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders/user/${authData.data!.user!.id!}/vendor'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("Auth Token: ${authData.toJson()}");
    log("Request URL : ${response.request!.url}");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Right(OrderResponseModel.fromJson(data));
    } else {
      return const Left('Failed to get orders');
    }
  }

  Future<Either<String, String>> getOrdersByUserVendorTotal() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/orders/user/${authData.data!.user!.id!}/vendor/total'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("Auth Token: ${authData.toJson()}");
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'];
      return Right(data.toString());
    } else {
      return const Left('Failed to get total orders');
    }
  }
}

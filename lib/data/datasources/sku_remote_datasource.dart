import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_sku_request_model.dart';
import 'package:travelly/data/models/responses/sku_response_model.dart';
import 'package:http/http.dart' as http;

class SkuRemoteDatasource {
  Future<Either<String, SkuResponseModel>> getSkusUser() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/skus/user/${authData.data!.user!.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("Status Code: ${response.statusCode}");
    log("Response Body: ${response.body}");
    if (response.statusCode == 200) {
      return Right(SkuResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }

  Future<Either<String, String>> createSku(CreateSkuRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/sku'),
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
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}

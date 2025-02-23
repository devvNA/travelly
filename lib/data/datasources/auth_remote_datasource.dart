import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/login_request_model.dart';
import 'package:travelly/data/models/requests/register_request_model.dart';
import 'package:travelly/data/models/responses/login_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  Future<Either<String, LoginResponseModel>> login(
      LoginRequestModel model) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(model.toMap()),
    );
    log(response.body);
    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Failed to Login');
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log(response.body);

    if (response.statusCode == 200) {
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      return const Left('Logout Failed');
    }
  }

  Future<Either<String, String>> register(RegisterRequestModel model) async {
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final url = Uri.parse('${Variables.baseUrl}/api/register');
    final response = await http.post(
      url,
      headers: header,
      body: json.encode(model.toMap()),
    );

    log("statusCode: ${response.statusCode}");
    log("body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      return const Left("Register Failed");
    }
  }
}

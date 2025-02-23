import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_vendor_request_model.dart';
import 'package:http/http.dart' as http;

import '../models/responses/vendor_response_model.dart';

class VendorRemoteDataSource {
  Future<Either<String, VendorResponseModel>> getVendorsUser() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/vendors/user/${authData.data!.user!.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    if (response.statusCode == 200) {
      return Right(VendorResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Failed to get vendors');
    }
  }

  Future<Either<String, String>> createVendor(
      CreateVendorRequestModel model) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/vendor'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token}',
      },
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = jsonDecode(response.body)['message'];
      return Right(message);
    } else {
      final message = jsonDecode(response.body)['message'];
      return Left(message);
    }
  }
}

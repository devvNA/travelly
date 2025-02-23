import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:travelly/core/constants/variabels.dart';
import 'package:travelly/data/datasources/auth_local_datasource.dart';
import 'package:travelly/data/models/requests/create_event_request_model.dart';
import 'package:travelly/data/models/responses/event_response_model.dart';
import 'package:http/http.dart' as http;

class EventRemoteDatasource {
  Future<Either<String, EventResponseModel>> getEvents() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/events'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("statusCOde: ${response.statusCode}");
    log("response body: ${response.body}");
    if (response.statusCode == 200) {
      return Right(EventResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Failed to get events');
    }
  }

  Future<Either<String, EventResponseModel>> getEventsUser() async {
    final authData = await AuthLocalDatasource().getAuthData();

    final response = await http.get(
      Uri.parse(
          '${Variables.baseUrl}/api/events/user/${authData.data!.user!.id}'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${authData.data!.token!}',
      },
    );
    log("statusCode: ${response.statusCode}");
    log("response body: ${response.body}");
    if (response.statusCode == 200) {
      return Right(EventResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return const Left('Failed to get events');
    }
  }

  Future<Either<String, String>> createEvent(
    CreateEventRequestModel model,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.data!.token!}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/events'));
    request.fields.addAll(model.toMap());
    if (model.image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', model.image!.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();
    log(response.stream.toString());
    log(response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      final message = jsonDecode(body)['message'];
      return Right(message);
    } else {
      return const Left('Failed to create event');
    }
  }

  Future<Either<String, String>> updateEvent(
    CreateEventRequestModel model,
    int id,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${authData.data!.token!}',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('${Variables.baseUrl}/api/event/update/$id'));
    request.fields.addAll(model.toMap());
    if (model.image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', model.image!.path));
    }
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();
    log(response.stream.toString());
    log(response.statusCode.toString());

    if (response.statusCode == 201 || response.statusCode == 200) {
      final message = jsonDecode(body)['message'];
      return Right(message);
    } else {
      return const Left('Failed to create event');
    }
  }

  Future<Either<String, String>> deleteEvent(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/event/$id'),
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
      return const Left('Failed to delete event');
    }
  }
}

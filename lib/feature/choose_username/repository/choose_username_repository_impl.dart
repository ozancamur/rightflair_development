import 'package:flutter/material.dart';
import 'package:rightflair/core/base/model/response.dart';

import '../../../core/constants/endpoint.dart';
import '../../../core/services/api.dart';
import 'choose_username_repository.dart';

class ChooseUsernameRepositoryImpl extends ChooseUsernameRepository {
  final ApiService _api;
  ChooseUsernameRepositoryImpl({ApiService? api}) : _api = api ?? ApiService();

  @override
  Future<bool> checkUsername({required String username}) async {
    try {
      final response = await _api.post(
        Endpoint.CHECK_USERNAME,
        data: {'username': username},
      );
      final data = ResponseModel().fromJson(
        response.data as Map<String, dynamic>,
      );
      final bool isUnique =
          (data.data as Map<String, dynamic>)['isUnique'] as bool;
      return isUnique;
    } catch (e) {
      debugPrint("❌ ChooseUsernameRepository ERROR in checkUsername :> $e");
      return false;
    }
  }

  @override
  Future<ResponseModel?> updatedUser({required String username}) async {
    try {
      final response = await _api.post(
        Endpoint.UPDATE_USER,
        data: {'username': username},
      );
      print("REQUEST ${response.requestOptions.headers}");
      final ResponseModel data = ResponseModel().fromJson(response.data);
      return data;
    } catch (e) {
      debugPrint("❌ ChooseUsernameRepository ERROR in updatedUser :> $e");
      return null;
    }
  }
}

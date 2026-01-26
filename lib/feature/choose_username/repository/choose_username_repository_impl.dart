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
      final request = await _api.post(
        Endpoint.CHECK_USERNAME,
        data: {'username': username},
      );
      if (request == null) return false;
      final data = ResponseModel().fromJson(
        request.data as Map<String, dynamic>,
      );
      if (request.data == null) return false;
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
      final request = await _api.post(
        Endpoint.UPDATE_USER,
        data: {'username': username},
      );
      if (request == null) return null;
      final ResponseModel data = ResponseModel().fromJson(request.data);
      if (request.data == null) return null;
      return data;
    } catch (e) {
      debugPrint("❌ ChooseUsernameRepository ERROR in updatedUser :> $e");
      return null;
    }
  }
}

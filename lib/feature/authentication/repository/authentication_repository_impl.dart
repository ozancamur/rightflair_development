import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/endpoint.dart';
import 'package:rightflair/core/services/api.dart';

import '../model/user.dart';

class AuthenticationRepositoryImpl {
  final ApiService _api;

  AuthenticationRepositoryImpl({ApiService? api}) : _api = api ?? ApiService();

  Future<UserModel?> createUser({required UserModel user}) async {
    try {
      final response = await _api.post(
        Endpoint.CREATE_USER,
        data: user.toJson(),
      );
      final UserModel data = UserModel().fromJson(response.data['data']);
      return data;
    } catch (e) {
      debugPrint("❌ SupabaseDatabaseCreateService ERROR in createUser :> $e");
      return null;
    }
  }
}

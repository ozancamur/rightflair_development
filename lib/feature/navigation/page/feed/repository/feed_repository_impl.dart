import 'package:flutter/material.dart';
import 'package:rightflair/core/base/model/response.dart';
import 'package:rightflair/core/constants/endpoint.dart';

import 'package:rightflair/feature/navigation/page/profile/model/request_post.dart';

import '../../../../../core/services/api.dart';
import '../../profile/model/response_post.dart';
import 'feed_repository.dart';

class FeedRepositoryImpl extends FeedRepository {
  final ApiService _api;
  FeedRepositoryImpl({ApiService? api}) : _api = api ?? ApiService();
  @override
  Future<ResponsePostModel?> fetchDiscoverFeed({
    required RequestPostModel body,
  }) async {
    try {
      final request = await _api.post(
        Endpoint.GET_DISCOVER_FEED,
        data: body.toJson(),
      );
      final ResponseModel response = ResponseModel().fromJson(
        request.data as Map<String, dynamic>,
      );
      final ResponsePostModel data = ResponsePostModel().fromJson(
        response.data as Map<String, dynamic>,
      );
      return data;
    } catch (e) {
      debugPrint("FeedRepositoryImpl ERROR in fetchDiscoverFeed :> $e");
      return null;
    }
  }

  @override
  Future<ResponsePostModel?> fetchFollowingFeed({
    required RequestPostModel body,
  }) async {
    try {
      final request = await _api.post(
        Endpoint.GET_DISCOVER_FEED,
        data: body.toJson(),
      );
      final ResponseModel response = ResponseModel().fromJson(
        request.data as Map<String, dynamic>,
      );
      final ResponsePostModel data = ResponsePostModel().fromJson(
        response.data as Map<String, dynamic>,
      );
      return data;
    } catch (e) {
      debugPrint("FeedRepositoryImpl ERROR in fetchDiscoverFeed :> $e");
      return null;
    }
  }

  @override
  Future<ResponsePostModel?> fetchFriendFeed({
    required RequestPostModel body,
  }) async {
    try {
      final request = await _api.post(
        Endpoint.GET_DISCOVER_FEED,
        data: body.toJson(),
      );
      final ResponseModel response = ResponseModel().fromJson(
        request.data as Map<String, dynamic>,
      );
      final ResponsePostModel data = ResponsePostModel().fromJson(
        response.data as Map<String, dynamic>,
      );
      return data;
    } catch (e) {
      debugPrint("FeedRepositoryImpl ERROR in fetchDiscoverFeed :> $e");
      return null;
    }
  }
}

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:river_pods_practice/api_constants/api_constants.dart';

// example weather repository provider
final getUserState = StateProvider<GetUsesState>(
  (ref) {
    return GetUsesState();
  },
);
final getUserFuture = FutureProvider.autoDispose(
  (ref) {
    return ref.read(getUserState).getUsersApiCall();
  },
);

class GetUsesState extends StateNotifier {
  GetUsesState() : super(const AsyncLoading());

  Future<http.Response> getUsersApiCall() async {
    final response = await http.get(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.getUsers),
    );
    return response;
  }
}

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_npm_search/model/result.dart';
import 'package:flutter_npm_search/model/suggestion.dart';
import 'package:flutter_npm_search/model/detail.dart';

class Request {
  static String baseUrl = 'https://api.npms.io/v2';

  Future<Detail> getPackageDetail(String name) async {
    final response = await http.get(baseUrl + '/package/$name');

    return Detail.fromJson(json.decode(response.body));
  }

  Future<Map<String, dynamic>> getSearchResults(
    String q, [
    int from = 0,
    int size = 20,
    String filter = '',
  ]) async {
    final response = await http.get(baseUrl + '/search?q=$q$filter&from=$from&size=$size');
    final data = json.decode(response.body);

    List results = data['results'].map((json) {
      return Result.fromJson(json);
    }).toList();

    return {
      'total': data['total'] as int,
      'results': results,
    };
  }

  Future getSuggestions(
    String q, [
    int size = 10,
  ]) async {
    final response = await http.get(baseUrl + '/search/suggestions?q=$q&size=$size');
    final data = json.decode(response.body);

    final suggestions = data.map((json) {
      return Suggestion.fromJson(json);
    });

    return suggestions;
  }
}

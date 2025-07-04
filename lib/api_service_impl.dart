import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'enums.dart';

class ApiServiceImpl implements ApiService {
  @override
  Future<String> fetchFormattedJson(
    String url, {
    bool prettifiedJson = true,
    HttpMethod method = HttpMethod.GET,
  }) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      if (prettifiedJson) {
        const encoder = JsonEncoder.withIndent('  '); // 2-space indentation
        return encoder.convert(json);
      }
      return json;
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  @override
  bool isUrlValid(String url) {
    if (url.trim().isEmpty) return false;

    final uri = Uri.tryParse(url);
    if (uri != null) {
      // TODO: Might want to consider allowing http as well.
      return uri.isAbsolute && uri.scheme == 'https';
    }

    return false;
  }
}

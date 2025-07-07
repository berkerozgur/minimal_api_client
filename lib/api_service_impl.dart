import 'dart:convert';

import 'package:http/http.dart' as http;

import 'api_service.dart';
import 'enums.dart';

class ApiServiceImpl implements ApiService {
  @override
  Future<String> fetchFormattedJson(
    String url, {
    HttpMethod method = HttpMethod.get,
    Object? body,
    bool prettifiedJson = true,
  }) async {
    // TODO: Handle JSON format exceptions gracefully
    http.Response? response;

    switch (method) {
      case HttpMethod.get:
        response = await http.get(
          Uri.parse(url),
          headers: {'Accept': 'application/json'},
        );
      case HttpMethod.post:
        final bodyText = body?.toString().trim();
        final decoded = bodyText?.isEmpty ?? true ? {} : jsonDecode(bodyText!);
        // final decoded = jsonDecode(body.toString());
        response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(decoded),
        );
      case HttpMethod.put:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HttpMethod.patch:
        // TODO: Handle this case.
        throw UnimplementedError();
      case HttpMethod.delete:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final json = jsonDecode(response.body);
      if (prettifiedJson) {
        const encoder = JsonEncoder.withIndent('  '); // 2-space indentation
        return encoder.convert(json);
      }
      return json;
    } else {
      throw Exception('${response.statusCode}');
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

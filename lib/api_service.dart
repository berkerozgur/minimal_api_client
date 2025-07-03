import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future<String> fetchFormattedJson(String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      const encoder = JsonEncoder.withIndent('  '); // 2-space indentation
      return encoder.convert(json);
    } else {
      return 'Error: ${response.statusCode}';
    }
  }
}

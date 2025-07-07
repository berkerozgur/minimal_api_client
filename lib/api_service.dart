import 'enums.dart';

// Abstract class created for dependency injection and testing purposes.
abstract class ApiService {
  Future<String> fetchFormattedJson(
    String url, {
    HttpMethod method = HttpMethod.get,
    Object? body,
    bool prettifiedJson = true,
  });

  bool isUrlValid(String url);
}

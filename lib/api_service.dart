import 'enums.dart';

// Abstract class created for dependency injection and testing purposes.
abstract class ApiService {
  Future<String> fetchFormattedJson(
    String url, {
    bool prettifiedJson = true,
    HttpMethod method = HttpMethod.GET,
  });

  bool isUrlValid(String url);
}

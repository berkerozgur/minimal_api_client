import 'package:flutter/material.dart';

import '../api_service.dart';
import '../enums.dart';

class InitialViewModel extends ChangeNotifier {
  InitialViewModel(this._apiService);

  final ApiService _apiService;
  final ScrollController scrollController = ScrollController();
  final TextEditingController bodyTextController = TextEditingController();
  final TextEditingController urlTextController = TextEditingController();
  bool _isLoading = false;
  String? _response;
  HttpMethod _selectedMethod = HttpMethod.values.first;

  bool get isBodyEnabled =>
      _selectedMethod == HttpMethod.post ||
      _selectedMethod == HttpMethod.put ||
      _selectedMethod == HttpMethod.patch;
  bool get isLoading => _isLoading;
  String? get response => _response;
  HttpMethod get selectedMethod => _selectedMethod;

  bool _isHttpMethodValid(String method) {
    final found = HttpMethod.values.firstWhere(
      (m) => m.name.toUpperCase() == method.toUpperCase(),
    );
    return HttpMethod.values.contains(found);
  }

  void setHttpMethod(HttpMethod method) {
    _selectedMethod = method;
    notifyListeners();
  }

  Future<void> sendRequest() async {
    final url = urlTextController.text;
    if (!_isHttpMethodValid(_selectedMethod.name)) {
      _response = 'Invalid HTTP method';
      notifyListeners();
      return;
    }

    if (!_apiService.isUrlValid(url)) {
      _response = 'Invalid URL';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.fetchFormattedJson(
        url,
        method: _selectedMethod,
        body: bodyTextController.text,
        prettifiedJson: true,
      );
      _response = response;
    } catch (e) {
      _response = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    bodyTextController.dispose();
    scrollController.dispose();
    urlTextController.dispose();
    super.dispose();
  }
}

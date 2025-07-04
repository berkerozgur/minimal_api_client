import 'package:flutter/material.dart';

import '../api_service.dart';

class InitialViewModel extends ChangeNotifier {
  InitialViewModel(this._apiService);

  final ApiService _apiService;
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  bool _isLoading = false;
  String? _response;

  bool get isLoading => _isLoading;
  String? get response => _response;

  Future<void> sendRequest() async {
    final url = textController.text;

    if (!_apiService.isUrlValid(url)) {
      _response = 'Invalid URL';
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.fetchFormattedJson(url);
      _response = response;
    } catch (e) {
      _response = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    textController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

import '../api_service.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  late final TextEditingController _controller;
  final _apiService = ApiService();
  var _isLoading = false;
  var _response = 'Enter the URL and click Send to get a response';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendRequest() async {
    // TODO: Validate the url
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await _apiService.fetchFormattedJson(_controller.text);
      setState(() {
        _response = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minimal API Client'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter URL',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _sendRequest, child: Text('Send')),
              ],
            ),
            SizedBox(height: 8),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: SingleChildScrollView(
                      child: SelectableText(
                        _response,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

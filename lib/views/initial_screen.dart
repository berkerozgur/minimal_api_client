import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  var _isLoading = false;
  var _response = 'Enter the URL and click Send to get a response';

  void _sendRequest() async {
    // TODO: Validate the url
    try {
      setState(() {
        _isLoading = true;
      });
      // TODO: Replace this delay with actual logic as needed.
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
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
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
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
            _isLoading ? CircularProgressIndicator() : Text(_response),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/initial_viewmodel.dart';

const initialText = 'Enter the URL and click Send to get a response';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<InitialViewModel>(context, listen: false);

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
                    controller: viewModel.textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter URL',
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: viewModel.sendRequest,
                  child: Text('Send'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Consumer<InitialViewModel>(
              builder: (_, vm, __) {
                if (vm.response == null && !vm.isLoading) {
                  return const Align(
                    alignment: Alignment.center,
                    child: Text(initialText),
                  );
                }
                if (vm.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // TODO: This solution isn't ideal. Fix it later
                if (vm.response!.contains('Invalid') ||
                    vm.response!.contains('Error')) {
                  return Align(
                    alignment: Alignment.center,
                    child: Text(vm.response!),
                  );
                }
                return ResponseText(
                  scrollController: vm.scrollController,
                  response: vm.response!,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ResponseText extends StatelessWidget {
  const ResponseText({
    super.key,
    required this.scrollController,
    required this.response,
  });

  final ScrollController scrollController;
  final String response;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: SelectableText(
              response,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums.dart';
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
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  DropdownMenu<HttpMethod>(
                    initialSelection: HttpMethod.values.first,
                    onSelected: (value) {
                      if (value != null) {
                        viewModel.setHttpMethod(value);
                      }
                    },
                    // If set to false, prevents the user from typing in this
                    // field by not requesting focus on tap.
                    requestFocusOnTap: false,
                    dropdownMenuEntries: HttpMethod.values
                        .map(
                          (method) => DropdownMenuEntry(
                            value: method,
                            label: method.name.toUpperCase(),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: viewModel.urlTextController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter URL',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Builder(
                    builder: (context) {
                      return ElevatedButton(
                        onPressed: () {
                          DefaultTabController.of(context).animateTo(1);
                          viewModel.sendRequest();
                        },
                        child: Text('Send'),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              TabBar(
                tabs: [
                  Tab(text: 'Body'),
                  Tab(text: 'Response'),
                ],
              ),
              Expanded(child: TabBarView(children: [BodyTab(), ResponseTab()])),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyTab extends StatelessWidget {
  const BodyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InitialViewModel>(
      builder: (_, vm, __) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller: vm.bodyTextController,
            decoration: InputDecoration(border: OutlineInputBorder()),
            enabled: vm.isBodyEnabled,
            expands: true,
            maxLines: null,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontFamily: 'monospace'),
            textAlignVertical: TextAlignVertical.top,
          ),
        );
      },
    );
  }
}

class ResponseTab extends StatelessWidget {
  const ResponseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Consumer<InitialViewModel>(
        builder: (_, vm, __) {
          if (vm.response == null && !vm.isLoading) {
            return Center(child: Text(initialText));
          }
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          // TODO: This solution isn't ideal. Fix it later
          if (vm.response!.contains('Invalid') ||
              vm.response!.contains('Exception')) {
            return Center(child: Text(vm.response!));
          }
          return ResponseText(
            scrollController: vm.scrollController,
            response: vm.response!,
          );
        },
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
    return ConstrainedBox(
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
    );
  }
}

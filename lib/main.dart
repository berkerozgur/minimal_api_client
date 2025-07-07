import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'api_service_impl.dart';
import 'theme/app_theme.dart';
import 'viewmodels/initial_viewmodel.dart';
import 'views/initial_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(600, 400));
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => InitialViewModel(ApiServiceImpl()),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal API Client',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const InitialScreen(),
    );
  }
}

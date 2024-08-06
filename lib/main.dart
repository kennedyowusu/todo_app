import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod_sync/screens/providers/app_theme/app_theme_provider.dart';
import 'package:todo_riverpod_sync/screens/todos_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Riverpod Todos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness:
            currentTheme == AppTheme.light ? Brightness.light : Brightness.dark,
        useMaterial3: true,
      ),
      home: const TodoScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meetmax/screens/auth_gate.dart';
import 'package:meetmax/theme.dart';
import 'package:meetmax/viewmodels/auth_view_model.dart';
import 'package:meetmax/viewmodels/feed_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => FeedViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meetmax',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meetmax/screens/feed_screen.dart';
import 'package:meetmax/screens/login_screen.dart';
import 'package:meetmax/viewmodels/auth_view_model.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return authViewModel.isLoggedIn ? const FeedScreen() : const LoginScreen();
  }
}

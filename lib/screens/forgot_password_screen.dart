import 'package:flutter/material.dart';
import 'package:meetmax/widgets/auth_header.dart';
import 'package:meetmax/widgets/custom_textfield.dart';
import 'package:meetmax/widgets/primary_button.dart';
// Import theme for consistent styling

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthHeader(),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Forgot Password?',
                  style: Theme.of(context).textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(
                'Enter your details to receive a reset link',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 32),
              const CustomTextField(
                hintText: 'Your Email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Send',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Password reset link sent! (Simulated)')),
                  );
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back to Sign In'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

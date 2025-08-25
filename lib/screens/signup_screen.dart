import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meetmax/widgets/auth_header.dart';
import 'package:meetmax/widgets/social_login_button.dart';
import 'package:provider/provider.dart';
import 'package:meetmax/models/user_model.dart';
import 'package:meetmax/viewmodels/auth_view_model.dart';
import 'package:meetmax/widgets/custom_textfield.dart';
import 'package:meetmax/widgets/primary_button.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _birthDateController = TextEditingController();
  String _gender = 'Male';
  bool _isPasswordObscured = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime lastSelectableDate =
        DateTime(now.year - 13, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastSelectableDate,
      firstDate: DateTime(1920),
      lastDate:
          lastSelectableDate, // This prevents selecting dates for users under 13
    );

    if (picked != null) {
      setState(() {
        _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        birthDate: _birthDateController.text,
      );
      final authViewModel = context.read<AuthViewModel>();
      final success = await authViewModel.register(user);
      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Registration successful! Please log in.')),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(authViewModel.errorMessage ?? 'Registration failed.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      appBar: const AuthHeader(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 35.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Getting Started',
                      style: Theme.of(context).textTheme.displaySmall),
                  const SizedBox(height: 8),
                  Text(
                      "Create an account to continue and connect with the people.",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Expanded(
                        child: SocialLoginButton(
                          brandIcon: FontAwesomeIcons.google,
                          text: 'Google',
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SocialLoginButton(
                          brandIcon: FontAwesomeIcons.apple,
                          text: 'Apple',
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 32),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Your Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter your name' : null,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Your Email',
                    prefixIcon: Icons.email_outlined,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter an email';
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'Create Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: _isPasswordObscured,
                    onSuffixIconTap: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                    suffixIcon: Icon(
                      _isPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter a password';
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: _birthDateController,
                    hintText: 'Date of Birth',
                    prefixIcon: Icons.calendar_today_outlined,
                    readOnly: true,
                    onTap: () => _selectDate(context),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select your date of birth';
                      }
                      try {
                        final birthDate = DateFormat('dd/MM/yyyy').parse(value);
                        final today = DateTime.now();
                        final thirteenYearsAgo =
                            DateTime(today.year - 13, today.month, today.day);
                        if (birthDate.isAfter(thirteenYearsAgo)) {
                          return 'You must be at least 13 years old';
                        }
                      } catch (e) {
                        return 'Invalid date format';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Radio<String>(
                          value: 'Male',
                          // ignore: deprecated_member_use
                          groupValue: _gender,
                          // ignore: deprecated_member_use
                          onChanged: (val) => setState(() => _gender = val!)),
                      const Text('Male'),
                      const SizedBox(width: 24),
                      Radio<String>(
                          value: 'Female',
                          // ignore: deprecated_member_use
                          groupValue: _gender,
                          // ignore: deprecated_member_use
                          onChanged: (val) => setState(() => _gender = val!)),
                      const Text('Female'),
                    ],
                  ),
                  const SizedBox(height: 32),
                  authViewModel.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : PrimaryButton(text: 'Sign Up', onPressed: _register),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Sign In'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

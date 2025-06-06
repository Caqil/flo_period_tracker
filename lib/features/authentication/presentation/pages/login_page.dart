import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';
import '../../../../config/routes/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        AuthLoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            if (state.user.isOnboardingCompleted) {
              context.go(RouteNames.home);
            } else {
              context.go(RouteNames.onboarding);
            }
          } else if (state is AuthError) {
            ShadToaster.of(context).show(
              ShadToast.destructive(
                title: const Text('Login Failed'),
                description: Text(state.message),
              ),
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),

                  // Logo and title
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryPink,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Welcome back',
                        style: theme.textTheme.h1?.copyWith(
                          color: theme.colorScheme.foreground,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to your Flo account',
                        style: theme.textTheme.p?.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 48),

                  // Email field
                  ShadInputFormField(
                    controller: _emailController,
                    placeholder: const Text('Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.email,
                    decoration: ShadDecoration(
                      border: ShadBorder.all(
                        color: theme.colorScheme.border,
                        width: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Password field
                  ShadInputFormField(
                    controller: _passwordController,
                    placeholder: const Text('Password'),
                    obscureText: !_isPasswordVisible,
                    validator: Validators.password,
                    trailing: ShadButton.ghost(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      child: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 20,
                      ),
                    ),
                    decoration: ShadDecoration(
                      border: ShadBorder.all(
                        color: theme.colorScheme.border,
                        width: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Login button
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ShadButton(
                        onPressed: state is AuthLoading ? null : _handleLogin,
                        backgroundColor: AppTheme.primaryPink,
                        child: state is AuthLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                      );
                    },
                  ),

                  const SizedBox(height: 16),

                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: theme.textTheme.p?.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                      ShadButton.ghost(
                        onPressed: () => context.go(RouteNames.register),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppTheme.primaryPink,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

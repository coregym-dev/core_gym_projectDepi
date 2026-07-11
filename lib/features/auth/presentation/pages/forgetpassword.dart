import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/validator.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/login.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/authbackground.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/custom_main_button.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/customauthfield.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/glass_container.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: GlassContainer(
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (state is AuthResetPasswordSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password reset link sent'),
                    backgroundColor: Colors.green,
                  ),
                );
                MaterialPageRoute(builder: (context) => const LoginPage());
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('images/home.webp', width: 100, height: 100),
                    const SizedBox(height: 16),
                    const Text(
                      'Forget your password?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please enter your email ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(178, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomAuthField(
                      controller: _emailController,
                      validator: Validator.validateEmail,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),

                    const SizedBox(height: 16),

                    CustomMainButton(
                      isLoading: state is AuthLoading,
                      text: 'check email',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().resetPassword(
                            _emailController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

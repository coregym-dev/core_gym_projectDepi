import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/login.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/verification.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/authbackground.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/custom_main_button.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/customauthfield.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/glass_container.dart';
import 'package:flutter_coffee/core/validator.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
              print(
                '=================== CUBIT STATE IS: $state ================',
              );
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (state is AuthSignUpSuccessFully) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('welcome ya ${_usernameController.text}'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<AuthCubit>(),
                      child: VerificationPage(email: _emailController.text),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/Background.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Please enter your details to sign in',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(178, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomAuthField(
                      controller: _usernameController,
                      validator: Validator.validateName,
                      hintText: 'username',
                      prefixIcon: Icons.person_outlined,
                    ),
                    const SizedBox(height: 16),
                    CustomAuthField(
                      controller: _emailController,
                      validator: Validator.validateEmail,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 16),

                    CustomAuthField(
                      controller: _passwordController,
                      validator: Validator.validatePassword,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      isPassword: true,
                    ),
                    const SizedBox(height: 16),
                    CustomAuthField(
                      controller: _phoneController,
                      validator: Validator.validatePhone,
                      hintText: 'phone number',
                      prefixIcon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    CustomMainButton(
                      isLoading: state is AuthLoading,
                      text: 'Sign up',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().signUpWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            username: _usernameController.text,
                            phoneNumber: _phoneController.text,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "have an account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'sign in',
                            style: TextStyle(
                              color: Colors.yellowAccent,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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

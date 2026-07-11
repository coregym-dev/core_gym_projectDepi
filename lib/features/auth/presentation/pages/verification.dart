import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/core/validator.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/home.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/user_metrics_page.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/authbackground.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/custom_main_button.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/customauthfield.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/glass_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationPage extends StatefulWidget {
  final String email;
  const VerificationPage({super.key, required this.email});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _codeController.dispose();
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
              } else if (state is AuthLoadedWithuser) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Verification Successful! Welcome ${state.user.name}',
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<AuthCubit>(),
                      child: const UserMetricsPage(),
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
                      'images/home.webp',
                      width: 100.w,
                      height: 100.h,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'verification code',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Please enter the code sent to your email',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: const Color.fromARGB(178, 255, 255, 255),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    CustomAuthField(
                      controller: _codeController,
                      hintText: '6 digit code',
                      prefixIcon: Icons.numbers,
                      keyboardType: TextInputType.number,
                    ),

                    SizedBox(height: 16.h),

                    CustomMainButton(
                      text: 'check email',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().verifyEmailOTP(
                            email: widget.email,
                            otpCode: _codeController.text,
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16.h),
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

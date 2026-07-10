import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter_coffee/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter_coffee/features/auth/presentation/pages/home.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/authbackground.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/custom_main_button.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/customauthfield.dart';
import 'package:flutter_coffee/features/auth/presentation/widgets/glass_container.dart';

class UserMetricsPage extends StatefulWidget {
  const UserMetricsPage({super.key});

  @override
  State<UserMetricsPage> createState() => _UserMetricsPageState();
}

class _UserMetricsPageState extends State<UserMetricsPage> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
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
              // 2. معالجة حالة الخطأ
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              } else if (state is AuthMetricsUpdatedSuccessfully) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Complete your profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Let us know your stats to customize your workout',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                    const SizedBox(height: 24),

                    CustomAuthField(
                      controller: _weightController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your weight' : null,
                      hintText: 'Weight (kg)',
                      prefixIcon: Icons.monitor_weight_outlined,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    CustomAuthField(
                      controller: _heightController,
                      validator: (value) =>
                          value!.isEmpty ? 'Enter your height' : null,
                      hintText: 'Height (cm)',
                      prefixIcon: Icons.height,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 32),

                    CustomMainButton(
                      text: 'Save & Continue',
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final double weight =
                              double.tryParse(_weightController.text) ?? 0.0;
                          final double height =
                              double.tryParse(_heightController.text) ?? 0.0;

                          context.read<AuthCubit>().updateUserMetrics(
                            weight: weight,
                            height: height,
                          );
                        }
                      },
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

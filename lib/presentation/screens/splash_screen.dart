import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/splash/splash_cubit.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';

import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashEnd) {
            context.goNamed(AppRoutes.HOME_SCREEN);
          }
        },
        child: const Center(
          child: Text(
            "My App",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/details/details_bloc.dart';
import 'package:flutter_bloc_template/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_template/blocs/splash/splash_cubit.dart';
import 'package:flutter_bloc_template/core/navigation/app_router.dart';
import 'package:flutter_bloc_template/data/repositories/home_screen_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => HomeScreenRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SplashCubit()..startSplash()),
          BlocProvider(create: (context) => HomeBloc()),
          BlocProvider(create: (context) => DetailsBloc()),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Bloc App',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}

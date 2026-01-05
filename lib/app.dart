import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/details/details_bloc.dart';
import 'package:flutter_bloc_template/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_template/blocs/splash/splash_cubit.dart';
import 'package:flutter_bloc_template/core/navigation/app_router.dart';
import 'package:flutter_bloc_template/core/theme/app_theme.dart';
import 'package:flutter_bloc_template/data/repositories/product_repository.dart';

import 'core/utils/helper/app_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ProductRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SplashCubit()..startSplash()),
          BlocProvider(create: (context) => HomeBloc(context.read<ProductRepository>())..add(DataFetchingEvent())),
          BlocProvider(create: (context) => DetailsBloc(context.read<ProductRepository>())..add(ProductDetailsInitEvent())),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Bloc',
          theme: const AppTheme(TextTheme()).light(),
          darkTheme: const AppTheme(TextTheme()).dark(),
          scaffoldMessengerKey: scaffoldMessengerKey,
          themeMode: ThemeMode.system,
          routerConfig: appRouter,
        ),
      ),
    );
  }
}

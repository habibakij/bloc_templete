import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/data/model/home_screen/item_list_model.dart';
import 'package:flutter_bloc_template/presentation/screens/details_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.SPLASH_SCREEN,
      name: AppRoutes.SPLASH_SCREEN,
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.HOME_SCREEN,
      name: AppRoutes.HOME_SCREEN,
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.DETAILS_SCREEN,
      name: AppRoutes.DETAILS_SCREEN,
      builder: (context, state) {
        final item = state.extra as ItemListModel;
        return DetailsScreen(item: item);
      },
    ),
  ],
);

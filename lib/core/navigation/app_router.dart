import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/presentation/screens/cart_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/details_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/my_order.dart';
import 'package:flutter_bloc_template/presentation/screens/order_confirmation_screen.dart';
import 'package:flutter_bloc_template/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

import 'custom_transition.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.SPLASH_SCREEN,
      name: AppRoutes.SPLASH_SCREEN,
      pageBuilder: (context, state) => customTransition(state: state, child: SplashScreen()),
    ),
    GoRoute(
      path: AppRoutes.HOME_SCREEN,
      name: AppRoutes.HOME_SCREEN,
      pageBuilder: (context, state) => customTransition(state: state, child: HomeScreen()),
    ),
    GoRoute(
      path: "${AppRoutes.DETAILS_SCREEN}/:id",
      name: AppRoutes.DETAILS_SCREEN,
      pageBuilder: (context, state) {
        final int itemId = int.parse(state.pathParameters['id']!);
        return customTransition(state: state, child: DetailsScreen(productId: itemId));
      },
    ),
    GoRoute(
      path: AppRoutes.CART_SCREEN,
      name: AppRoutes.CART_SCREEN,
      pageBuilder: (context, state) => customTransition(state: state, child: CartScreen()),
    ),
    GoRoute(
      path: AppRoutes.ORDER_CONFIRMATION,
      name: AppRoutes.ORDER_CONFIRMATION,
      pageBuilder: (context, state) => customTransition(state: state, child: OrderConfirmationScreen()),
    ),
    GoRoute(
      path: AppRoutes.MY_ORDER,
      name: AppRoutes.MY_ORDER,
      pageBuilder: (context, state) => customTransition(state: state, child: MyOrder()),
    ),
  ],
);

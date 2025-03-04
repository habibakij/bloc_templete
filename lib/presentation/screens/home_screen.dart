import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/home/home_bloc.dart';
import 'package:flutter_bloc_template/core/navigation/app_routes.dart';
import 'package:flutter_bloc_template/core/theme/app_text_styles.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';
import 'package:flutter_bloc_template/core/utils/widget/nev_drawer.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CommonAppBar(title: "Home", scaffoldKey: _scaffoldKey),
      drawer: const CommonDrawer(),
      body: BlocProvider(
        create: (context) {
          final homeBloc = HomeBloc();
          homeBloc.add(HomeEventInitial());
          return homeBloc;
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is ItemLoading || state is HomeInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ItemLoaded) {
              return ListView.separated(
                itemCount: state.listItem.length,
                itemBuilder: (context, index) {
                  final item = state.listItem[index];
                  return ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("User ID: ${item.id}",
                          style: AppTextStyles.titleTextStyle()),
                    ),
                    subtitle: Text(item.title ?? "",
                        style: AppTextStyles.bodyTextStyle()),
                    onTap: () {
                      context.pushNamed(AppRoutes.DETAILS_SCREEN,
                          pathParameters: {'id': item.id.toString()});

                      //context.goNamed(AppRoutes.DETAILS_SCREEN, extra: item.id);
                    },
                  );
                },
                separatorBuilder: (_, index) {
                  return Divider(height: 2.0);
                },
              );
            } else if (state is ItemError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const Center(child: Text("No data available"));
          },
        ),
      ),
    );
  }
}

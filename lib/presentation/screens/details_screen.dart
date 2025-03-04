import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/blocs/details/details_bloc.dart';
import 'package:flutter_bloc_template/core/theme/app_text_styles.dart';
import 'package:flutter_bloc_template/core/utils/widget/common_app_bar.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatelessWidget {
  final int itemId;
  const DetailsScreen({super.key, required this.itemId});

  final String _appBarTitle = "Loading...";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final detailsBloc = DetailsBloc();
        detailsBloc.add(DetailsEventInitial(itemID: itemId));
        return detailsBloc;
      },
      child: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is ItemLoading || state is DetailsInitial) {
            return Scaffold(
              appBar: CommonAppBar(title: _appBarTitle),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ItemLoaded) {
            return Scaffold(
              appBar: CommonAppBar(title: "User ID: ${state.itemDetails.id}"),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  state.itemDetails.title ?? "",
                  style: AppTextStyles.bodyTextStyle(),
                ),
              ),
            );
          } else if (state is ItemError) {
            return Scaffold(
              appBar: CommonAppBar(title: _appBarTitle),
              body: Center(child: Text("Error: ${state.message}")),
            );
          }
          return Scaffold(
            appBar: CommonAppBar(title: _appBarTitle),
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}

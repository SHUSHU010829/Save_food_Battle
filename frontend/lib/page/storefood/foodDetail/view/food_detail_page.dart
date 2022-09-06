import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/models/storefood_carditem2.dart';
import 'package:frontend/page/storefood/foodDetail/food_detail.dart';

/// {@template counter_page}
/// A [StatelessWidget] which is responsible for providing a
/// [CounterCubit] instance to the [FoodDetailView].
/// {@endtemplate}
class FoodDetailPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  // final AllCardItem all_card_item;

  /// {@macro counter_page}
  const FoodDetailPage({
    super.key,
    // ignore: non_constant_identifier_names
    // required this.all_card_item,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FoodDetailCubit(),
      child: FoodDetailView(),
    );
  }
}

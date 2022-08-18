import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/page/storefood/foodDetail/food_detail.dart';

/// {@template counter_view}
/// A [StatelessWidget] which reacts to the provided
/// [CounterCubit] state and notifies it in response to user input.
/// {@endtemplate}
class FoodDetailView extends StatelessWidget {
  /// {@macro counter_view}
  const FoodDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: BlocBuilder<FoodDetailCubit, int>(
          builder: (context, state) {
            return Text('$state', style: textTheme.headline2);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            key: const Key('foodDetailView_increment_floatingActionButton'),
            child: const Icon(Icons.add),
            onPressed: () => context.read<FoodDetailCubit>().increment(),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            key: const Key('foodDetailView_decrement_floatingActionButton'),
            child: const Icon(Icons.remove),
            onPressed: () => context.read<FoodDetailCubit>().decrement(),
          ),
        ],
      ),
    );
  }
}

import 'package:api_prices/components.dart';
import 'package:api_prices/cubit/cubit.dart';
import 'package:api_prices/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit()..getPrices(context),
      child: BlocConsumer<MainCubit, States>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Center(child: Text("Today's Prices")),
            ),
            body: Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  metalItem(context,
                      gold: true, price: MainCubit.get(context).goldI),
                  metalItem(context,
                      gold: false, price: MainCubit.get(context).silverI),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

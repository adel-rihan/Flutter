// import 'package:bmi_calculator/models/result_model.dart';
import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as ResultModel;

    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('BMI Result'.toUpperCase()),
          ),
          body: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 10, bottom: 20),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Inputs'.toUpperCase(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 15),
                            inputRow(
                              context,
                              title: 'Gender',
                              value: cubit.isMale ? 'Male' : 'Female',
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'Age',
                              value: '${cubit.age}',
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'Height',
                              value: '${cubit.height.round()} cm',
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'Weight',
                              value: '${cubit.weight} kg',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                            start: 20, end: 20, top: 10, bottom: 20),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Outputs'.toUpperCase(),
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: 15),
                            inputRow(
                              context,
                              title: 'BMI',
                              value: '${cubit.bmi}',
                              width: 122,
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'BMI Category',
                              value: cubit.status,
                              width: 122,
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'Ideal Weight',
                              value: '${cubit.idealW} kg',
                              width: 122,
                            ),
                            const SizedBox(height: 5),
                            inputRow(
                              context,
                              title: 'Ideal BMI',
                              value: cubit.idealB,
                              width: 122,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

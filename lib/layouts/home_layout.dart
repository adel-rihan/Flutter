import 'package:bmi_calculator/shared/components/components.dart';
import 'package:bmi_calculator/shared/cubit/cubit.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('BMI Calculator'.toUpperCase()),
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: genderCard(
                          context,
                          male: true,
                          onTap: () => cubit.changeGender(male: true),
                          isSelected: cubit.isMale,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: genderCard(
                          context,
                          male: false,
                          onTap: () => cubit.changeGender(male: false),
                          isSelected: !cubit.isMale,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Height'.toUpperCase(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                cubit.height.round().toString(),
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              Text(
                                'cm',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                          Slider(
                            min: 1,
                            max: 230,
                            value: cubit.height,
                            onChanged: cubit.changeHeight,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: plusMinCard(
                          context,
                          title: 'Weight',
                          value: cubit.weight,
                          isEnabledMin: cubit.weightIsEnabledMin(),
                          isEnabledPlus: cubit.weightIsEnabledPlus(),
                          onPressedMin: () => cubit.changeWeight(plus: false),
                          onPressedPlus: () => cubit.changeWeight(plus: true),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: plusMinCard(
                          context,
                          title: 'Age',
                          value: cubit.age,
                          isEnabledMin: cubit.ageIsEnabledMin(),
                          isEnabledPlus: cubit.ageIsEnabledPlus(),
                          onPressedMin: () => cubit.changeAge(plus: false),
                          onPressedPlus: () => cubit.changeAge(plus: true),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 70,
                width: double.infinity,
                child: MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () => cubit.calculateBMI(context),
                  child: Text(
                    'Calculate'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

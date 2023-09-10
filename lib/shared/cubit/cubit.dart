import 'dart:math';

import 'package:bmi_calculator/shared/components/constants.dart';
import 'package:bmi_calculator/shared/components/routes.dart';
import 'package:bmi_calculator/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//
/// Home Layout
class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(InitialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  bool isMale = true;
  double height = 185;
  int weight = 90;
  int age = 25;

  late double bmi;
  late String status;
  late String idealW;
  late String idealB;

  bool weightIsEnabledMin() => weight > minWeight;
  bool weightIsEnabledPlus() => weight < maxWeight;

  bool ageIsEnabledMin() => age > minAge;
  bool ageIsEnabledPlus() => age < maxAge;

  void changeGender({required bool male}) {
    isMale = male;

    emit(ChangeHomeLayoutState());
  }

  void changeHeight(double value) {
    height = value.roundToDouble();

    emit(ChangeHomeLayoutState());
  }

  void changeWeight({required bool plus}) {
    weight = plus ? weight + 1 : weight - 1;

    emit(ChangeHomeLayoutState());
  }

  void changeAge({required bool plus}) {
    age = plus ? age + 1 : age - 1;

    emit(ChangeHomeLayoutState());
  }

  void calculateBMI(context) async {
    bmi = await valueBMI();
    status = await statusBMI();
    idealW = await idealWeight();
    idealB = await idealBMI();

    Routes.pushResult(context);
  }

  Future<double> valueBMI() async {
    double bmi = weight / pow(height / 100, 2);
    bmi = double.parse(bmi.toStringAsFixed(2));
    return bmi;
  }

  Future<String> statusBMI() async {
    String status = '';

    if (age >= 20) {
      switch (bmi) {
        case < 16:
          status = 'Severely Underweight';
          break;
        case >= 16 && < 18.5:
          status = 'Underweight';
          break;
        case >= 18.5 && < 25:
          status = 'Normal weight';
          break;
        case >= 25 && < 30:
          status = 'Overweight';
          break;
        case >= 30 && < 35:
          status = 'Moderately Obese';
          break;
        case >= 35 && < 40:
          status = 'Severely Obese';
          break;
        case >= 40:
          status = 'Morbidly Obese';
          break;
      }
    } else {
      if (isMale) {
        switch (bmi) {
          case < 15:
            status = 'Underweight';
            break;
          case >= 15 && < 18:
            status = 'Healthy weight,';
            break;
          case >= 18 && < 19.5:
            status = 'Overweight';
            break;
          case >= 19.5:
            status = 'Obese';
            break;
        }
      } else {
        switch (bmi) {
          case < 14.5:
            status = 'Underweight';
            break;
          case >= 14.5 && < 18:
            status = 'Healthy weight,';
            break;
          case >= 18 && < 19:
            status = 'Overweight';
            break;
          case >= 19:
            status = 'Obese';
            break;
        }
      }
    }

    return status;
  }

  Future<String> idealWeight() async {
    double minBMI = age < 20
        ? isMale
            ? 15
            : 25
        : 18.5;
    double maxBMI = age < 20 ? 18 : 25;

    double minWeight = minBMI * pow(height / 100, 2);
    minWeight = double.parse(minWeight.toStringAsFixed(2));

    double maxWeight = maxBMI * pow(height / 100, 2);
    maxWeight = double.parse(maxWeight.toStringAsFixed(2));

    return '$minWeight - $maxWeight';
  }

  Future<String> idealBMI() async {
    String ideal = '';
    switch (age) {
      case < 20:
        ideal = isMale ? '15 - 18' : '14.5 - 18';
        break;
      case >= 20:
        ideal = '18.5 - 25';
        break;
    }
    return ideal;
  }
}

import 'package:api_prices/cubit/states.dart';
import 'package:api_prices/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<States> {
  MainCubit() : super(InitState());

  static MainCubit get(context) => BlocProvider.of(context);

  double goldD = 0;
  int goldI = 0;

  double silverD = 0;
  int silverI = 0;

  getPrices(context) {
    DioHelper.getData('XAU/EGP/').then((value) {
      goldD = value.data['price'];

      DioHelper.getData('XAG/EGP/').then((value) {
        silverD = value.data['price'];

        goldI = goldD.round();
        silverI = silverD.round();

        emit(GetPricesState());
      }).catchError((error) {
        errorHandle(context, error);
      });
    }).catchError((error) {
      errorHandle(context, error);
    });
  }

  errorHandle(context, error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error happened while getting the data!\n$error')));

    emit(GetPricesState());
  }
}

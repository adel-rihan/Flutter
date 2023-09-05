import 'package:api_prices/components.dart';
import 'package:api_prices/network/dio_helper.dart';
import 'package:flutter/material.dart';

class MainScreenFul extends StatefulWidget {
  const MainScreenFul({super.key});

  @override
  State<MainScreenFul> createState() => _MainScreenFulState();
}

class _MainScreenFulState extends State<MainScreenFul> {
  @override
  void initState() {
    super.initState();

    getPrices();
  }

  double goldD = 0;
  int goldI = 0;

  double silverD = 0;
  int silverI = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Today's Prices")),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            metalItem(context, gold: true, price: goldI),
            metalItem(context, gold: false, price: silverI),
          ],
        ),
      ),
    );
  }

  getPrices() {
    DioHelper.getData('XAU/EGP/').then((value) {
      goldD = value.data['price'];

      DioHelper.getData('XAG/EGP/').then((value) {
        silverD = value.data['price'];

        goldI = goldD.round();
        silverI = silverD.round();

        setState(() {});
      }).catchError((error) {
        errorHandle(error);
      });
    }).catchError((error) {
      errorHandle(error);
    });
  }

  errorHandle(error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error happened while getting the data!\n$error')));

    setState(() {});
  }
}

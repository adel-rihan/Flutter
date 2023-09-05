import 'package:color_screen/color_screen.dart';
import 'package:color_screen/components.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Color Screen')),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 0, bottom: 10, right: 5, left: 5),
        child: Scrollbar(
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            crossAxisCount: 3,
            children: colorsList
                .map(
                  (colorItem) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ColorScreen(colorItem)));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, bottom: 0, right: 5, left: 5),
                      decoration: BoxDecoration(
                        color: colorItem,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(5, 5),
                            color: Colors.grey,
                            blurRadius: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shop/styles/colors.dart';

class LoadingIndicatorDialog {
  static final LoadingIndicatorDialog singleton = LoadingIndicatorDialog.internal();

  LoadingIndicatorDialog.internal();

  factory LoadingIndicatorDialog() => singleton;

  late BuildContext _context;
  bool isDisplayed = false;

  show(BuildContext context, {String text = 'Loading...'}) {
    if (isDisplayed) {
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: bgColor(context).withOpacity(0.8),
      builder: (BuildContext context) {
        _context = context;
        isDisplayed = true;
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: textFGColorPrimary(context)),
                  const SizedBox(height: 20),
                  Text(
                    text,
                    style: TextStyle(
                      color: textFGColorPrimary(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // child: SimpleDialog(
          //   backgroundColor: Colors.transparent,
          //   children: [
          //     Center(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           const Padding(
          //             padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          //             child: CircularProgressIndicator(),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.all(16),
          //             child: Text(
          //               text,
          //               style: const TextStyle(
          //                   color: Colors.white, fontWeight: FontWeight.bold),
          //             ),
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
        );
      },
    );
  }

  dismiss() {
    if (isDisplayed) {
      Navigator.of(_context).pop();
      isDisplayed = false;
    }
  }
}

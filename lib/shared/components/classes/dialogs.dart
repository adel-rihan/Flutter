import 'package:flutter/cupertino.dart';

dynamic alertDialog(BuildContext context,
    {String title = 'Alert', required String text}) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

Future<bool> alertYesNoDialog(BuildContext context,
    {required String title, required String text}) async {
  bool result = false;

  await showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(text),
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            result = false;
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        CupertinoDialogAction(
          // isDestructiveAction: true,
          onPressed: () {
            result = true;
            Navigator.pop(context);
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );

  return result;
}

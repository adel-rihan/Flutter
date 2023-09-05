import 'package:flutter/material.dart';
import 'package:tasks_local_database/shared/components/controls/custom_input_field.dart';

class CustomTimeField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final bool isDense;

  const CustomTimeField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.prefixIcon,
    this.isDense = false,
  }) : super(key: key);

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  TimeOfDay chosenTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    if (widget.controller.text.isNotEmpty) {
      chosenTime = timeFromString(widget.controller.text);
    }
  }

  TimeOfDay timeFromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];

    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1]),
    );
  }

  void showPicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: chosenTime,
    ).then((value) {
      setState(() {
        if (value != null) {
          chosenTime = value;
          widget.controller.text = value.format(context).toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputField(
      controller: widget.controller,
      labelText: widget.labelText,
      validator: widget.validator,
      isDense: widget.isDense,
      readOnly: true,
      textType: TextInputType.datetime,
      prefixIcon: widget.prefixIcon,
      suffixIcon: IconButton(
        icon: const Icon(Icons.watch_later_outlined),
        onPressed: () async {
          showPicker(context);
        },
      ),
      onTap: () async {
        showPicker(context);
      },
    );
  }
}

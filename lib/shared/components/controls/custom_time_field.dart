import 'package:flutter/material.dart';
import 'package:tasks_local_database/shared/components/controls/custom_input_field.dart';

class CustomTimeField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final bool isDense;
  final TimeOfDay? chosenTimeOfDay;

  const CustomTimeField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.prefixIcon,
    this.isDense = false,
    this.chosenTimeOfDay,
  }) : super(key: key);

  @override
  State<CustomTimeField> createState() => _CustomTimeFieldState();
}

class _CustomTimeFieldState extends State<CustomTimeField> {
  TimeOfDay chosenTimeOfDay = TimeOfDay.now();

  @override
  void initState() {
    super.initState();

    chosenTimeOfDay = widget.chosenTimeOfDay ?? chosenTimeOfDay;
  }

  void showPicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: chosenTimeOfDay,
    ).then((value) {
      setState(() {
        if (value != null) {
          chosenTimeOfDay = value;
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

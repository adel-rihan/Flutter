import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasks_local_database/shared/components/controls/custom_input_field.dart';

class CustomDateField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final bool isDense;
  final DateTime? chosenDateTime;

  const CustomDateField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.prefixIcon,
    this.isDense = false,
    this.chosenDateTime,
  }) : super(key: key);

  @override
  State<CustomDateField> createState() => _CustomDateFieldState();
}

class _CustomDateFieldState extends State<CustomDateField> {
  DateTime chosenDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    chosenDateTime = widget.chosenDateTime ?? chosenDateTime;
  }

  void showPicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: chosenDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    ).then((value) {
      setState(() {
        if (value != null) {
          chosenDateTime = value;
          widget.controller.text = DateFormat.yMMMd().format(value);
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
        icon: const Icon(Icons.calendar_month_outlined),
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

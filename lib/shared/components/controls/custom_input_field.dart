import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool hint;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final bool isDense;
  late List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final void Function(String)? onChange;
  final void Function()? onTap;
  final void Function(String)? onSubmit;
  final TextInputType? textType;
  final int? maxLength;
  final bool readOnly;

  CustomInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.hint = false,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.isDense = false,
    this.inputFormatters,
    this.obscureText = false,
    this.onChange,
    this.onTap,
    this.onSubmit,
    this.textType,
    this.maxLength = TextField.noMaxLength,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: (widget.obscureText && _obscureText),
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        border: widget.hint ? InputBorder.none : const OutlineInputBorder(),
        isDense: widget.isDense,
        labelText: widget.hint ? null : widget.labelText,
        hintText: widget.hint ? widget.labelText : null,
        hintStyle: const TextStyle(fontSize: 14),
        labelStyle: const TextStyle(fontSize: 16),
        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        counterText: '',
        prefixIcon: (widget.prefixIcon != null)
            ? Icon(
                widget.prefixIcon,
              )
            : null,
        suffixIcon: widget.obscureText
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: Icon(
                      _obscureText ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ],
              )
            : (widget.suffixIcon != null)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      widget.suffixIcon!,
                    ],
                  )
                : null,
      ),
      onChanged: widget.onChange,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onSubmit,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.textType,
      maxLength: widget.maxLength,
      maxLines: 1,
      readOnly: widget.readOnly,
    );
  }
}

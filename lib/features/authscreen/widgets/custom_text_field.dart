import 'package:flutter/material.dart';
import '../../../constants.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.validator,
    this.onChanged,
    this.text,
    this.iconData,
    this.isPassword = false,
  });

  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String? text;
  final IconData? iconData;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          obscureText: widget.isPassword ? obscureText : false,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: widget.text,
            hintStyle: TextStyle(
              color: kSecondaryColor
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: kSecondaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  )
                : Icon(widget.iconData, color: kSecondaryColor),
            border: buildBorder(),
            enabledBorder: buildBorder(),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryColor),
      borderRadius: BorderRadius.circular(14),
    );
  }
}

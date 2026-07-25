// Input Field Widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isPassword;
  bool isObscure;

  final bool isEmail;
  final bool isPhone;

  final void Function(String)? submit;
  final void Function(String)? onchange;
  final String? Function(String?)? validator;
  final String? hint;
  final TextEditingController? mycontroller;
  final bool readOnly;

  InputField({
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.isObscure = false,
    this.isEmail = false,
    this.isPhone = false,
    this.submit,
    this.onchange,
    this.hint,
    this.validator,
    this.mycontroller,
    this.readOnly = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      onFieldSubmitted: widget.submit,
      onChanged: widget.onchange,
      controller: widget.mycontroller,
      readOnly: widget.readOnly,
      keyboardType: widget.isEmail
          ? TextInputType.emailAddress
          : widget.isPhone
          ? TextInputType.phone
          : TextInputType.text,
      obscureText: widget.isObscure,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: widget.hint ?? "  ",
        alignLabelWithHint: true,
        labelText: widget.label,
        labelStyle: TextStyle(fontSize: 14.sp, color: Colors.indigo[900]),
        prefixIcon: Icon(widget.icon, size: 20.sp),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  widget.isObscure ? Icons.visibility_off : Icons.visibility,
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    widget.isObscure = !widget.isObscure;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }
}

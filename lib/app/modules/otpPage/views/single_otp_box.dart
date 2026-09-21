import 'package:flutter/material.dart';
import 'package:iecc/constraints/app_colors.dart';

class SingleOTPBox extends StatelessWidget {
  final bool? isLast;

  // VoidCallback onCompleted(String);
  final void Function(String?) onCompleted;
  final TextEditingController? controller;
  final bool? isEnabled;

  const SingleOTPBox(
      {this.isLast,
      this.isEnabled,
      required this.onCompleted,
      this.controller,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextFormField(
        enabled: isEnabled,
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        onChanged: (value) {
          if (value != "") {
            onCompleted(value);
            if (!(isLast ?? false)) {
              FocusScope.of(context).nextFocus();
            }
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.inactiveColor),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.inactiveColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.levelTextColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }
}

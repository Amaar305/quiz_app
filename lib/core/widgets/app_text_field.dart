import 'package:flutter/material.dart';
import 'package:quiz_app/core/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.validator,
    this.controller,
    this.textInputType,
    required this.label,
    this.maxLine,
    this.maxLength,
  });
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final String label;
  final int? maxLine, maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.whiteColor),
        ),
        TextFormField(
          controller: controller,
          maxLength: maxLength,
          maxLines: maxLine,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.greyColor),
            ),
          ),
          keyboardType: textInputType,
          validator: validator,
        ),
      ],
    );
  }
}

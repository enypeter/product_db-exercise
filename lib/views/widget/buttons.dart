import 'package:flutter/material.dart';
import 'package:payble_flutter_test/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton(
      {Key? key,
      this.onTap,
      required this.title,
      this.color = AppColors.primaryColor})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class TransparentButton extends StatelessWidget {
  const TransparentButton(
      {Key? key,
      this.onTap,
      required this.title,
      this.color = AppColors.primaryColor})
      : super(key: key);
  final String title;
  final void Function()? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: color, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}

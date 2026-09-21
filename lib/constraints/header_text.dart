
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class HeaderText extends StatelessWidget {
  final String text;
 final TextAlign align;
  final Color? color;
  final int maxLine;
  final double size;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
   const HeaderText({super.key,
    required this.text,
    this.color=const Color(0xFF000000),
    this.size=16,
    this.textOverflow=TextOverflow.ellipsis,
    this.fontWeight=FontWeight.w600,
    this.align=TextAlign.center,
    this.maxLine=1,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLine,
      overflow: textOverflow,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
      ),
    );
  }
}
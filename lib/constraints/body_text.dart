import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final Color? color;
  final double size;
  final int maxLine;
  final TextOverflow textOverflow;
  final FontWeight fontWeight;
  final bool resizeAble;

  const BodyText({
    super.key,
    required this.text,
    this.color = const Color(0xff4F4F4F),
    this.size=12,
    this.textOverflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w400,
    this.align = TextAlign.center,
    this.maxLine = 3,
    this.resizeAble=true,
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
        fontSize: resizeAble?size.sp:size,
        fontWeight: fontWeight,
      ),
    );
  }
}

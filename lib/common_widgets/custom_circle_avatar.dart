import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iecc/constraints/app_colors.dart';

import 'custom_network_image.dart';

class CustomCircleAvatar extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String? svgNetworkImage;
  final String? localImage;
  final double? radius;
  final double? border;
  final BoxFit? fit;
  final Color? bgColor;

  const CustomCircleAvatar(
      {required this.width,
      required this.height,
      required this.image,
        this.svgNetworkImage,
      this.localImage,
      this.radius,
      this.border,
        this.fit,
        this.bgColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  bgColor??AppColors.secondaryLightColor,
      ),
      padding: EdgeInsets.all(border??0),
      child: Container(
       // padding:  EdgeInsets.all(border??0),
        clipBehavior: Clip.hardEdge,
        height: height,
        width: width,
        decoration: radius == null
            ?  BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor??AppColors.secondaryLightColor,
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(radius!),
                color: bgColor??AppColors.secondaryLightColor,
              ),
        child:svgNetworkImage!=null
            ?SvgPicture.network(svgNetworkImage??"",fit: fit??BoxFit.cover,)
            : CustomNetworkImage(
          image: image,
          localImage: localImage,
          fit:fit
        ),
      ),
    );
  }
}

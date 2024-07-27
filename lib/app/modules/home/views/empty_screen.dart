import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/home/controllers/home_controller.dart';
import 'package:iecc/constraints/header_text.dart';

class EmptyScreen extends GetView<HomeController> {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child:Column(
          children: [
            SizedBox(height:32.h// AppDimensions.sectionPaddingVer,
            ),
            const HeaderText(text: "You currently have no student added.",),
            SizedBox(height:16.h// AppDimensions.widgetPaddingVer,
            ),
            const Divider(thickness: .5,)
          ],
        ),)
      ],
    );
  }
}

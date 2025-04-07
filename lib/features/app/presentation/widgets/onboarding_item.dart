// import 'package:flutter/material.dart';
// import 'package:chat_master/core/extensions/size.dart';
// import 'package:chat_master/core/utils/app_colors.dart';
// import 'package:chat_master/core/extensions/translate.dart';
// import 'package:chat_master/features/app/data/models/on_boarding_model.dart';

// class OnBoardingItem extends StatelessWidget {
//   final OnBoardingModel model;
//   const OnBoardingItem({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100.w,
//       height: 70.h,
//       alignment: Alignment.bottomCenter,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.fitHeight,
//           image: AssetImage(model.img),
//         ),
//       ),
//       child: Container(
//         width: 100.w,
//         height: 26.h,
//         padding: EdgeInsets.all(4.r),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(3.h),
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 3.h),
//             Text(
//               model.title.tr,
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//             SizedBox(height: 3.h),
//             Text(
//               model.body.tr,
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Image.asset(
            AppAssets.emptyAnimation,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
        Text(
          "There is No Contacts Added Here",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: AppColors.accentColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
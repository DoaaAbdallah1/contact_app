import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/user_model.dart';

class WidgetItemUser extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;
  final VoidCallback onDel;
  const WidgetItemUser({
    super.key,
    required this.user,
    required this.onTap,
    required this.onDel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.accentColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          spacing: 10,
          children: [
            Stack(
              alignment: .bottomStart,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: user.photoUrl.startsWith('assets/')
                      ? Image.asset(
                          user.photoUrl,
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        )
                      : Image.file(
                          File(user.photoUrl),
                          fit: BoxFit.cover,
                          height: 170,
                          width: double.infinity,
                        ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    user.name,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: .w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                spacing: 4,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.email, size: 20,color: AppColors.primaryColor,),
                      Text(
                        user.email,
                        style: TextStyle(fontSize: 10,color: AppColors.primaryColor, fontWeight: .w500),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 10,
                    children: [
                      Icon(Icons.phone, size: 20,color: AppColors.primaryColor,),
                      Text(
                        user.phone,
                        style: TextStyle(fontSize: 10,color: AppColors.primaryColor, fontWeight: .w500),
                      ),
                    ],
                  ),

                  ElevatedButton(
                    onPressed: onDel,
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 8),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xffF93E3E),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.delete, color: AppColors.white),
                        Text(
                          "Delete",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: .w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

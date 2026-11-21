import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/user_model.dart';
import 'text_field_custom.dart';

class UserFormSheet extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String? initialImage;
  final ValueChanged<UserModel> onAddUser;
  final bool isEdit;
  final ValueChanged<UserModel>? onUpdateUser;
  const UserFormSheet({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.onAddUser,
    this.isEdit = false,
    this.initialImage,
    this.onUpdateUser,
  });

  @override
  State<UserFormSheet> createState() => _UserFormSheetState();
}

class _UserFormSheetState extends State<UserFormSheet> {
  File? selectedImage;

  final ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = selectedImage?.path ?? widget.initialImage;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 10,
            children: [
              SizedBox(
                height: 146,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 10,
                  children: [
                    GestureDetector(
                      onTap: pickImage,
                      child: Container(
                        width: 146,
                        height: 146,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.accentColor),
                          image: imagePath != null
                              ? DecorationImage(
                                  image: imagePath.startsWith('assets/')
                                      ? AssetImage(imagePath)
                                      : FileImage(File(imagePath)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: imagePath == null
                            ? Lottie.asset(AppAssets.imagePickerAnimation)
                            : null,
                      ),
                    ),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: .spaceAround,
                        crossAxisAlignment: .start,
                        children: [
                          Text(
                            widget.nameController.text.isEmpty
                                ? "User Name"
                                : widget.nameController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentColor,
                              overflow: .ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Divider(color: AppColors.accentColor, height: 5),
                          Text(
                            widget.emailController.text.isEmpty
                                ? "example@email.com"
                                : widget.emailController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentColor,
                              overflow: .ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Divider(color: AppColors.accentColor, height: 5),

                          Text(
                            widget.phoneController.text.isEmpty
                                ? "+2000000000"
                                : widget.phoneController.text,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentColor,
                              overflow: .ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0),
              TextFieldCustom(
                controller: widget.nameController,
                hintText: "Enter User Name",
              ),
              TextFieldCustom(
                controller: widget.emailController,
                hintText: "Enter User Email",
              ),
              TextFieldCustom(
                controller: widget.phoneController,
                hintText: "Enter User Phone",
              ),
              SizedBox(height: 1),
              ElevatedButton(
                onPressed: () {
                  if (widget.nameController.text.trim().isEmpty ||
                      widget.emailController.text.trim().isEmpty ||
                      widget.phoneController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill in all fields"),
                      ),
                    );
                    return;
                  }

                  final user = UserModel(
                    name: widget.nameController.text.trim(),
                    email: widget.emailController.text.trim(),
                    phone: widget.phoneController.text.trim(),
                    photoUrl:
                        selectedImage?.path ??
                        widget.initialImage ??
                        'assets/images/splash_screen.png',
                  );

                  if (widget.isEdit) {
                    widget.onUpdateUser?.call(user);
                  } else {
                    widget.onAddUser(user);
                  }

                  widget.nameController.clear();
                  widget.emailController.clear();
                  widget.phoneController.clear();

                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 12),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    AppColors.accentColor,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: Text(
                  "Enter User",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: .w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

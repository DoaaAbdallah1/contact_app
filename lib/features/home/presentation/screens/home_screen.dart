import 'package:contact_app/core/constants/app_assets.dart';
import 'package:contact_app/core/constants/app_colors.dart';
import 'package:contact_app/features/home/presentation/widgets/widget_item_user.dart';
import 'package:flutter/material.dart';

import '../../data/models/user_model.dart';
import '../widgets/empty_list.dart';
import '../widgets/user_form_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<UserModel> users = [];
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            Visibility(
              visible: users.isNotEmpty,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    users.removeLast();
                  });

                  nameController.clear();
                  emailController.clear();
                  phoneController.clear();
                },
                backgroundColor: Color(0xffF93E3E),
                child: Icon(
                  Icons.delete,
                  color: AppColors.accentColor,
                  size: 24,
                ),
              ),
            ),

            Visibility(
              visible: users.length < 6,
              child: FloatingActionButton(
                onPressed: () {
                  nameController.clear();
                  emailController.clear();
                  phoneController.clear();

                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return UserFormSheet(
                        onAddUser: (value) {
                          setState(() {
                            users.add(value);
                          });
                        },
                        nameController: nameController,
                        emailController: emailController,
                        phoneController: phoneController,
                      );
                    },
                  );
                },
                backgroundColor: AppColors.accentColor,
                child: Icon(Icons.add, color: AppColors.primaryColor, size: 24),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
          child: Column(
            spacing: 10,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(AppAssets.logo, width: 117, height: 39),
              ),
              Expanded(
                child: users.isEmpty
                    ? const EmptyList()
                    : GridView.builder(
                        //  physics: NeverScrollableScrollPhysics(),
                        itemCount: users.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.6,
                            ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom:
                                  (users.length - 1 == index ||
                                          users.length - 2 == index) &&
                                      (users.length % 2 == 0 &&
                                          users.length > 2)
                                  ? 16:  (users.length - 1 == index 
                                          ) &&
                                      (users.length % 2 == 1 &&
                                          users.length > 2)? 16: 0,
                                
                            ),
                            child: WidgetItemUser(
                              user: users[index],
                              onTap: () {
                                final selectedUser = users[index];

                                nameController.text = selectedUser.name;
                                emailController.text = selectedUser.email;
                                phoneController.text = selectedUser.phone;

                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  useSafeArea: true,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) {
                                    return UserFormSheet(
                                      nameController: nameController,
                                      emailController: emailController,
                                      phoneController: phoneController,
                                      isEdit: true,
                                      initialImage: selectedUser.photoUrl,
                                      onAddUser: (value) {},
                                      onUpdateUser: (updatedUser) {
                                        setState(() {
                                          users[index] = updatedUser;
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              onDel: () {
                                users.removeAt(index);
                                setState(() {});
                              },
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

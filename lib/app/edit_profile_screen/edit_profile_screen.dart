import 'dart:io';

import 'package:air_menu_ai_app/constant/constant.dart';
import 'package:air_menu_ai_app/controllers/edit_profile_controller.dart';
import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/responsive.dart';
import 'package:air_menu_ai_app/themes/round_button_fill.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:air_menu_ai_app/utils/network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final HomeController homeController = Get.find();
  final EditProfileController editProfileController = Get.put(
    EditProfileController(),
  );

  @override
  void initState() {
    editProfileController.nameController.value.text =
        homeController.userData.value.data?.name ?? "";
    editProfileController.phoneNumberController.value.text =
        homeController.userData.value.data?.phone ?? "";
    editProfileController.emailController.value.text =
        homeController.userData.value.data?.email ?? "test@gmail.com";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor:
            themeChange.getThem()
                ? AppThemeData.surfaceDark
                : AppThemeData.surface,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Profile Information".tr,
                style: TextStyle(
                  fontSize: 24,
                  color:
                      themeChange.getThem()
                          ? AppThemeData.grey50
                          : AppThemeData.grey900,
                  fontFamily: AppThemeData.semiBold,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "View and update your personal details, contact information, and preferences."
                    .tr,
                style: TextStyle(
                  fontSize: 16,
                  color:
                      themeChange.getThem()
                          ? AppThemeData.grey50
                          : AppThemeData.grey900,
                  fontFamily: AppThemeData.regular,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    Obx(
                      () =>
                          homeController.userData.value.data?.img == null
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  Constant.userPlaceHolder,
                                  height: Responsive.width(24, context),
                                  width: Responsive.width(24, context),
                                  fit: BoxFit.cover,
                                ),
                              )
                              : editProfileController
                                  .profileImage
                                  .value
                                  .isNotEmpty
                              ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.file(
                                  File(
                                    editProfileController.profileImage.value,
                                  ),
                                  height: Responsive.width(24, context),
                                  width: Responsive.width(24, context),
                                  fit: BoxFit.cover,
                                ),
                              )
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: NetworkImageWidget(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      homeController.userData.value.data?.img ??
                                      "",
                                  height: Responsive.width(24, context),
                                  width: Responsive.width(24, context),
                                  errorWidget: Image.asset(
                                    Constant.userPlaceHolder,
                                    fit: BoxFit.cover,
                                    height: Responsive.width(24, context),
                                    width: Responsive.width(24, context),
                                  ),
                                ),
                              ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          buildBottomSheet(context, editProfileController);
                        },
                        child: SvgPicture.asset("assets/icons/ic_edit.svg"),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFieldWidget(
                title: 'Name'.tr,
                controller: editProfileController.nameController.value,
                hintText: 'Name'.tr,
              ),
              TextFieldWidget(
                title: 'Email'.tr,
                textInputType: TextInputType.emailAddress,
                controller: editProfileController.emailController.value,
                hintText: 'Email'.tr,
              ),
              TextFieldWidget(
                title: 'Phone Number'.tr,
                textInputType: TextInputType.emailAddress,
                controller: editProfileController.phoneNumberController.value,
                hintText: 'Phone Number'.tr,
                enable: false,
              ),
              SizedBox(height: 50),
              Container(
                color:
                    themeChange.getThem()
                        ? AppThemeData.grey900
                        : AppThemeData.grey50,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Obx(
                    () =>
                        editProfileController.isProfile.value
                            ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 1,
                                color: AppThemeData.primary300,
                              ),
                            )
                            : RoundedButtonFill(
                              title: "Save Details".tr,
                              height: 5.5,
                              color: AppThemeData.primary300,
                              textColor: AppThemeData.grey50,
                              fontSizes: 16,
                              onPress: () async {
                                Map<String, dynamic> body = {
                                  "name":
                                      editProfileController
                                          .nameController
                                          .value
                                          .text,
                                  "img":
                                      editProfileController
                                              .profileImageUrl
                                              .value
                                              .isEmpty
                                          ? (homeController
                                                  .userData
                                                  .value
                                                  .data
                                                  ?.img ??
                                              "")
                                          : editProfileController
                                              .profileImageUrl
                                              .value,
                                  "email":
                                      editProfileController
                                          .emailController
                                          .value
                                          .text,
                                };
                                editProfileController
                                    .updateUser(body: body)
                                    .then((value) {
                                      homeController.getUserDetail();
                                    });
                              },
                            ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBottomSheet(BuildContext context, EditProfileController controller) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: Responsive.height(22, context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "please select".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  () => controller.pickFile(
                                    source: ImageSource.camera,
                                  ),
                              icon: const Icon(Icons.camera_alt, size: 32),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "camera".tr,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed:
                                  () => controller.pickFile(
                                    source: ImageSource.gallery,
                                  ),
                              icon: const Icon(
                                Icons.photo_library_sharp,
                                size: 32,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "gallery".tr,
                                style: const TextStyle(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

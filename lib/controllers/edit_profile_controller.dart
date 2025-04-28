import 'dart:convert';
import 'dart:io';

import 'package:air_menu_ai_app/constant/show_toast_dialog.dart';
import 'package:air_menu_ai_app/models/user_model.dart';
import 'package:air_menu_ai_app/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = true.obs;

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> countryCodeController =
      TextEditingController(text: "+91").obs;

  final ImagePicker _imagePicker = ImagePicker();
  RxString profileImage = "".obs;
  RxString profileImageUrl = "".obs;
  RxBool isProfile = false.obs;

  Future<UserModel> updateUser({required Map<String, dynamic> body}) async {
    try {
      isProfile.value = true;
      UserModel user = await HomeService.updateUser(body: body);
      isProfile.value = false;
      if (user.success == true) {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      } else {
        ShowToastDialog.showToast(
          user.message,
          position: EasyLoadingToastPosition.bottom,
        );
      }
      return user;
    } catch (e, st) {
      print("st--->>>${st}");
      isProfile.value = false;
    } finally {}
    return UserModel();
  }

  Future pickFile({required ImageSource source}) async {
    try {
      XFile? image = await _imagePicker.pickImage(source: source);
      if (image == null) return;
      Get.back();
      profileImage.value = image.path;
      _uploadImage(File(image.path));
    } on PlatformException catch (e) {
      ShowToastDialog.showToast("${"failed_to_pick".tr} : \n $e");
    }
  }

  Future<void> _uploadImage(File imageFile) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/ddompy9e4/upload');
    final request = http.MultipartRequest('POST', uri);
    request.fields['upload_preset'] = "maurishxsyma";
    request.files.add(
      await http.MultipartFile.fromPath('file', imageFile.path),
    );
    final response = await request.send();
    print("response.statusCode--->>>${response.statusCode}");
    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final data = json.decode(responseData);
      final imageUrl = data['secure_url'];
      profileImageUrl.value = imageUrl;
      print('Image URL: $imageUrl');
    } else {
      ShowToastDialog.showToast(
        position: EasyLoadingToastPosition.bottom,
        "Image upload failed",
      );
    }
  }
}

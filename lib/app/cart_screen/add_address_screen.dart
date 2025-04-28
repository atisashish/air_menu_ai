import 'package:air_menu_ai_app/controllers/home_controller.dart';
import 'package:air_menu_ai_app/themes/app_them_data.dart';
import 'package:air_menu_ai_app/themes/round_button_fill.dart';
import 'package:air_menu_ai_app/themes/text_field_widget.dart';
import 'package:air_menu_ai_app/utils/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddAddressForm extends StatelessWidget {
  AddAddressForm({super.key});

  final HomeController homeController = Get.find();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Add Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Obx(
                  () => TextFieldWidget(
                    fillColor: Colors.grey.withOpacity(0.1),
                    title: 'Name',
                    hintText: 'Enter Name',
                    controller: homeController.nameController.value,
                    prefix: Icon(
                      Icons.person_outline,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => TextFieldWidget(
                    fillColor: Colors.grey.withOpacity(0.1),
                    title: 'Street',
                    hintText: 'Enter street',
                    controller: homeController.streetController.value,
                    prefix: Icon(
                      Icons.location_on_outlined,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Street cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => TextFieldWidget(
                    fillColor: Colors.grey.withOpacity(0.1),
                    title: 'City',
                    hintText: 'Enter city',
                    controller: homeController.cityController.value,
                    prefix: Icon(
                      Icons.location_city_outlined,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'City cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => TextFieldWidget(
                    fillColor: Colors.grey.withOpacity(0.1),
                    title: 'State',
                    hintText: 'Enter state',
                    controller: homeController.stateController.value,
                    prefix: Icon(
                      Icons.map_outlined,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'State cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                Obx(
                  () => TextFieldWidget(
                    fillColor: Colors.grey.withOpacity(0.1),
                    title: 'Zip Code',
                    hintText: 'Enter zip code',
                    controller: homeController.zipCodeController.value,
                    textInputType: TextInputType.number,
                    prefix: Icon(
                      Icons.pin_outlined,
                      color:
                          themeChange.getThem()
                              ? AppThemeData.grey50
                              : AppThemeData.grey900,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Zip Code cannot be empty';
                      } else if (value.length != 6) {
                        return 'Zip Code must be 6 digits';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                RoundedButtonFill(
                  title: "Save Address".tr,
                  textColor: Colors.white,
                  color: AppThemeData.primary300,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Get.back();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/driver_type.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';
import '../../routes/app_pages.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  var hidePassword = true.obs;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imagePath;
  List<DriverType> types = <DriverType>[].obs;
  var loading = false.obs;
  late Rxn<XFile> image = Rxn();
  DriverType? selectedType;
  var otpSending = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDriverTypes();
  }

  onChangeDropdownTypeItem(DriverType type) {
    selectedType = type;
  }

  void passwordToggle() {
    hidePassword.value = !hidePassword.value;
  }

  void requestRegister() async {
    try {
      await AuthRepository.instance
          .requestRegister(
        phoneController.value.text,
      )
          .then(
        (value) {
          Get.toNamed(Routes.SIGNUPOTP);
        },
      ).catchError(
        (onError) {
          print('error ::: ${onError.type} ');
        },
      );
    } catch (e) {}
  }

  void confirmRegisterVerification() async {
    otpSending.value = true;
    update();

    try {
      await AuthRepository.instance
          .confirmRegisterVerification(
        phoneNumber: phoneController.value.text,
        otp: otpController.value.text,
      )
          .then(
        (token) async {
          register(token: token);
        },
      ).catchError((onError) async {
        print('error ::: ${onError.type} ');
      });
    } catch (e) {}
  }

  void register({required String token}) async {
    try {
      await AuthRepository.instance
          .signUp(
        token: token,
        email: emailController.value.text,
        name: nameController.value.text,
        password: passwordController.value.text,
        driverTypeId: selectedType!.id!,
      )
          .then(
        (value) async {
          Get.toNamed(Routes.LOGIN);
          // if (value is User) {
          // if (value.id != null) goHome();
          // }
        },
      ).catchError((onError) async {
        print('error ::: ${onError.type} ');
      });
    } catch (e) {}
  }

  getImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        update();
      }
    } catch (e) {
      // _pickImageError = e;

    }
  }

  getDriverTypes() async {
    types = await AuthRepository.instance.getDriverTypes();
    selectedType = types[0];
    update();
  }

  void goHome() {
    Get.offAllNamed(Routes.HOME);
  }
}

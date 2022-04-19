import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/driver_type.dart';
import '../../data/repositories/auth_repository.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var hidePassword = true.obs;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imagePath;
  List<DriverType> types = <DriverType>[].obs;

  late Rxn<XFile> image = Rxn();
  DriverType? selectedType;

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

  register() async {}

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
    print('$types types gotten in controller');
    update();
  }
}

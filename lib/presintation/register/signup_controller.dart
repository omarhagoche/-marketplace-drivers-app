import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/driver_type.dart';

class SignupController extends GetxController {

  final formKey = GlobalKey<FormBuilderState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var hidePassword = true.obs;
  final ImagePicker _picker = ImagePicker();
  File? imageFile;
  String? imagePath;
  RxList<DriverType> types = <DriverType>[].obs;

  late Rxn<XFile> image = Rxn();
  Rxn<DriverType>? selectedType = Rxn();

  onChangeDropdownTypeItem(DriverType type) {
    selectedType?.value = type;
  }

  void passwordToggle(){
    hidePassword.value = !hidePassword.value;
  }


  register() async {

  }

  getImageFromGallery() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,

      );
      if(pickedFile != null) {
        print("dataaaa : start");

        imagePath = pickedFile.path;
        imageFile = File(pickedFile.path);
        print("image path  : ${imagePath}");


      }

    } catch (e) {
      // _pickImageError = e;

    }

  }

}
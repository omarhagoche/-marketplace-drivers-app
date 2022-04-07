import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/order.dart';
import '../../data/models/statistic.dart';
import '../../data/models/user.dart';
import '../../data/repositories/user_repository.dart';

class ProfileController extends GetxController {
  Rxn<User> user = Rxn();
  RxList<Order> recentOrders = <Order>[].obs;
  var driverState = false.obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Rxn<Statistics> statistics = Rxn();
  Rxn<OverlayEntry?> loader = Rxn();
  final ImagePicker picker = ImagePicker();
  Rxn<File> image = Rxn();
  var imagePath = ''.obs;
  late Rxn<XFile> profilePhoto = Rxn();


  @override
  void onInit() {
    getUserInfo();
    driverStatistics();
    super.onInit();
  }

  uploadProfileImage(){
    if (profilePhoto.value != null) {
      UserRepository.instance.updateImage(image: profilePhoto.value!).then((value) {
        if(value) {
          ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
            content: Text('تم تحميل الصورة بنجاح'),
          ));
        }
      });

    } else {
      print('No image selected.');
    }
  }

  void imgFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null) {
        image.value = File(pickedFile.path);
        imagePath.value = pickedFile.path;
        profilePhoto.value = pickedFile;
        uploadProfileImage();
      }
    } catch (e) {}
  }

  void imgFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      if (pickedFile != null) {
        profilePhoto.value = pickedFile;
        image.value = File(pickedFile.path);
        imagePath.value = pickedFile.path;
        uploadProfileImage();
      }else{
        print('image path : $imagePath');

      }
    } catch (e) {
      // _pickImageError = e;
      print('image path : $e');

    }
  }
  void updateDriverState(driverState) {

    try {
      // toggleState();
      UserRepository.instance.updateDriverAvailable(driverState).then((value) {
        if(!value){
          driverState.value = false;
          update();

        }
      });
    } catch (e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text('حدث خطأ ما !'),
      ));
    }
  }

  void getUserInfo() async {
    UserRepository.instance.userProfile().then((value) async {
      user.value = value;
      driverState.value = user.value?.driver?.available ?? false;
    });
  }

  void toggleState(){
    driverState.value = !driverState.value;
  }

  void driverStatistics() async {
    UserRepository.instance.driverStatistics().then((value) async {
      print('driverStatistics ... . $value}');
      statistics.value = value;
      print('statistics .. ${statistics}');
    });
  }

}

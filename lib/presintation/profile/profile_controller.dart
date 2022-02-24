import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/order.dart';
import '../../data/models/statistic.dart';
import '../../data/models/user.dart';

class ProfileController extends GetxController {

  Rxn<User> user = Rxn();
  RxList<Order> recentOrders = <Order>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Rxn<Statistics> statistics = Rxn();
  Rxn<OverlayEntry?> loader = Rxn();
  final ImagePicker picker = ImagePicker();
  File? image;

  void updateDriverState(driverState) {
    try {


    } catch (e) {
      ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(SnackBar(
        content: Text('حدث خطأ ما !'),
      ));
    }
  }

  @override
  void onInit() {
    // listenForUser();
    // listenForStatistics();
    //listenForRecentOrders();
    super.onInit();
  }

  void imgFromCamera() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,

      );
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    } catch (e) {
      // _pickImageError = e;

    }
  }

  void imgFromGallery() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,

      );
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    } catch (e) {
      // _pickImageError = e;

    }
  }
}
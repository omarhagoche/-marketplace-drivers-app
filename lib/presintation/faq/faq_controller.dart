import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/faq_category.dart';
import '../../data/repositories/faq_repository.dart';
class FaqController extends GetxController {
  final faqs = <FaqCategory>[].obs;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void onInit() {
    listenForFaqs();
    super.onInit();
  }

  void listenForFaqs({String? message}) async {
    try {
      final List<FaqCategory> _faq = await FaqCategoryRepository.instance.getFaqCategories();
      faqs.assignAll(_faq);
      if (message != null) {
        Get.snackbar('', message);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> refreshFaqs() async {
    faqs.clear();
    listenForFaqs(message: 'Faqs_refreshed_successfully'.tr);
  }
}

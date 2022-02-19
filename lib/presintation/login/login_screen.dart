import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../widgets/text_field.dart';
import 'login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FormBuilder(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldPlus(
                      formKey: controller.formKey,
                      name: '',
                      text: '',
                      controller: controller.nameController,
                      //validator: FormBuilderValidators.required(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      onPressed: () =>
                          Get.toNamed(Routes.FORGET_USERNAME),
                      child: const Text(
                        'هل نسيت اسم المستخدم؟',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFieldPlus(
                      formKey: controller.formKey,
                      name: 'كلمة المرور',
                      text: 'password',
                      controller: controller.passwordController,
                      //validator: FormBuilderValidators.required(context),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      onPressed: () =>
                          Get.toNamed(Routes.FORGET_PASSWORD),
                      child: const Text('هل نسيت كلمة المرور؟'),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),
    );
  }
}
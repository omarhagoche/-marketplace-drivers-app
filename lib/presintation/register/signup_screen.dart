import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/utils/helper.dart';
import '../widgets/block_button.dart';
import 'signup_controller.dart';
import 'package:get/get.dart';
import '../../core/values/app_config.dart' as config;

class SignupScreen extends GetView<SignupController> {
  const SignupScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       // key: _con.scaffoldKey,
        body: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(height: MediaQuery.of(context).size.height,),
              Positioned(
                top: 0,
                child: Container(
                  width: config.App(context).appWidth(100),
                  height: config.App(context).appHeight(29.5),
                  decoration: BoxDecoration(color: Theme.of(context).accentColor),
                ),
              ),
              Positioned(
                top: config.App(context).appHeight(29.5) - 100,
                child: Container(
                  width: config.App(context).appWidth(84),
                  height: config.App(context).appHeight(29.5),
                  child: Text(
                    'lets_start_with_register'.tr,
                    style: Theme.of(context).textTheme.headline4!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                ),
              ),
              Positioned(
                top: config.App(context).appHeight(29.5) - 50,
                child: Container(
                  decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                    BoxShadow(
                      blurRadius: 50,
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 27),
                  width: config.App(context).appWidth(88),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 130,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  controller.imageFile != null
                                      ? ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(300)),
                                    child: Image.file(
                                      controller.imageFile!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(300)),
                                    child: CachedNetworkImage(
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                      imageUrl: 'https://cp.sabek.app/images/image_default.png',
                                      placeholder: (context, url) => Image.asset(
                                        'assets/img/loading.gif',
                                        fit: BoxFit.cover,
                                        height: 120,
                                        width: 120,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),

                                  Positioned(
                                    right: 1,
                                    bottom: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius: BorderRadius.all(Radius.circular(50)),
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                        onPressed: () => controller.getImageFromGallery() //_showPicker(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: controller.nameController,
                          //onSaved: (input) => _con.user.name = input,
                          validator: (input) => input!.length < 3 ? 'should_be_more_than_3_letters'.tr : null,
                          decoration: InputDecoration(
                            labelText: 'full_name'.tr,
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'john_doe'.tr,
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 30),
                        Obx(
                            () => DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                                // labelText: labelText,
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Color(0XFF5CAA95).withOpacity(.38))),
                              ),
                              value: controller.selectedType,
                              items: controller.types.map(
                                    (item) {
                                  return DropdownMenuItem(
                                    value: item,
                                    child: new Text(item.name!),
                                  );
                                },
                              ).toList(),
                              isExpanded: true,
                              validator: (value) => value == null
                                  ? 'الرجاء اختيار نوع المركبة'
                                  : null,
                              hint: Text('الرجاء اختيار نوع المركبة'),
                              onChanged: (value) {
                                // _con.user.id=value.id as String;
                                // _con.onChangeDropdownTypeItem(value);
                              },
                            )
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: controller.emailController,
                          validator: EmailValidator(errorText: 'not_a_valid_email'.tr),
                          decoration: InputDecoration(
                            labelText: 'email'.tr,
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: 'me@gmail.com',
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          obscureText: controller.hidePassword.value,
                          controller: controller.passwordController,
                         // onSaved: (input) => _con.user.password = input,
                          validator: (input) => input!.length < 6 ? 'should_be_more_than_6_letters'.tr : null,
                          decoration: InputDecoration(
                            labelText: 'password'.tr,
                            labelStyle: TextStyle(color: Theme.of(context).accentColor),
                            contentPadding: EdgeInsets.all(12),
                            hintText: '••••••••••••',
                            hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                            prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                            suffixIcon: IconButton(
                              onPressed: () => controller.passwordToggle,
                              color: Theme.of(context).focusColor,
                              icon: Icon(controller.hidePassword.value ? Icons.visibility : Icons.visibility_off),
                            ),
                            border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                          ),
                        ),
                        SizedBox(height: 30),
                        BlockButtonWidget(
                          text: Text(
                            'register'.tr,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () {
                            controller.register();
                          },
                        ),
                        SizedBox(height: 25),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Column(
                  children: <Widget>[

                    FlatButton(
                      onPressed: () {
                        Get.back();
                      },
                      textColor: Theme.of(context).hintColor,
                      child: Text('login'.tr),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  }
}
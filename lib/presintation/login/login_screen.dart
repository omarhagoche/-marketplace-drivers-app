import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../core/utils/helper.dart';
import '../widgets/block_button.dart';
import '../widgets/loading_widget.dart';
import 'login_controller.dart';
import '../../core/values/app_config.dart' as config;

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => WillPopScope(
            onWillPop: Helper.of(context).onWillPop,
            child: Scaffold(
              //key: controller.scaffoldKey,
              resizeToAvoidBottomInset: false,
              body: (controller.loading.value == true) ? Center(child: LoadingWidget(),) :Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      width: config.App(context).appWidth(100),
                      height: config.App(context).appHeight(37),
                      decoration: BoxDecoration(color: Theme.of(context).accentColor),
                    ),
                  ),
                  Positioned(
                    top: config.App(context).appHeight(37) - 120,
                    child: Container(
                      width: config.App(context).appWidth(84),
                      height: config.App(context).appHeight(37),
                      child: Text(
                        'lets_start_with_login'.tr,
                        style: Theme.of(context).textTheme.headline2!.merge(TextStyle(color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                  Positioned(
                    top: config.App(context).appHeight(37) - 50,
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
                      padding: EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
                      width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
                              controller: controller.phoneController,
                              keyboardType: TextInputType.number,
                              // onSaved: (input) => _con.user.phone = input!.substring(1),
                              maxLength: 10,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Please enter phone number"),
                                MinLengthValidator(10,
                                    errorText:
                                    'should_be_more_than_10_letters'.tr),
                                PatternValidator(
                                  r'^(09?(9[0-9]{8}))$',
                                  errorText: 'not_a_valid_phone'.tr,
                                )
                              ]),
                              decoration: InputDecoration(
                                labelText: 'phone'.tr,
                                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: 'phone_ex'.tr,
                                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
                                border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              controller: controller.passwordController,
                              keyboardType: TextInputType.text,
                              //onSaved: (input) => _con.user.password = input,
                              validator: (input) => input!.length < 3 ? 'should_be_more_than_3_characters'.tr : null,
                              obscureText: controller.hidePassword.value,
                              decoration: InputDecoration(
                                labelText: 'password'.tr,
                                labelStyle: TextStyle(color: Theme.of(context).accentColor),
                                contentPadding: EdgeInsets.all(12),
                                hintText: '••••••••••••',
                                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
                                prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.passwordToggle();
                                  },
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
                                'login'.tr,
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                              color: Theme.of(context).accentColor,
                              onPressed: () {
                                controller.login();
                              },
                            ),
                            SizedBox(height: 15),
                            controller.error.value.isNotEmpty ? Center(child: Text(controller.error.value,
                              style: TextStyle(color: Colors.red,fontSize: 16),)) :SizedBox()
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
                          onPressed: ()=> controller.forgetPassword,
                          textColor: Theme.of(context).hintColor,
                          child: Text('i_forgot_password'.tr),
                        ),
                        FlatButton(
                          onPressed: (){
                            controller.signUp();
                           }  ,
                          textColor: Theme.of(context).hintColor,
                          child: Text('i_dont_have_an_account'.tr ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
    );


  }
}
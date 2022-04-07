import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../widgets/block_button.dart';
import '../widgets/loading_widget.dart';
import 'forget_password_controller.dart';
import '../../core/values/app_config.dart' as config;

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
        body: Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    child: Container(
                      width: config.App(context).appWidth(100),
                      height: config.App(context).appHeight(37),
                      decoration:
                          BoxDecoration(color: Theme.of(context).accentColor),
                    ),
                  ),
                  Positioned(
                    top: config.App(context).appHeight(37) - 100,
                    child: Container(
                      width: config.App(context).appWidth(84),
                      height: config.App(context).appHeight(37),
                      child: Text(
                              controller.currentDisplay.value=="inputPhone"
                                  ? 'phoneNumber_forget'.tr + "!"
                                  : "inputOtpCode".tr
                        ,
                          style: Theme.of(context).textTheme.headline4!.merge(
                              TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                    ),
                  ),
                  Positioned(
                      top: config.App(context).appHeight(37) - 50,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 50,
                                color:
                                    Theme.of(context).hintColor.withOpacity(0.2),
                              )
                            ]),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.only(
                            top: 50, right: 27, left: 27, bottom: 20),
                        width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                        child: Form(
                            key: controller.formKey,
                            child:Obx(()=>
                            controller.currentDisplay.value=="otpSending"
                                ? inputOtpWidget(context)
                                : inputPhoneNumberWidget(context)
                            )),
                      )),
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

  Widget inputPhoneNumberWidget(
      BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          controller: controller.phoneController,
          keyboardType: TextInputType.number,
          // onSaved: (input) => _con.user.phone = input!.substring(1),
          maxLength: 10,
          validator: MultiValidator([
            RequiredValidator(errorText: "Please enter phone number"),
            MinLengthValidator(10,
                errorText: 'should_be_more_than_10_letters'.tr),
            PatternValidator(
              r'^(09?(9[0-9]{8}))$',
              errorText: 'not_a_valid_phone'.tr,
            )
          ]),
          decoration: InputDecoration(
            labelText: 'phoneNumber'.tr,
            labelStyle: TextStyle(color: Theme.of(context).accentColor),
            contentPadding: EdgeInsets.all(12),
            hintText: 'phone_ex'.tr,
            hintStyle:
                TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
            prefixIcon: Icon(Icons.phone, color: Theme.of(context).accentColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.5))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).focusColor.withOpacity(0.2))),
          ),
        ),
        SizedBox(height: 30),
        controller.currentDisplay.value=="otpSending"
        ? CircularProgressIndicator()
        : BlockButtonWidget(
            text: Text(
              'send'.tr,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () => controller.sendOtp()),
      ],
    );
  }

  Widget inputOtpWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PinFieldAutoFill(
                codeLength: 4
            ),
            SizedBox(height: 5),
            TextButton(onPressed: (){}, child: Text("reSend".tr,style: TextStyle(color:Theme.of(context).accentColor,fontWeight: FontWeight.bold),)),
          ],
        ),
        SizedBox(height: 30),
        BlockButtonWidget(
            text: Text(
              'confirmOtp'.tr,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () => controller.sendOtp()),
      ],
    );
  }
}

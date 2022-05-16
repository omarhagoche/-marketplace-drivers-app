import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../routes/app_pages.dart';
import '../widgets/block_button.dart';
import '../../core/values/app_config.dart' as config;
import 'signup_controller.dart';

class SignupOtpScreen extends GetView<SignupController> {
  const SignupOtpScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            top: config.App(context).appHeight(32) - 120,
            child: Container(
              width: config.App(context).appWidth(84),
              height: config.App(context).appHeight(37),
              child: Text(
                "inputOtpCode".tr,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .merge(TextStyle(color: Theme.of(context).primaryColor)),
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
                      color: Theme.of(context).hintColor.withOpacity(0.2),
                    )
                  ]),
              margin: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              padding:
                  EdgeInsets.only(top: 50, right: 27, left: 27, bottom: 20),
              width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
              child:
                  // Form(
                  // key: controller.formKey,
                  // child:
                  inputOtpWidget(context),
              // ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  textColor: Theme.of(context).hintColor,
                  child: Text('login'.tr),
                ),
              ],
            ),
          )
        ],
      ),
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
              codeLength: 6,
              onCodeSubmitted: (p0) {
                controller.confirmRegisterVerification();
              },
              controller: controller.otpController,
              decoration: UnderlineDecoration(
                // bgColorBuilder: FixedColorBuilder(Colors.green),
                colorBuilder: FixedColorBuilder(Colors.black),
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 5),
            // TextButton(
            //     onPressed: () {},
            //     child: Text(
            //       "reSend".tr,
            //       style: TextStyle(
            //           color: Theme.of(context).accentColor,
            //           fontWeight: FontWeight.bold),
            //     )),
          ],
        ),
        SizedBox(height: 30),
        BlockButtonWidget(
            text: Text(
              'confirmOtp'.tr,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            color: Theme.of(context).accentColor,
            onPressed: () => controller.confirmRegisterVerification()),
      ],
    );
  }
}

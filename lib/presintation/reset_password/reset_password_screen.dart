import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../generated/l10n.dart';
import '../../src/elements/BlockButtonWidget.dart';
import '../../src/helpers/helper.dart';
import 'reset_password_controller.dart';
import '../../src/helpers/app_config.dart' as config;

class LoginScreen extends GetView<ResetPasswordController> {
  const LoginScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => WillPopScope(
        onWillPop: Helper.of(context).onWillPop,
        child: Scaffold(
          //key: controller.scaffoldKey,
          resizeToAvoidBottomInset: false,
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
                top: config.App(context).appHeight(37) - 120,
                child: Container(
                  width: config.App(context).appWidth(84),
                  height: config.App(context).appHeight(37),
                  child: Text(
                    S.of(context)?.reset_new_password ??'',
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
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                  width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.text,
                         // onSaved: (input) => _con.resetPass.password = input,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: S.of(context)?.please_enter_new_password ?? ''),
                            MinLengthValidator(6,
                                errorText:
                                S.of(context)?.should_be_more_than_6_letters ?? ''),
                          ]),                        obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            labelText: S.of(context)!.password,
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
                            S.of(context)!.save,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                          color: Theme.of(context).accentColor,
                          onPressed: () => controller.resetPassword(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );


  }
}
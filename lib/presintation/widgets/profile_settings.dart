import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../data/models/user.dart';
import 'package:get/get.dart';
class ProfileSettingsDialog extends StatefulWidget {
  final User? user;
  final VoidCallback? onChanged;

  ProfileSettingsDialog({Key? key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                title: Row(
                  children: <Widget>[
                    Icon(Icons.person),
                    SizedBox(width: 10),
                    Text(
                      'profile_settings'.tr,
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
                children: <Widget>[
                  Form(
                    key: _profileSettingsFormKey,
                    child: Column(
                      children: <Widget>[
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'john_doe'.tr, labelText: 'full_name'.tr),
                          initialValue: widget.user!.name,
                          validator: (input) => input!.trim().length < 3 ? 'not_a_valid_full_name'.tr : null,
                          onSaved: (input) => widget.user!.name = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.emailAddress,
                          decoration: getInputDecoration(hintText: 'johndo@gmail.com', labelText: 'email_address'.tr),
                          initialValue: widget.user!.email,
                          validator: EmailValidator(errorText: 'not_a_valid_email'.tr),
                          onSaved: (input) => widget.user!.email = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: '919000000', labelText: 'phone'.tr),
                          initialValue: widget.user!.phone,
                          maxLength: 9,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'please_enter_phone_number'.tr),
                            MinLengthValidator(9,
                                errorText:
                                'not_a_valid_phone'.tr),
                            PatternValidator(
                              r'^(9?(9[0-9]{8}))$',
                              errorText: 'not_a_valid_phone',
                            )
                          ]),
                          onSaved: (input) => widget.user!.phone = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'your_address'.tr, labelText: 'address'.tr),
                          initialValue: widget.user!.address,
                          validator: (input) => input!.trim().length < 3 ? 'not_a_valid_address'.tr : null,
                          onSaved: (input) => widget.user!.address = input,
                        ),
                        new TextFormField(
                          style: TextStyle(color: Theme.of(context).hintColor),
                          keyboardType: TextInputType.text,
                          decoration: getInputDecoration(hintText: 'your_biography'.tr, labelText: 'about'.tr),
                          initialValue: widget.user!.bio,
                          validator: (input) => input!.trim().length < 3 ? 'not_a_valid_biography'.tr : null,
                          onSaved: (input) => widget.user!.bio = input,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'.tr),
                      ),
                      MaterialButton(
                        onPressed: _submit,
                        child: Text(
                          'save'.tr,
                          style: TextStyle(color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                  SizedBox(height: 10),
                ],
              );
            });
      },
      child: Text(
        'edit'.tr,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }

  InputDecoration getInputDecoration({String? hintText, String? labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2!.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2!.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState!.validate()) {
      _profileSettingsFormKey.currentState!.save();
      widget.onChanged!();
      Navigator.pop(context);
    }
  }
}

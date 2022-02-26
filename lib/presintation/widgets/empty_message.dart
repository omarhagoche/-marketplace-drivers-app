import 'package:flutter/material.dart';
import '../../core/values/app_config.dart' as config;
import 'package:get/get.dart';
class EmptyMessagesWidget extends StatelessWidget {
  EmptyMessagesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.center,
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: config.App(context).appHeight(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Opacity(
                opacity: 0.4,
                child: Text(
                  'youDontHaveAnyConversations'.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!.merge(TextStyle(fontWeight: FontWeight.w300)),
                ),
              ),
              SizedBox(height: 20),

            ],
          ),
        )
      ],
    );
  }
}

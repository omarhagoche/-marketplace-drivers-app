import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import '../widgets/profile_avatar.dart';
import '../widgets/statistics_carousel.dart';
import '../widgets/loading_widget.dart';
import 'profile_controller.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
        key: controller.scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).primaryColor),
            onPressed: () => controller.scaffoldKey.currentState!.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).accentColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'profile'.tr,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(
                letterSpacing: 1.3, color: Theme.of(context).primaryColor)),
          ),
        ),
        body: Obx(
          () => controller.user.value == null
              ? LoadingWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () => ProfileAvatarWidget(
                          user: controller.user.value,
                          onCamera: () => controller.imgFromCamera(),
                          onGallery: () => controller.imgFromGallery(),
                          image: controller.imagePath.value,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: controller.loading.value
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : Card(
                                child: SwitchListTile(
                                    title: controller
                                            .user.value!.driver!.available!
                                        ? Text('متوفر')
                                        : Text('غير متوفر'),
                                    value: controller.driverState.value,
                                    onChanged: (value) {
                                      controller.toggleloadingwiget();
                                      controller.user.value!.driver!.available =
                                          value;
                                      controller.updateDriverState(value);
                                    },
                                    secondary: controller
                                            .user.value!.driver!.available!
                                        ? Icon(
                                            Icons.lightbulb_outline,
                                            color: Colors.green,
                                          )
                                        : Icon(
                                            Icons.lightbulb_outline,
                                          )),
                              ),
                      ),
                      Obx(
                        () => controller.statistics.value == null
                            ? Center(
                                child: LoadingWidget(),
                              )
                            : StatisticsCarouselWidget(
                                statistics: controller.statistics.value!),
                      )
                    ],
                  ),
                ),
        ));
  }
}

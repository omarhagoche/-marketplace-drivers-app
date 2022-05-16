import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../data/models/user.dart';
import 'package:get/get.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final User? user;
  final VoidCallback? onGallery;
  final VoidCallback? onCamera;
  final String? image;

  ProfileAvatarWidget({
    Key? key,
    this.user,
    this.onGallery,
    this.onCamera,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    image.toString().isEmpty
                        ? ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(300)),
                            child: Image.file(
                              File(image ?? ''),
                              width: 135,
                              height: 135,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(300)),
                            child: CachedNetworkImage(
                              height: 135,
                              width: 135,
                              fit: BoxFit.cover,
                              imageUrl: user!.image!.url!,
                              placeholder: (context, url) => Image.asset(
                                'assets/img/loading.gif',
                                fit: BoxFit.cover,
                                height: 135,
                                width: 135,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                    Positioned(
                      right: -3,
                      bottom: -10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () => _showPicker(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            user!.name!,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .merge(TextStyle(color: Theme.of(context).primaryColor)),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(
                        'gallery'.tr,
                      ),
                      onTap: () {
                        onGallery!();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(
                      'camera'.tr,
                    ),
                    onTap: () {
                      onCamera!();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

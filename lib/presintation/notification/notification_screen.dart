import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/drawer.dart';
import '../widgets/empty_notification.dart';
import '../widgets/notification_item.dart';
import 'notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (_con) => Scaffold(
        key: _con.scaffoldKey,
        drawer: DrawerWidget(),
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
            onPressed: () => _con.scaffoldKey.currentState?.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'notification'.tr,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _con.refreshNotifications,
          child: Obx(()=>_con.notifications.isEmpty
              ? EmptyNotificationsWidget()
              : ListView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          Icons.notifications,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          'notifications'.tr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        subtitle: Text(
                          'swip_left_the_notification_to_delete_or_read__unread'
                              .tr,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.notifications.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 15);
                      },
                      itemBuilder: (context, index) {
                        return NotificationItemWidget(
                          notification: _con.notifications.elementAt(index),
                          onMarkAsRead: () {
                            _con.doMarkAsReadNotifications(
                                _con.notifications.elementAt(index));
                          },
                          onMarkAsUnRead: () {
                            _con.doMarkAsUnReadNotifications(
                                _con.notifications.elementAt(index));
                          },
                          onRemoved: () {
                            _con.doRemoveNotification(
                                _con.notifications.elementAt(index));
                          },
                        );
                      },
                    ),
                  ],
                ),
        ),
        ),
      ),
    );
  }
}

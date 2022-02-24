
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/conversation.dart';

import '../../generated/l10n.dart';
import '../../src/elements/EmptyMessagesWidget.dart';
import '../../src/elements/MessageItemWidget.dart';
import '../../src/elements/ShoppingCartButtonWidget.dart';
import 'messages_controller.dart';

class MessagesScreen extends StatelessWidget {

  Widget conversationsList(MessagesController controller) {
   return StreamBuilder(
     stream: controller.conversations,
     builder: (context, snapshot) {
       if (snapshot.hasData) {
         var _docs = controller.orderSnapshotByTime(snapshot);
         return _docs.length==0?
         EmptyMessagesWidget()
             :ListView.separated(
             itemCount: _docs.length,
             separatorBuilder: (context, index) {
               return SizedBox(height: 7);
             },
             shrinkWrap: true,
             primary: false,
             itemBuilder: (context, index) {
               Conversation _conversation = Conversation.fromJSON(_docs[index].data());
               return MessageItemWidget(
                 message: _conversation,
                 onDismissed: (conversation) {
                   //_conversationList.conversations.removeAt(index);

                 },
               );
             });
       } else {
         return EmptyMessagesWidget();
       }
     },
   );

  }

  @override
  Widget build(BuildContext context) {
    final MessagesController controller = Get.put(MessagesController());
    return Scaffold(
       // key: controller.scaffoldKey,
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: (){
                controller.openDrawer();
              }// => widget.parentScaffoldKey!.currentState!.openDrawer(),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            S.of(context)?.messages ?? '',
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
          ),
          actions: <Widget>[
            new ShoppingCartButtonWidget(iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
          ],
        ),
        body: GetBuilder<MessagesController>(
          builder: (c) {
           return ListView(
              primary: false,
              children: <Widget>[
                StreamBuilder(
                  stream: c.conversations,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var _docs = c.orderSnapshotByTime(snapshot);
                      return _docs.length==0?
                      EmptyMessagesWidget()
                          :ListView.separated(
                          itemCount: _docs.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 7);
                          },
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            Conversation _conversation = Conversation.fromJSON(_docs[index].data());
                            return MessageItemWidget(
                              message: _conversation,
                              onDismissed: (conversation) {
                                //_conversationList.conversations.removeAt(index);

                              },
                            );
                          });
                    } else {
                      return EmptyMessagesWidget();
                    }
                  },
                ),
              ],
            );
          },
        )

    );
  }
}
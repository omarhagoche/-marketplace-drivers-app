import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/chat.dart';
import '../../data/models/route_argument.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/empty_message.dart';
import 'chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({key,required this.routeArgument}) : super(key: key);
  final RouteArgument routeArgument;


  Widget chatList(ChatController _con) {
    return StreamBuilder(
      stream: _con.chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData

            ? ListView.builder(
            key: _con.myListKey,
            reverse: true,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: false,
            primary: true,
            itemBuilder: (context, index) {
              print('snapshot.data: ${snapshot.data}');
              Chat _chat = Chat.fromJSON(snapshot.data!.docs[index].data() as Map<String, dynamic>);
              _chat.user = _con.conversation!.users!.firstWhere((_user) => _user.id == _chat.userId);
              return ChatMessageListItem(
                chat: _chat,
              );
            })
            : EmptyMessagesWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(
      builder: (_con)=>Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _con.conversation!.name!,
          overflow: TextOverflow.fade,
          maxLines: 1,
          style: Theme.of(context).textTheme.headline6!.merge(TextStyle(letterSpacing: 1.3)),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: chatList(_con),
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.10), offset: Offset(0, -4), blurRadius: 10)],
            ),
            child: TextField(
              controller: _con.myController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                hintText: 'type_to_start_chat',
                hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.8)),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(right: 30),
                  onPressed: () {
                    _con.addMessage(_con.conversation!, _con.myController.text);
                    Timer(Duration(milliseconds: 100), () {
                      _con.myController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                ),
                border: UnderlineInputBorder(borderSide: BorderSide.none),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          )
        ],
      )
      )
    );
  }
}

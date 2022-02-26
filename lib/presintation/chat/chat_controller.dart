import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/chat.dart';
import '../../data/models/conversation.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/chat_repository.dart';

import '../../data/repositories/notification_repository.dart';
class ChatController extends GetxController {
  Conversation? conversation;
  Stream<QuerySnapshot>? conversations;
  Stream<QuerySnapshot>? chats;
  GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  void onInit() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    super.onInit();

  }


  createConversation(Conversation _conversation) async {
    ChatRepository.instance.createConversation(conversation!).then((value) {
      listenForChats(conversation!);
    });
  }

  listenForConversations() async {
    ChatRepository.instance.getUserConversations(currentUser.value.id!).then((snapshots) {
        conversations = snapshots;
        update();
    });
  }

  listenForChats(Conversation _conversation) async {
    _conversation.readByUsers!.add(currentUser.value.id!);
    ChatRepository.instance.getChats(_conversation).then((snapshots) {
        chats = snapshots;
        update();
    });
  }

  addMessage(Conversation _conversation, String text) {
    Chat _chat = new Chat(text, DateTime.now().toUtc().millisecondsSinceEpoch, currentUser.value.id);
    if (_conversation.id == null) {
      _conversation.id = UniqueKey().toString();
      createConversation(_conversation);
    }
    _conversation.lastMessage = text;
    _conversation.lastMessageTime = _chat.time;
    _conversation.readByUsers = [currentUser.value.id!];
    ChatRepository.instance.addMessage(_conversation, _chat).then((value) {
      _conversation.users!.forEach((_user) {
        if (_user.id != currentUser.value.id) {
          NotificationRepository.instance.sendNotification(text, 'newMessageFrom'.tr + " " + currentUser.value.name!, _user);
        }
      });
    });
  }

  orderSnapshotByTime(AsyncSnapshot snapshot) {
    final docs = snapshot.data.docs;
    docs.sort((QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
      var time1 = a.get('time');
      var time2 = b.get('time');
      return time2.compareTo(time1) as int;
    });
    return docs;
  }
}

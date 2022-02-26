import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/conversation.dart';

class MessagesController extends GetxController {
  Rxn<Conversation>? conversation = Rxn();
  Stream<QuerySnapshot>? conversations;
  var content = ' '.obs;
  Stream<QuerySnapshot>? chats;
  final scaffoldKey = GlobalKey<ScaffoldState>();



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
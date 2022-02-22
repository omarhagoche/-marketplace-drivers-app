import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat.dart';
import '../models/conversation.dart';

class ChatRepository {
  static ChatRepository get instance => ChatRepository();


  // Create Conversation
  Future<void> createConversation(Conversation conversation) {
    return FirebaseFirestore.instance.collection("conversations").doc(conversation.id).set(conversation.toMap()as Map<String, dynamic>).catchError((e) {
      print(e);
    });
  }

  Future<Stream<QuerySnapshot>> getUserConversations(String userId) async {
    return await FirebaseFirestore.instance.collection("conversations").where('visible_to_users', arrayContains: userId).snapshots();
  }

  Future<Stream<QuerySnapshot>> getChats(Conversation conversation) async {
    return updateConversation(conversation.id!, {'read_by_users': conversation.readByUsers}).then((value) async {
      return await FirebaseFirestore.instance
          .collection("conversations")
          .doc(conversation.id)
          .collection("chats")
          .orderBy('time', descending: true)
          .snapshots();
    });
  }

  Future<void> addMessage(Conversation conversation, Chat chat) {
    return FirebaseFirestore.instance.collection("conversations").doc(conversation.id!).collection("chats").add(chat.toMap() as Map<String, dynamic>).whenComplete(() {
      updateConversation(conversation.id!, (conversation.toUpdatedMap()) as Map<String, dynamic>);
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future<void> updateConversation(String conversationId,
      Map<String, dynamic> conversation) {
    return FirebaseFirestore.instance.collection("conversations").doc(conversationId).update(conversation).catchError((e) {
      print(e.toString());
    });
  }
}

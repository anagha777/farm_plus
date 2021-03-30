import 'package:farm_plus/contact_model.dart';

class ChatModel {
  final bool isTyping;
  //final String lastMessage;
  final ContactModel contact;

  ChatModel(
      {this.isTyping, this.contact});

  static List<ChatModel> list = [

    ChatModel(
      isTyping: false,
      contact: ContactModel(name: "Farmer1"),
    ),
    ChatModel(
      isTyping: false,

      contact: ContactModel(name: "Farmer2"),
    ),

  ];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/models/message.dart';

abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<Message> messagesList;
  ChatSuccessState(
    this.messagesList,
  );
}

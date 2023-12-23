import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat/chat_state.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messagesList = [];
  void sendMessage({
    required String message,
    required String email,
  }) {
    try {
      messages.add(
        {
          kMessage: message,
          kCreatedAt: DateTime.now(),
          'id': email,
        },
      );
    } on Exception catch (_) {}
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        messagesList.add(Message.fromJson(event.docs[i]));
      }
      emit(ChatSuccessState(messagesList));
    });
  }

  @override
  void onChange(Change<ChatState> change) {
    super.onChange(change);
    print(change);
  }
}

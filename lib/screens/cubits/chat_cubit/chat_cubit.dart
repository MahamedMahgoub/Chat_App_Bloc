import 'package:bloc/bloc.dart';
import 'package:chat_app_bloc/constant.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);
  List<Message> messageList = [];
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        KMessage: message,
        KCreatedAt: FieldValue.serverTimestamp(),
        Kid: email,
      });
    } on Exception catch (e) {}
  }

  void getMessage() {
    messages.orderBy(KCreatedAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromjson(doc));
      }
      print('Success');
      emit(ChatSuccessState(messages: messageList));
    });
  }
}

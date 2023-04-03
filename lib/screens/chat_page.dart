import 'package:chat_app_bloc/components/chat_buble.dart';
import 'package:chat_app_bloc/constant.dart';
import 'package:chat_app_bloc/models/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  static String id = 'chat Page';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  TextEditingController controller = TextEditingController();

  final ScrollController _controller = ScrollController();

  String? messageText;

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messageList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              Message.fromjson(snapshot.data!.docs[i]),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimatrColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                  const Text('Chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return messageList[index].id == email
                          ? ChatBubles(
                              messege: messageList[index],
                            )
                          : ChatBublesForFriend(messege: messageList[index]);
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          messageText = value;
                        });
                      },
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: const BorderSide(
                            color: kPrimatrColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            if (messageText!.isNotEmpty) {
                              messages.add({
                                KMessage: messageText,
                                KCreatedAt: FieldValue.serverTimestamp(),
                                Kid: email,
                              });
                            }

                            controller.clear();
                            messageText = '';

                            _controller.animateTo(0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.fastOutSlowIn);
                          },
                          icon: const Icon(Icons.send),
                          disabledColor: Colors.grey,
                          color: kPrimatrColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding:
                //       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   child: TextField(
                //     controller: controller,
                //     onChanged: (data) {
                //       messages.add({
                //         KMessage: data,
                //         KCreatedAt: FieldValue.serverTimestamp(),
                //         Kid: email,
                //       });
                //       controller.clear();
                //       _controller.animateTo(
                //         0,
                //         duration: const Duration(milliseconds: 500),
                //         curve: Curves.fastOutSlowIn,
                //       );
                //     },
                //     decoration: InputDecoration(
                //       contentPadding: const EdgeInsets.symmetric(
                //           vertical: 16, horizontal: 16),
                //       suffixIcon: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.send,
                //             color: kPrimatrColor,
                //           )),
                //       hintText: 'Send Massage',
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(16),
                //         borderSide: const BorderSide(
                //           color: kPrimatrColor,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

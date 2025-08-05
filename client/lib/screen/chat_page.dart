import 'package:client/getx/global_cotroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Chatpage extends StatelessWidget {
  Chatpage({super.key});

  var controller = Get.find<Controller>();

  TextEditingController textController = TextEditingController();

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191929),
      appBar: AppBar(
        backgroundColor: Color(0xff191929),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: ListTile(
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff7825D5),
            ),
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            'Chat - ${controller.selectedRole.value}',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      bottomSheet: BottomSheet(
        backgroundColor: Color(0xff191929),
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onSubmitted: (value) {
                      controller.sendMessage(value);
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xff262641),
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      // print('Sending message: ${textController.text}');
                      controller.sendMessage(textController.text);
                      textController.clear();
                    }
                  },
                  icon: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 50),
        child: GetBuilder<Controller>(
          init: Controller(),
          initState: (_) {
            controller.connect();
          },
          dispose: (_) {
            controller.closeConnection();
          },
          builder: (_) {
            print('Messages count: ${controller.messages.length}');
            if (controller.messages.isEmpty) {
              return Center(
                child: Text(
                  'No messages yet',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Bubble(
                  isSender: message.senderId == controller.selectedRole.value,
                  content: message.text,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  const Bubble({super.key, required this.isSender, required this.content});

  final bool isSender;
  final String content;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        if (isSender) Spacer(),
        Container(
          width: deviceWidth * 0.7,
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: isSender ? Color(0xff7825D5) : Color(0xff262641),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
              // bottomLeft: isSender ? Radius.circular(20) : Radius.zero,
              bottomRight: !isSender ? Radius.circular(40) : Radius.zero,
              bottomLeft: isSender ? Radius.circular(40) : Radius.zero,
            ),
          ),
          child: Text(content, style: TextStyle(color: Colors.white)),
        ),
        if (!isSender) Spacer(),
      ],
    );
  }
}

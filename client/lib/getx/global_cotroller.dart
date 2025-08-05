import 'dart:async';
import 'dart:convert';

import 'package:client/model/chat_model.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

enum UserRole { user1, user2 }

class Controller extends GetxController {
  // Define your global variables and methods here

  var selectedRole = UserRole.user1.name.obs;
  final messages = <ChatMessage>[].obs;
  bool isConnected = false;

  WebSocketChannel? _channel;
  final String _socketUrl = 'ws://192.168.1.14:8080/ws';

  void closeConnection() {
    if (_channel != null) {
      _channel!.sink.close();
      debugPrint('WebSocket connection closed');
    }
    messages.clear();
  }

  void selectRole(UserRole role) {
    selectedRole.value = role.name;
  }

  void connect() {
    _channel = WebSocketChannel.connect(Uri.parse(_socketUrl));
    isConnected = true;

    _channel!.stream.listen(
      (message) {
        debugPrint('WebSocket message received: $message');

        final data = jsonDecode(message) as Map<String, dynamic>;

        final ChatMessage chatMessage = ChatMessage.fromJson(
          data,
          selectedRole
              .value, // Assuming selectedRole.value is the current user's ID
        );

        messages.add(chatMessage);
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
        update();
      },
      onDone: () {
        debugPrint('WebSocket connection closed');

        isConnected = false;
      },
      onError: (error) {
        debugPrint('WebSocket error: $error');

        isConnected = false;
      },
    );
  }

  void sendMessage(String text) {
    if (text.isEmpty || _channel == null || !isConnected) return;
    final message = {'text': text, 'sender': selectedRole.value};
    final jsonMessage = jsonEncode(message);

    _channel!.sink.add(jsonMessage);
    update(); // Notify listeners about the new message
    debugPrint('WebSocket message sent: $jsonMessage');
  }
}

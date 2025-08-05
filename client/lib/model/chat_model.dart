// lib/chat_message.dart
import 'package:flutter/material.dart'; // Diperlukan untuk UniqueKey

class ChatMessage {
  final String text;
  final String senderId;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory ChatMessage.fromJson(
    Map<String, dynamic> json,
    String currentUserId,
  ) {
    return ChatMessage(
      text: json['text'] as String,
      senderId: json['sender'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

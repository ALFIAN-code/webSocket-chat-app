// lib/chat_message.dart

class ChatMessage {
  final String text;
  final String senderId;
  final DateTime? timestamp;

  ChatMessage({
    required this.text,
    required this.senderId,
    this.timestamp,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json['text'] as String,
      senderId: json['sender'] as String,
    );
  }

  Map<String, Object> toJson() {
    return {
      'text': text,
      'sender': senderId,
      'timestamp': timestamp != null
          ? timestamp!.toIso8601String()
          : DateTime.now().toIso8601String(),
    };
  }
}

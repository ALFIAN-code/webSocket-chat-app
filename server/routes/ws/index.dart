import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

import '../../model/message_model.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// variable berisi kumpulan client yang terhubung
// untuk di producton, mungkin bisa menggunakan message broker seperti Redis atau RabbitMQ
final List<WebSocketChannel> _connections = [];

final List<ChatMessage> _messages = [];

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // tambahkan channel ke list koneksi
      _connections.add(channel);
      print('Client connected! Total clients: ${_connections.length}');

      for (final item in _messages) {
        channel.sink.add(jsonEncode(item.toJson()));
        print('Sending message to client: ${item.text}');
      }

      // mendengarkan pesan dari client
      channel.stream.listen(
        (message) {
          print('Received message: $message');

          final Map<String, dynamic> incomingMessage;
          try {
            incomingMessage =
                jsonDecode(message as String) as Map<String, dynamic>;
          } catch (e) {
            print('Error decoding message: $e');
            return;
          }

          print('incoming message $incomingMessage');

          //timestamp dibuat di server. karena client bisa mengirimkan timestamp yang tidak sesuai, karena perbedaan zona waktu
          final timestamp = DateTime.now().toIso8601String();

          // data yang akan dikirim ke semua client
          final data = ChatMessage.fromJson(incomingMessage);

          _messages.add(
            ChatMessage(
              text: data.text,
              senderId: data.senderId,
              timestamp: DateTime.parse(timestamp),
            ),
          );

          // encode data ke JSON string
          final outgoingJson = jsonEncode(data.toJson());

          // kirim pesan ke semua client
          for (final client in _connections) {
            client.sink.add(outgoingJson);
          }
        },
        onDone: () {
          print('Client disconnected');
          // hapus channel dari list koneksi saat client terputus
          _connections.remove(channel);
        },
        onError: (error) {
          print('Error in client stream: $error');
          // hapus channel dari list koneksi jika terjadi error
          _connections.remove(channel);
        },
      );
    },
  );

  return handler(context);
}

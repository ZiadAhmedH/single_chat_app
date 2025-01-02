import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late final WebSocketChannel channel;

  WebSocketService()  {
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.5:8080'));
  }

  Stream get stream => channel.stream;

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      channel.sink.add(message);
    }
  }

  void dispose(dynamic status) {
    channel.sink.close(status.goingAway);
  }
}


class Message {
  final String content;
  final String senderId;
  final bool isSender;
  final String timesNow;

  Message({required this.content, required this.senderId, required this.isSender, required this.timesNow});
}

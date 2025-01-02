class Message {
  final String senderId;
  final String message;
  final String timeNow;
  final bool isSender;
  final String name;

  Message({
    required this.senderId,
    required this.message,
    required this.timeNow,
    required this.isSender,
    required this.name,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'] ?? '',  
      message: json['message'] ?? '',
      timeNow: json['timeNow'] ?? '',
      isSender: json['senderId'] == 'clientId', 
      name: json['senderName'] ?? 'Unknown',
    );
  }
}

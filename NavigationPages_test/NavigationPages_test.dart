import 'package:chat_midterm/NavigationPages/messages.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing App Provider', () {
    var messageStuff = ChatMessage(messageContent: "", messageType: "");
    test('A new item should be added', () {
      var number = new ChatMessage(
          messageContent: "messageContent", messageType: "messageType");
      expect(messageStuff.messageContent.contains(""), false);
    });
  });
}

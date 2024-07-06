import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:unimatch/userPreferences.dart';

import 'config.dart';

StompClient client = StompClient(
    config: StompConfig(
      url: 'ws://server_ip/unimatch-api/socket',
      webSocketConnectHeaders: {"Sec-WebSocket-Protocol": "${UserPreferences.getToken()}|${clientUser.username}"},
      onConnect: (frame) {},
      onWebSocketError: (dynamic error) => debugPrint(error.toString()),
    )
);

void subFriend(Function() notifyParent) {
  client.subscribe(
    destination: '/simple/message/${clientUser.id}',
    callback: (frame) {
      notifyParent();
    },
  );
  client.subscribe(
    destination: '/msgHandle/message/${clientUser.id}',
    callback: (frame) {
      notifyParent();
    },
  );
}

void subGroup(String groupId, Function() notifyParent) {
  client.subscribe(
    destination: '/topic/message/$groupId',
    callback: (frame) {
      notifyParent();
    },
  );
  client.subscribe(
    destination: '/msgHandle/message/$groupId',
    callback: (frame) {
      notifyParent();
    },
  );
}

void subInvitation(Function() notifyParent) {
  client.subscribe(
    destination: '/invitation/message/${clientUser.id}',
    callback: (frame) {
      notifyParent();
    },
  );
}
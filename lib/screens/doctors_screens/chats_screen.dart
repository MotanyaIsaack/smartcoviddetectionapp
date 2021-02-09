import 'package:health_care/models/chat/chats.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatsData = Provider.of<Chats>(context);
    final chats = chatsData.items;

    return Flexible(
      child: ListView.separated(
        itemCount: chats.length,
        itemBuilder: (ctx, i) {
          return ListTile(
            title: Text(chats[i].name),
            subtitle: Text(
              chats[i].description,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chats[i].profileImage),
            ),
            trailing: Text(chats[i].time,
                style: TextStyle(color: Theme.of(context).primaryColor)),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }
}

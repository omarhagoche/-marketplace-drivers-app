import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../data/models/conversation.dart' as model;
import '../../data/models/route_argument.dart';
import '../../data/repositories/auth_repository.dart';

class MessageItemWidget extends StatelessWidget {
  MessageItemWidget({Key? key, this.message, this.onDismissed}) : super(key: key);
  final model.Conversation? message;
  final ValueChanged<model.Conversation>? onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(message.hashCode.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the item from the data source.
        ///ToDo
        // setState(() {
        //   onDismissed!(message!);
        // });

        // Then show a snackbar.
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("The conversation with ${message!.name} is dismissed")));
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/Chat', arguments: RouteArgument(param: message));
        },
        child: Container(
          color: message!.readByUsers!.contains(currentUser.value.id) ? Colors.transparent : Theme.of(context).focusColor.withOpacity(0.05),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(60)),
                      child: CachedNetworkImage(
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: message!.users!.firstWhere((element) => element.id != currentUser.value.id!).image!.thumb as String,
                        placeholder: (context, url) => Image.asset(
                          'assets/img/loading.gif',
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 140,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    width: 12,
                    height: 12,
                    child: Container(
                      decoration: BoxDecoration(
//                        color: message.user.userState == UserState.available
//                            ? Colors.green
//                            : message.user.userState == UserState.away ? Colors.orange : Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message!.users?.first.name ?? '',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodyText1!.merge(
                                TextStyle(fontWeight: message!.readByUsers!.contains(currentUser.value.id) ? FontWeight.w400 : FontWeight.w800)),
                          ),
                        ),
                        Text(
                          DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(message!.lastMessageTime!, isUtc: true)),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            message!.lastMessage!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.caption!.merge(
                                TextStyle(fontWeight: message!.readByUsers!.contains(currentUser.value.id) ? FontWeight.w400 : FontWeight.w800)),
                          ),
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(message!.lastMessageTime!, isUtc: true)),
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

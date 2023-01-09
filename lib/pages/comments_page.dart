
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:roomr_business_logic/roomr_business_logic.dart';

import '../graphql/graphql_client.dart';
import '../graphql/query_helper.dart';
import '../services/FirebaseConfig.dart';

import '../widgets/Forms/Form/comment_form.dart';
import '../widgets/builders/comment_stream_builder.dart';

class CommentsPage extends StatefulWidget {
  final int maintenanceTicketId;
  final String houseKey;
  final Landlord landlord;
  const CommentsPage(
      {Key? key,
      required this.maintenanceTicketId,
      required this.houseKey,
      required this.landlord})
      : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  ScrollController scrollController = ScrollController();

  void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void scrollToBottom() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 2000));
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: SafeArea(
            child: Scaffold(
                appBar: AppBar(),
                body: QueryHelper(
                    isList: false,
                    queryName: 'getMaintenanceTicket',
                    variables: {
                      "houseKey": widget.houseKey,
                      "maintenanceTicketId": widget.maintenanceTicketId
                    },
                    onComplete: (json) {
                      if (json == null) {
                        return const CircularProgressIndicator();
                      }
                      MaintenanceTicket maintenanceTicket =
                          MaintenanceTicket.fromJson(json);

                      return Column(children: [
                        CommentStreamBuilder(
                          landlord: widget.landlord,
                          firebaseId: maintenanceTicket.firebaseId,
                          scrollController: scrollController,
                        ),
                        CommentForm(
                          landlord: widget.landlord,
                          houseKey: widget.houseKey,
                          maintenanceTicket: maintenanceTicket,
                          onSend: (context, comment) async {
                            await FirebaseConfiguration().setComment(
                                maintenanceTicket.firebaseId, comment);
                            closeKeyboard(context);
                            scrollToBottom();
                          },
                        )
                      ]);
                    }))));
  }
}

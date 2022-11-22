import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/business_logic/comment.dart';
import 'package:notification_app/business_logic/landlord.dart';
import 'package:notification_app/graphql/query_helper.dart';

import '../../business_logic/maintenance_ticket.dart';
import '../../services/FirebaseConfig.dart';
import '../../graphql/graphql_client.dart';
import '../../widgets/Forms/Form/comment_form.dart';
import '../../widgets/Forms/FormRow/table_row.dart';
import '../../widgets/builders/comment_stream_builder.dart';

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
  final ScrollController _scrollController = ScrollController();

  void animateScroll() {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        position * 2,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    }
  }

  void closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
        client: GQLClient().getClient(),
        child: QueryHelper(
          isList: false,
          queryName: "getMaintenanceTicket",
          variables: {
            "houseKey": widget.houseKey,
            "maintenanceTicketId": widget.maintenanceTicketId
          },
          onComplete: (json) {
            if (json == null) {
              return CircularProgressIndicator();
            }
            json = json as Map<String, dynamic>;
            MaintenanceTicket maintenanceTicket =
                MaintenanceTicket.fromJson(json);
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(),
                    body: NestedScrollView(
                        
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return [
                            SliverList(
                              
                                delegate: SliverChildListDelegate([
                              GestureDetector(
                                  onTap: () {
                                    closeKeyboard(context);
                                  },
                                  child: Column(children: [
                                    Container(
                                        height: 300,
                                        margin: const EdgeInsets.only(
                                            top: 8, bottom: 8),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                                maintenanceTicket.picture
                                                    .getUrl()!))),
                                    TablePair(
                                        name: "Date Created: ",
                                        value: maintenanceTicket.datePosted),
                                    TablePair(
                                        name: "Urgency: ",
                                        value: maintenanceTicket.urgency.name),
                                    TablePair(
                                        name: "Description: ",
                                        value: maintenanceTicket
                                            .description.description),
                                  ]))
                            ]))
                          ];
                        },
                        body: Column(children: [
                          CommentStreamBuilder(
                            landlord: widget.landlord,
                            firebaseId: maintenanceTicket.firebaseId,
                            scrollController: _scrollController,
                          ),
                          CommentForm(
                            landlord: widget.landlord,
                            houseKey: widget.houseKey,
                            maintenanceTicket: maintenanceTicket,
                            onSend: (BuildContext context,
                                TextComment comment) async {
                              await FirebaseConfiguration().setComment(
                                  maintenanceTicket.firebaseId, comment);
                              animateScroll();
                              closeKeyboard(context);
                            },
                          )
                        ]))));
          },
        ));
  }
}

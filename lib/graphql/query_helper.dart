import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryHelper extends StatefulWidget {
  final Map<String, dynamic> variables;
  final String queryName;
  final Widget Function(dynamic json) onComplete;
  final bool isList;
  const QueryHelper(
      {Key? key,
      required this.variables,
      required this.queryName,
      required this.onComplete, required this.isList})
      : super(key: key);

  @override
  State<QueryHelper> createState() => _QueryHelperState();
}

class _QueryHelperState extends State<QueryHelper> {
  bool isVisible = false;

  Future<String> getQuery(String name) async {
    return await rootBundle.loadString('${name}Query.txt');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getQuery(widget.queryName),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Stack(
              children: [
                widget.isList ? widget.onComplete([]) : widget.onComplete(null),
                AlertDialog(
                    content: Row(
                  children: [
                    const CircularProgressIndicator(),
                    Container(
                        margin: const EdgeInsets.only(left: 7),
                        child: const Text("Loading...")),
                  ],
                )),
              ],
            );
          }
          return Query(
              options: QueryOptions(
                  fetchPolicy: FetchPolicy.noCache,
                  document: gql(snapshot.data!),
                  variables: widget.variables),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  isVisible = true;
                  return Stack(children: [
                    AlertDialog(
                        content: Row(children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 7),
                          child: const Text("Loading...")),
                    ]))
                  ]);
                }
                if (result.hasException) {
                  return Stack(
                    children: [
                      Visibility(
                        visible: isVisible,
                        child: AlertDialog(
                          actions: [
                            TextButton(
                              child: const Text('Dismiss'),
                              onPressed: () {
                                setState(() {
                                  isVisible = false;
                                });
                              },
                            ),
                          ],
                          content: Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.red,
                                child: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  result.exception!.graphqlErrors.isNotEmpty
                                      ? result
                                          .exception!.graphqlErrors[0].message
                                      : "Failed to connect, connection timed out",
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return widget.onComplete(result.data![widget.queryName]);
              });
        });
  }
}

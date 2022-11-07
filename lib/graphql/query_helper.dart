import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class QueryHelper extends StatefulWidget {
  final Map<String, dynamic> variables;
  final Widget Function(Map<String, dynamic> json)? onComplete;
  final Widget Function(List<dynamic> json)? onCompleteList;
  final String queryName;
  const QueryHelper(
      {Key? key,
      required this.variables,
      required this.queryName,
      this.onComplete,
      this.onCompleteList})
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
          while (!snapshot.hasData) {
            return AlertDialog(
                content: Row(
              children: [
                const CircularProgressIndicator(),
                Container(
                    margin: const EdgeInsets.only(left: 7),
                    child: const Text("Loading...")),
              ],
            ));
          }
          return Query(
              options: QueryOptions(
                  fetchPolicy: FetchPolicy.noCache,
                  document: gql(snapshot.data!),
                  variables: widget.variables),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Visibility(
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
                                  ? result.exception!.graphqlErrors[0].message
                                  : "Failed to connect, connection timed out",
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (result.isLoading) {
                  isVisible = true;
                  return AlertDialog(
                      content: Row(
                    children: [
                      const CircularProgressIndicator(),
                      Container(
                          margin: const EdgeInsets.only(left: 7),
                          child: const Text("Loading...")),
                    ],
                  ));
                }

                if (widget.onCompleteList == null &&
                    widget.onComplete == null) {
                  return const MaterialApp(
                      home: Scaffold(
                          body: Text("Forgot to add an on complete callback")));
                }
                if (widget.onCompleteList == null) {
                  return widget.onComplete!(result.data![widget.queryName]);
                }
                if (widget.onComplete == null) {
                  return widget.onCompleteList!(result.data![widget.queryName]);
                }
                return const MaterialApp(
                    home: Scaffold(
                        body: Text("Forgot to add an on complete callback")));
              });
        });
  }
}

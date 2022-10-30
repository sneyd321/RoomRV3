import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/queries.dart';
import 'package:notification_app/services/graphql_client.dart';

class QueryHelper extends StatefulWidget {
  final String queryName;
  final Map<String, dynamic> variables;
  final Widget Function(QueryResult<Object?>, {Future<QueryResult<Object?>> Function(FetchMoreOptions)? fetchMore, Future<QueryResult<Object?>?> Function()? refetch}) onComplete;
  const QueryHelper({Key? key, required this.onComplete, required this.queryName, required this.variables}) : super(key: key);

  @override
  State<QueryHelper> createState() => _QueryHelperState();
}

class _QueryHelperState extends State<QueryHelper> {

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: GQLClient().getClient(),
      child: Query(
        options: QueryOptions(
            fetchPolicy: FetchPolicy.noCache,
            document:
                gql(Queries().getQuery(widget.queryName)),
            variables: widget.variables),
        builder: widget.onComplete
      ),
    );
  }
}

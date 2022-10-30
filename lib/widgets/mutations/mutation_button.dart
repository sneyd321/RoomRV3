import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:notification_app/graphql/mutations.dart';
import 'package:notification_app/widgets/Dialogs/error_dialog.dart';

class MutationButton extends StatefulWidget {
  final String mutationName;
  final Function(Map<String, dynamic>? result) onComplete;
  final Widget Function(MultiSourceResult<Object?> Function(Map<String, dynamic>, {Object? optimisticResult}), QueryResult<Object?>?) builder;
  const MutationButton(
      {Key? key,
      required this.onComplete,
      required this.mutationName, required this.builder,
      })
      : super(key: key);

  @override
  State<MutationButton> createState() => _MutationButtonState();
}

class _MutationButtonState extends State<MutationButton> {

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(Mutations().getMutation(widget.mutationName)),
        onError: ((error) {
          print("ERROR");
          ErrorDialog errorDialog = ErrorDialog(error.toString());
          errorDialog.show(context);
        }),
        onCompleted: (Map<String, dynamic>? resultData) async {
          print(resultData);
          if (resultData == null) {
            ErrorDialog errorDialog = ErrorDialog("Null response error");
            errorDialog.show(context);
            widget.onComplete(null);
          }
          widget.onComplete(resultData![widget.mutationName]);
        },
      ),
      builder: widget.builder
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:notification_app/bloc/form_builder/form_builder.dart';
import 'package:notification_app/bloc/submit/submit.dart';

class FormContainer extends StatefulWidget {
  final FormBuilder formBuilder;
  final String buttonText;
  final void Function() onUpdate;
  const FormContainer({
    Key? key,
    required this.onUpdate,
    required this.formBuilder,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<FormContainer> createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      widget.onUpdate();
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    double width = WidgetsBinding.instance.window.physicalSize.width;
    widget.formBuilder.add(
        Submit(widget.buttonText, submit, width: width, left: 8, right: 8));
  }

  @override
  void dispose() {
    widget.formBuilder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream: widget.formBuilder.bloc.stream,
          initialData: widget.formBuilder.bloc.getData(),
          builder: (context, snapshot) {
            return Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: widget.formBuilder.build(snapshot.error)),
            );
          }),
    );
  }
}

import 'package:flutter_test/flutter_test.dart';

import 'test.dart';


String errorText = "Please enter a full name.";


void main() {
  testWidgets(
      "Error_IS_RETURNED_WHEN_fullName_IS_Error-Invalid_Request",
      (tester) async {
        Test test = Test(tester);
        await test.loadField(errorText);
        expect(find.text(errorText), findsOneWidget);
      });
}

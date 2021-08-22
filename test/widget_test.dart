// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility that Flutter provides. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.

// import 'dart:async';
// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:toannm_test/feature/user/model/response.dart';
// import 'package:toannm_test/feature/user/repository/repository.dart';

// import 'package:http/http.dart' as http;
// import 'widget_test.mocks.dart';

// class _MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

// void runWithHttpOverride(Function() function) {
//   HttpOverrides.runWithHttpOverrides(() => function(), _MyHttpOverrides());
// }

// @GenerateMocks([http.Client])
// void main() {
//   // CustomizeTestBindings();

//   // HttpOverrides.global = _MyHttpOverrides();

//   group("User testing", () {
//     test('Unit test repository', () async {
//       final _client = MockClient();

//       final UserRepository _repository = UserRepository(Dio());
//       int _pageNumber = 1;

//       var userResponse = await _repository.getUsers(_pageNumber);

//       expect(userResponse, isA<UserResponse>());

//       List<UserResponse> userReponses = [];

//       while (_pageNumber <= (userResponse.totalPages ?? 0)) {
//         userReponses.add(await _repository.getUsers(_pageNumber));
//         _pageNumber++;
//       }

//       expect(userReponses.length, 2);
//     });
//   });
// }

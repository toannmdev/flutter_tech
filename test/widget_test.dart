// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:toannm_test/feature/user/model/response.dart';
import 'package:toannm_test/feature/user/repository/repository.dart';

import 'package:http/http.dart' as http;
import 'widget_test.mocks.dart';

class _MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void runWithHttpOverride(Function() function) {
  HttpOverrides.runWithHttpOverrides(() => function(), _MyHttpOverrides());
}

@GenerateMocks([http.Client])
void main() {
  // CustomizeTestBindings();

  // HttpOverrides.global = _MyHttpOverrides();

  group("User testing", () {
    test('Unit test repository', () async {
      // runWithHttpOverride(() async {

      final _client = MockClient();

      final UserRepository _repository = UserRepository(Dio());
      int _pageNumber = 1;

      var userResponse = await _repository.getUsers(_pageNumber);

      expect(userResponse, isA<UserResponse>());

      List<UserResponse> userReponses = [];

      while (_pageNumber <= (userResponse.totalPages ?? 0)) {
        userReponses.add(await _repository.getUsers(_pageNumber));
        _pageNumber++;
      }

      expect(userReponses.length, 2);

      /// test vui ve stream

      StreamController streamController = StreamController.broadcast();

      _pageNumber++;

      Stream userStream =
          streamController.stream; //_repository.streamUsers(_pageNumber);
      streamController.add(userResponse);

      while (_pageNumber <= (userResponse.totalPages ?? 0)) {
        streamController.add(await _repository.getUsers(_pageNumber));
        _pageNumber++;
      }

      await for (UserResponse _userResponse in userStream) {
        expect(_userResponse, isA<UserResponse>());
      }

      // expect(userStream, emitsInOrder([emits(userResponse)]));
      // expectLater(userStream, emitsInOrder([emits(userResponse)]));
    });
  });

  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // await Future.delayed(Duration(seconds: 1));
  //   print('safnjaksfjka');
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   // expect(find.text('1'), findsNothing);

  //   // // Tap the '+' icon and trigger a frame.
  //   // await tester.tap(find.byIcon(Icons.add));
  //   // await tester.pump();

  //   // // Verify that our counter has incremented.
  //   // expect(find.text('0'), findsNothing);
  //   // expect(find.text('1'), findsOneWidget);
  // });
}








// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:toannm_test/feature/user/repository/repository.dart';
// import 'package:toannm_test/main.dart';

// import 'widget_test.mocks.dart';

// // Generate a MockClient using the Mockito package.
// // Create new instances of this class in each test.
// @GenerateMocks([http.Client])
// void main() {
//   group('fetchAlbum', () {
//     test('returns an Album if the http call completes successfully', () async {
//       final client = MockClient();

//       // Use Mockito to return a successful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async =>
//               http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

//       when(client.post(Uri.parse('https://wwww.google.com')))
//           .thenAnswer((_) async => http.Response('{"title": "Test"}', 200));

//       final UserRepository _repository = UserRepository(Dio());

//       var response = await _repository.dio
//           .get("https://reqres.in/api/users", queryParameters: {"page": 1});
//       print('response -> ${response}');

//       expect(await fetchAlbum(client), isA<Album>());
//     });

//     test('throws an exception if the http call completes with an error', () {
//       final client = MockClient();

//       // Use Mockito to return an unsuccessful response when it calls the
//       // provided http.Client.
//       when(client
//               .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
//           .thenAnswer((_) async => http.Response('Not Found', 404));

//       expect(fetchAlbum(client), throwsException);
//     });
//   });
// }
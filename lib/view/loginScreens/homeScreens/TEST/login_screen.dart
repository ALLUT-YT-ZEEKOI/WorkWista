// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:workwista/view/loginScreens/homeScreens/TEST/home_screen.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool isLoading = false;

//   final GoogleSignIn _googleSignIn = GoogleSignIn(
//       scopes: ['email', 'profile'],
//       serverClientId:
//           '877049429462-45rfki3okpgcl8nrevnr3bc9vi0420ou.apps.googleusercontent.com' //web cleint id
//       );

//   Future<void> handleGoogleSignIn() async {
//     setState(() => isLoading = true);
//     try {
//       final GoogleSignInAccount? account = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication? auth = await account?.authentication;
//       final String? idToken = auth?.idToken;
//       log("id toke :${idToken.toString()}");

//       if (idToken == null) {
//         log("id toke :${idToken.toString()}");
//         showError('Failed to get ID token');
//         return;
//       }

//       final response = await http.post(
//         Uri.parse(
//             'https://workwista.com/google_mobile_auth/'), // Update to match your backend
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'idToken': idToken}),
//       );
//       log("id toke :${idToken.toString()}");
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final accessToken = data['access_token'];
//         final refreshToken = data['refresh_token'];
//         final user = data['user'];
//         log("id toke :${idToken.toString()}");
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (_) => HomeScreen(
//                 refresh_token: refreshToken, user: user, token: accessToken),
//           ),
//         );
//       } else {
//         final errorData = jsonDecode(response.body);
//         showError(errorData['error'] ?? 'Server error');
//       }
//     } catch (e) {
//       log('Sign-in error: $e');
//       showError('Google sign-in failed');
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }

//   void showError(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message), backgroundColor: Colors.red),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Login with Google')),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : ElevatedButton.icon(
//                 icon: Icon(Icons.login),
//                 label: Text('Sign in with Google'),
//                 onPressed: handleGoogleSignIn,
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   textStyle: TextStyle(fontSize: 16),
//                 ),
//               ),
//       ),
//     );
//   }
// }

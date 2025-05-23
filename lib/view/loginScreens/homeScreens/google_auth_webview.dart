// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// try async {
//   final GoogleSignInAccount? account = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication? auth = await account?.authentication;
//   final String? idToken = auth?.idToken;

//   if (idToken == null) {
//     showError('Failed to get ID token');
//     return;
//   }

//   final response = await http.post(
//     Uri.parse('http://192.168.3.36:8000/api/auth/google/'), // Update to match your backend
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode({'id_token': idToken}),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final accessToken = data['access_token'];
//     final user = data['user'];

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(
//         builder: (_) => HomeScreen(user: user, token: accessToken),
//       ),
//     );
//   } else {
//     final errorData = jsonDecode(response.body);
//     showError(errorData['error'] ?? 'Server error');
//   }
// } catch (e) {
//   print('Sign-in error: $e');
//   showError('Google sign-in failed');
// } finally {
//   setState(() => isLoading = false);
// }

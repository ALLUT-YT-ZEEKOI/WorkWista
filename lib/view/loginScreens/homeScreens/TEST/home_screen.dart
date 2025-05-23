// import 'dart:developer';

// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   final Map user;
//   final String token;
//   final String refresh_token;

//   const HomeScreen({required this.refresh_token,required this.user, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome ${user['name'] ?? ''}'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Email: ${user['email']}"),
//             SizedBox(height: 10),
//             Text("JWT Token:"),
//             SizedBox(height: 5),
//             SelectableText(token),
//             SizedBox(height: 20),
//             CircleAvatar(
//               radius: 40,
//               backgroundImage: NetworkImage(user['profile_picture_google'] ??
//                   'https://imgs.search.brave.com/0ush_RwIRUHmHpMykz2nWvqFNV_E43gCU1XPAXRgFqY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWdz/LnNlYXJjaC5icmF2/ZS5jb20vRko2eVBi/ZDJKMGlhUmotRlZm/RHFRWmZ3MDlHRFB4/MC1hMUlRR2pSbU8t/cy9yczpmaXQ6NTAw/OjA6MDowL2c6Y2Uv/YUhSMGNITTZMeTkx/ZUhkcC9ibWN1WTI5/dEwzZHdMV052L2Ju/UmxiblF2ZEdobGJX/VnovTDNWNGQybHVa/eTlrYjNkdS9iRzlo/WkM5d1pXOXdiR1Z6/L0xXRjJZWFJoY25N/dmJtOHQvY0hKdlpt/bHNaUzF3YVdOMC9k/WEpsTFdsamIyNHVj/RzVu'),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   log('access_token :${token.toString()}');
//                 },
//                 child: Text("log access token")),

//                   ElevatedButton(
//                 onPressed: () {
//                   log('refresh_token :${refresh_token.toString()}');
//                 },
//                 child: Text("log refresh token")),
//           ],
//         ),
//       ),
//     );
//   }
// }

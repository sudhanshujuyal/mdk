import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository
{
  static GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '579318702592-rr9aqi21gtkrkhuevht2kgq218d7581r.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
}
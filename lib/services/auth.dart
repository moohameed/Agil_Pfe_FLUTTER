import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future<void> signUpNode(String username,String email, String password) async {
   // var url = "the api call";
    // final http.Response response = await http.post(
    //  url,
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    // body: jsonEncode(<String, String>{
    //   'username' : username,
    //  'email': email,
    //  'password': password,
    // }),
    // );

    //if (response.statusCode == 201) {
    // setToken('token') ;
    //} else {
    //  throw Exception('Failed to sign up ');
    //}

  }

  Future<AuthResult> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return authResult;
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
 // token Interceptions
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('token') ;
}


}

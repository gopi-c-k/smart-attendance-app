import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static String USERNAME ='';
  static String PASSWORD ='';
  static String REGISTERNUMBER='';  // Assuming register number is part of user data

  static Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    USERNAME = prefs.getString('userID') ?? '';
    PASSWORD = prefs.getString('password') ?? '';
    REGISTERNUMBER = prefs.getString('registerNumber') ?? '';
  }
}
final url = 'https://6718-2409-408d-213-d1be-650b-aa65-9e1d-c54e.ngrok-free.app/';
//final url = 'http://localhost:2000/';

//final StudentLoginRouters = 'https://bde0-2409-408d-61b-cb95-87fb-fab-f2a2-d74e.ngrok-free.app/StudentLogin';

/*

gopi@gopi:~$ curl -X POST -H "Content-Type: application/json" -d '{"NewUserID": "GOPICK2004"}' https://73fc-2409-408d-21f-b85c-b301-dc0b-bbe1-1c05.ngrok-free.app/22MIS0058/changeUserID



*/

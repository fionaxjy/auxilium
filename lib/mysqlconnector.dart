import 'package:sqljocky5/sqljocky.dart';
import 'mysqlqueries.dart';
/*UserID, PersonName, MobileNo, BankAccNo, Bio*/

class UserInfo {
  String userID;
  String personName;
  int mobileNo;
  int bankAccNo;
  String bio;

  UserInfo(String inUserID, String inPersonName, int inMobileNo,
      int inBankAccNo, String inBio) {
    userID = inUserID;
    personName = inPersonName;
    mobileNo = inMobileNo;
    bankAccNo = inBankAccNo;
    bio = inBio;
  }
}

testsql(UserInfo addUser) async {
  var s = ConnectionSettings(
    user: "root",
    password: "password",
    host: "localhost",
    port: 3306,
    db: "Auxilium",
  );

  // create a connection
  print("Opening connection ...");
  var conn = await MySqlConnection.connect(s);
  print("Opened connection!");

  // await dropTables(conn);
  // await createTables(conn); // should not be happening once database is finalised, but will leave for now

  await findUser(conn, addUser);
  await readData(conn);
  await conn.close();
  print('done');
}

import 'package:sqljocky5/sqljocky.dart';

/// Drops the tables if they already exist
Future<void> dropTables(MySqlConnection conn) async {
  print("Dropping tables ...");
  await conn.execute("DROP TABLE IF EXISTS DONATE;");
  await conn.execute("DROP TABLE IF EXISTS SAVEDPOST;");
  await conn.execute("DROP TABLE IF EXISTS POSTCOMMENT;");
  await conn.execute("DROP TABLE IF EXISTS POST;");
  await conn.execute("DROP TABLE IF EXISTS NOTIFICATION;");
  await conn.execute("DROP TABLE IF EXISTS PERSON;");
  print("Dropped tables!");
}

Future<void> createTables(MySqlConnection conn) async {
  print("Creating tables ...");

  // person i.e. User
  await conn.execute('CREATE TABLE PERSON ('
      'UserID				    VARCHAR(30)			NOT NULL, '
      'PersonName 	  	VARCHAR(30) 		NOT NULL, '
      'MobileNo 			  VARCHAR(30) 		NOT NULL, '
      'BankAccNo 			  VARCHAR(17), '
      'Bio 			      	VARCHAR(150), '
      'PRIMARY KEY (UserID))');

  // notification
  await conn.execute('CREATE TABLE NOTIFICATION('
      'NotificationID 	VARCHAR(30)			NOT NULL, '
      'DateAndTime 		  TIMESTAMP			  NOT NULL,'
      'UserID				    VARCHAR(30)			NOT NULL,'
      'PRIMARY KEY(NotificationID),'
      'FOREIGN KEY(UserID) REFERENCES PERSON(UserID));');

// post
  await conn.execute('CREATE TABLE POST('
      'PostID 				  VARCHAR(30)			NOT NULL,'
      'DateAndTime 		  TIMESTAMP			  NULL,'
      'CommentCount 		INTEGER				  DEFAULT 0,'
      'TotalAmount			DECIMAL(19,2)		DEFAULT 0,'
      'CurrentAmount		DECIMAL(19,2)		DEFAULT 0,'
      'CauseTag			    ENUM (\'Food\', \'Healthcare\', \'Job\', \'Other\', \'Supplies/Tools\', \'Funds\', \'Space\', \'Labor/Service\') NOT NULL,'
      'ReqOrDonTag			ENUM (\'Request\', \'Donate\'),'
      'UserID				    VARCHAR(30)			NOT NULL,'
      'NotificationID 	VARCHAR(30)		NOT NULL,'
      'PRIMARY KEY(PostID),'
      'FOREIGN KEY(UserID) REFERENCES PERSON(UserID),'
      'FOREIGN KEY(NotificationID) REFERENCES NOTIFICATION(NotificationID));');

  // comments
  await conn.execute('CREATE TABLE POSTCOMMENT('
      'DateAndTime 		  TIMESTAMP			  NOT NULL,'
      'UserID				    VARCHAR(30)			NOT NULL,'
      'PostID				    VARCHAR(30)			NOT NULL,'
      'CommentString		VARCHAR(2200)		NOT NULL,'
      'NotificationID		VARCHAR(30)			NOT NULL,'
      'PRIMARY KEY(DateAndTime, UserID, PostID),'
      'FOREIGN KEY(UserID) REFERENCES PERSON(UserID),'
      'FOREIGN KEY(PostID) REFERENCES POST(PostID),'
      'FOREIGN KEY(NotificationID) REFERENCES NOTIFICATION(NotificationID));');

  // donate
  await conn.execute('CREATE TABLE DONATE('
      'SerialNo			    VARCHAR(30)			NOT NULL,'
      'DonorID			  	VARCHAR(30)			NOT NULL,'
      'RecipientID			VARCHAR(30)			NOT NULL,'
      'NotificationID		VARCHAR(30)			NOT NULL,'
      'DonationType		  ENUM (\'Money\', \'Resources\') NOT NULL,'
      'DateAndTime 		  TIMESTAMP			  NOT NULL,'
      'DonationAmount		DECIMAL(19,2)		NOT NULL,'
      'CollectionMethod	ENUM (\'Postage\', \'Meet Up\', \'Collection Point\', \'Other\'),'
      'ItemCondition		ENUM (\'Brand New\', \'Used\'),'
      'PRIMARY KEY(SerialNo),'
      'FOREIGN KEY(DonorID) REFERENCES PERSON(UserID),'
      'FOREIGN KEY(RecipientID) REFERENCES PERSON(UserID),'
      'FOREIGN KEY(NotificationID) REFERENCES NOTIFICATION(NotificationID));');

  await conn.execute('CREATE TABLE SAVEDPOST('
      'PosterID			    VARCHAR(30)			NOT NULL,'
      'PostID				    VARCHAR(30)			NOT NULL,'
      'PRIMARY KEY(PosterID, PostID),'
      'FOREIGN KEY(PosterID) REFERENCES PERSON(UserID),'
      'FOREIGN KEY(PostID) REFERENCES POST(PostID));');
  print("Created table!");
}

Future<void> insertRows(MySqlConnection conn) async {
  print("Inserting rows ...");
  List<StreamedResults> r1 = await (await conn.preparedWithAll(
          "INSERT INTO PERSON (UserID, PersonName, MobileNo, BankAccNo, Bio) VALUES (?, ?, ?, ?, ?)",
          [
        ["dorothy", "Dorothy Yuan", "92700483", "01234567890", "Hello there!"],
        ["fiona", "Fiona Xiao", "84376698", "01234567890", "Wet Texter"]
      ])) // ??? ISSUE: CODE GETS STUCK HERE AND DOESNT CONTINUE. NOT SURE WHY.
      .toList();
  //print("Person table insert: " + r1.map((r) => r.insertId).toString());
  print("Rows inserted!");
}

Future<void> readData(MySqlConnection conn) async {
  Results result =
      await (await conn.execute('SELECT * FROM person;')).deStream();
  print(result);
  print(result.map((r) => r.byName('name')));
}

testsql() async {
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

  await dropTables(conn);
  await createTables(conn);
  await insertRows(conn);
  await readData(conn);

  await conn.close();
}

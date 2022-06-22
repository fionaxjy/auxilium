import 'package:sqljocky5/sqljocky.dart';

import 'mysqlconnector.dart';

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
      'MobileNo 			  VARCHAR(30), '
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

Future<void> newUser(MySqlConnection conn, UserInfo addUser) async {
  print('Creating user...');
  await conn.prepared(
      'INSERT INTO PERSON (UserID, PersonName, MobileNo, BankAccNo, Bio) VALUES (?, ?, ?, ?, ?)',
      [
        addUser.userID,
        addUser.personName,
        addUser.mobileNo,
        addUser.bankAccNo,
        addUser.bio
      ]);
  print('user created!');
}

Future<void> readData(MySqlConnection conn) async {
  Results result =
      await (await conn.execute('SELECT * FROM person;')).deStream();
  print(result);
  print(result.map((r) => r.byName('PersonName')));
}

Future<void> findUser(MySqlConnection conn, UserInfo addUser) async {
  print('Searching for $addUser...');
  Results results = await (await conn.execute(
          'SELECT UserID from PERSON where UserID = ${addUser.userID}'))
      .deStream();
  if (results.isEmpty) {
    newUser(conn, addUser);
  } else {
    print('User already exists');
  }
}

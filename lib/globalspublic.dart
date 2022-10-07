library my_prj.globals;

//API URL
String uriString = "http://phoenix.crossnet.co.id:38600";

//Radius URL
String radiusString = "http://10.5.50.22:38700";

//Token To API
String tokenString = "";

bool isLoggedIn = false;
bool internetConnection = false;
bool radiusConnection = false;
int numpagenya = 0;
String ipv4nya = "";

//User Information
//Might need some improvement in the future
//Vars
String currentUser = "";
int userID = 0;
String firstName = "",
    lastName = "",
    email = "",
    phoneNum = "",
    username = "",
    address = "";

void setUserID(int UID) {
  userID = UID;
}

int getUserID() {
  return userID;
}

void setUsername(String fn, String ln) {
  firstName = fn;
  lastName = ln;
}

String getUsername() {
  return firstName + " " + lastName;
}

//Payments Options

bool userChoice = false;
String paymentChoice = "";

//Chatting
bool inChatSession = false;

//Usage
bool usageFetching = false;

//Store Individual Usage Information
class individualUsageContainer {
  late String Username;
  late int uploadValue, downloadValue, uptime; //In Bytes and Seconds;
}

late individualUsageContainer indivUsa;

//Store Package Usage Information
class packageBulk {
  late List<individualUsageContainer> bulk;
}

late packageBulk package;

List<packageBulk> userPackageInformation = [];

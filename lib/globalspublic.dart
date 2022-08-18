library my_prj.globals;

//API URL
String uriString = "http://192.168.1.4:38600";

bool isLoggedIn = false;
int numpagenya = 0;
String ipv4nya = "";

//User Information
//Might need some improvement in the future
//Vars
int userID = 0;
String firstName = "", lastName = "", email = "", phoneNum = "";

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

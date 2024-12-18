Map<String, dynamic> loginDetail = {
  "detail" :[
    {
    "Fullname" : "username",
    "phoneNumber" : "phoneNumber",
    "Email" : "Email",
    "password" : "password",
    "pin" : 12345

     },
     {
    "Fullname" : "username",
    "phoneNumber" : "phoneNumber",
    "Email" : "Email",
    "password" : "Password",
    "pin" : 12345
     },
  ]

};

bool checkLoginDetails({required String Email,required String password, required String phoneNumber,bool? cek } ) {
  cek = false;

  for (var value in loginDetail['detail']) {
    if ((value['Email'] == Email || value['phoneNumber'] == phoneNumber)&& value['password'] == password && cek == false) {
      return true; 
      }
      else if((value['Email'] == Email || value['phoneNumber'] == phoneNumber) && cek == true){
        return true;
      }
  }
  return false;  
}

bool addLoginDetail({required String Email, required String password, required String phoneNumber,required String nama}){
 
  if(Email.length < 5 || password.length < 5 ){
    print("Email: $Email, password: $password");
    return false;

  }

  if(checkLoginDetails(Email: Email, password: password, phoneNumber: phoneNumber ,cek: true)){
    print("ada salah");
    return false;
  }

  loginDetail['detail'].add({
    'Email' : Email,
    'phoneNumber' : phoneNumber,
    'password': password,
    'nama' : nama,
    'pin': 12345,
  });
  return true;
  
}


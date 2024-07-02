class User {
  String userName;
  String fullName;
  String nic;
  String contactNumber;
  String email;
  String gender;
  String address;
  String city;
  String district;
  String province;
  String userPassword;

  User({
    required this.userName,
    required this.fullName,
    required this.nic,
    required this.contactNumber,
    required this.email,
    required this.gender,
    required this.address,
    required this.city,
    required this.district,
    required this.province,
    required this.userPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'fullName': fullName,
      'nic': nic,
      'contactNumber': contactNumber,
      'email': email,
      'gender': gender,
      'address': address,
      'city': city,
      'district': district,
      'province': province,
      'userPassword': userPassword,
    };
  }
}

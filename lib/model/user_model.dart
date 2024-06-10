class UserModel {
  final int? id;
  final String? role;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? dateOfBirth;
  final String? nationality;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? pinCode;
  final String? phone;
  final String? accessToken;

  UserModel({
    this.id,
    this.role,
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.dateOfBirth,
    this.nationality,
    this.address,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.phone,
    this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['_id'] ?? 1,
        role: json['role'] ?? "",
        accessToken: json['token'] ?? "",
        firstName: json['first_name'] ?? "",
        lastName: json['last_name'] ?? "",
        email: json['email'] ?? "",
        gender: json['gender'] ?? "",
        dateOfBirth: json['date_of_birth'] ?? "",
        nationality: json['nationality'] ?? "",
        address: json['address'] ?? "",
        city: json['city'] ?? "",
        state: json['state'] ?? "",
        country: json['country'] ?? "",
        pinCode: json['pin_code'] ?? "",
        phone: json['phone'] ?? "");
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'role': role,
      'token': accessToken,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'nationality': nationality,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'pin_code': pinCode,
      'phone': phone
    };
  }
}

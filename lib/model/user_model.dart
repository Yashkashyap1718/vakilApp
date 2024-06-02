class UserModel {
  final String? id;
  final String? countryCode;
  final String? phone;
  final String? referralCode;
  final bool? verified;
  final String? otp;
  final String? otpForgetPassword;
  final String? role;
  final String? token;
  final String? pushNotification;
  final int? createdAt;
  final int? updatedAt;
  final int? v;
  final String? status;
  final String? suspend;

  UserModel({
    this.id,
    this.countryCode,
    this.phone,
    this.referralCode,
    this.verified,
    this.otp,
    this.otpForgetPassword,
    this.role,
    this.token,
    this.pushNotification,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
    this.suspend,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'country_code': countryCode,
      'phone': phone,
      'referral_code': referralCode,
      'verified': verified,
      'otp': otp,
      'otpForgetPassword': otpForgetPassword,
      'role': role,
      'token': token,
      'push_notification': pushNotification,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
      'status': status,
      'suspend': suspend,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      countryCode: json['country_code'],
      phone: json['phone'],
      referralCode: json['referral_code'],
      verified: json['verified'],
      otp: json['otp'],
      otpForgetPassword: json['otpForgetPassword'],
      role: json['role'],
      token: json['token'],
      pushNotification: json['push_notification'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      status: json['status'],
      suspend: json['suspend'],
    );
  }
}

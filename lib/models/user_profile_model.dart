class UserProfile {
  final String id;
  final String uniqueId;
  final String name;
  final String email;
  final String phone;
  final String country;
  final Address address;

  UserProfile({
    required this.id,
    required this.uniqueId,
    required this.name,
    required this.email,
    required this.phone,
    required this.country,
    required this.address,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'] ?? '',
      uniqueId: json['unique_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      country: json['country'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

class Address {
  final String country;
  final String state;
  final String district;
  final String city;
  final String zip;

  Address({
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      city: json['city'] ?? '',
      zip: json['zip'] ?? '',
    );
  }
}

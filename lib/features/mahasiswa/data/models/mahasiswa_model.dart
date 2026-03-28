class MahasiswaModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;

  MahasiswaModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) {
    return MahasiswaModel(
      id: json['id'],
      name: json['name'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      address: Address.fromJson(json['address'] ?? {}),
    );
  }
}

// ================= ADDRESS =================

class Address {
  final String street;
  final String suite;
  final String city;

  Address({
    required this.street,
    required this.suite,
    required this.city,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'] ?? '',
      suite: json['suite'] ?? '',
      city: json['city'] ?? '',
    );
  }
}
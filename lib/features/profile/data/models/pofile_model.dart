class ProfileModel {
  final String nama;
  final String email;
  final String jurusan;
  final String role;

  ProfileModel({
    required this.nama,
    required this.email,
    required this.jurusan,
    required this.role,
  });

  /// Convert dari JSON ke Object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      nama: json['nama'] ?? '',
      email: json['email'] ?? '',
      jurusan: json['jurusan'] ?? '',
      role: json['role'] ?? '',
    );
  }

  /// Convert Object ke JSON
  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'email': email,
      'jurusan': jurusan,
      'role': role,
    };
  }

  /// CopyWith (biar konsisten sama model lain)
  ProfileModel copyWith({
    String? nama,
    String? email,
    String? jurusan,
    String? role,
  }) {
    return ProfileModel(
      nama: nama ?? this.nama,
      email: email ?? this.email,
      jurusan: jurusan ?? this.jurusan,
      role: role ?? this.role,
    );
  }
}
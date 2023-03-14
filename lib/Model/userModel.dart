class User {
  String idUser;
  String usernameUser;
  String emailUser;
  String passwordUser;
  String noTelpUser;
  String codeUser;
  String codeExpireUser;
  String createdAtUser;
  String verifiedUser;
  String idWilayah;
  String namaWilayah;

  User(
      {this.idUser,
      this.usernameUser,
      this.emailUser,
      this.passwordUser,
      this.noTelpUser,
      this.codeUser,
      this.codeExpireUser,
      this.createdAtUser,
      this.verifiedUser,
      this.idWilayah,
      this.namaWilayah});

  User.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    usernameUser = json['username_user'];
    emailUser = json['email_user'];
    passwordUser = json['password_user'];
    noTelpUser = json['no_telp_user'];
    codeUser = json['code_user'];
    codeExpireUser = json['code_expire_user'];
    createdAtUser = json['created_at_user'];
    verifiedUser = json['verified_user'];
    idWilayah = json['uid_wilayah'];
    namaWilayah = json['nama_wilayah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['username_user'] = this.usernameUser;
    data['email_user'] = this.emailUser;
    data['password_user'] = this.passwordUser;
    data['no_telp_user'] = this.noTelpUser;
    data['code_user'] = this.codeUser;
    data['code_expire_user'] = this.codeExpireUser;
    data['created_at_user'] = this.createdAtUser;
    data['verified_user'] = this.verifiedUser;
    data['uid_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    return data;
  }
}

class myJamOperasional {
  String id;
  String hari;
  String jamBuka;
  String jamTutup;
  String uidAkun;
  String idWilayah;
  String namaWilayah;

  myJamOperasional(
      {this.id,
      this.hari,
      this.jamBuka,
      this.jamTutup,
      this.uidAkun,
      this.idWilayah,
      this.namaWilayah});

  myJamOperasional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hari = json['hari'];
    jamBuka = json['jam_buka'];
    jamTutup = json['jam_tutup'];
    uidAkun = json['uid_akun'];
    idWilayah = json['id_wilayah'];
    namaWilayah = json['nama_wilayah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hari'] = this.hari;
    data['jam_buka'] = this.jamBuka;
    data['jam_tutup'] = this.jamTutup;
    data['uid_akun'] = this.uidAkun;
    data['id_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    return data;
  }
}

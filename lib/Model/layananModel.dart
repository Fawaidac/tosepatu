class myLayanan {
  String idLayanan;
  String namaLayanan;
  int hargaLayanan;
  String fotoLayanan;
  String desciption;
  String uidAkun;
  String createdAt;
  String updatedAt;
  String idWilayah;
  String namaWilayah;
  String statusToko;

  myLayanan(
      {this.idLayanan,
      this.namaLayanan,
      this.hargaLayanan,
      this.fotoLayanan,
      this.desciption,
      this.uidAkun,
      this.createdAt,
      this.updatedAt,
      this.idWilayah,
      this.namaWilayah,
      this.statusToko});

  myLayanan.fromJson(Map<String, dynamic> json) {
    idLayanan = json['id_layanan'];
    namaLayanan = json['nama_layanan'];
    hargaLayanan = int.parse(json['harga_layanan']);
    fotoLayanan = json['foto_layanan'];
    desciption = json['desciption'];
    uidAkun = json['uid_akun'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idWilayah = json['id_wilayah'];
    namaWilayah = json['nama_wilayah'];
    statusToko = json['status_toko'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_layanan'] = this.idLayanan;
    data['nama_layanan'] = this.namaLayanan;
    data['harga_layanan'] = this.hargaLayanan;
    data['foto_layanan'] = this.fotoLayanan;
    data['desciption'] = this.desciption;
    data['uid_akun'] = this.uidAkun;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    data['status_toko'] = this.statusToko;
    return data;
  }
}

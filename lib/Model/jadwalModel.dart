class myJadwal {
  String hari;
  String idWilayah;
  String namaWilayah;
  String statusToko;
  String jamBuka;
  String jamTutup;

  myJadwal(
      {this.hari,
      this.idWilayah,
      this.namaWilayah,
      this.statusToko,
      this.jamBuka,
      this.jamTutup});

  myJadwal.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    idWilayah = json['id_wilayah'];
    namaWilayah = json['nama_wilayah'];
    statusToko = json['status_toko'];
    jamBuka = json['jam_buka'];
    jamTutup = json['jam_tutup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hari'] = this.hari;
    data['id_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    data['status_toko'] = this.statusToko;
    data['jam_buka'] = this.jamBuka;
    data['jam_tutup'] = this.jamTutup;
    return data;
  }
}

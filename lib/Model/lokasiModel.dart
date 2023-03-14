class myLokasi {
  String idWilayah;
  String namaWilayah;
  String statusToko;

  myLokasi({this.idWilayah, this.namaWilayah, this.statusToko});

  myLokasi.fromJson(Map<String, dynamic> json) {
    idWilayah = json['id_wilayah'];
    namaWilayah = json['nama_wilayah'];
    statusToko = json['status_toko'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    data['status_toko'] = this.statusToko;
    return data;
  }
}

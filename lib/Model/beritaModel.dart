class myBerita {
  String idBerita;
  String namaBerita;
  String fotoBerita;
  String descriptionBerita;
  String potongan;
  String uidKategoriBerita;
  String statusBerita;
  String idWilayah;
  String namaWilayah;
  String statusToko;

  myBerita(
      {this.idBerita,
      this.namaBerita,
      this.fotoBerita,
      this.descriptionBerita,
      this.potongan,
      this.uidKategoriBerita,
      this.statusBerita,
      this.idWilayah,
      this.namaWilayah,
      this.statusToko});

  myBerita.fromJson(Map<String, dynamic> json) {
    idBerita = json['id_berita'];
    namaBerita = json['nama_berita'];
    fotoBerita = json['foto_berita'];
    descriptionBerita = json['description_berita'];
    potongan = json['potongan'];
    uidKategoriBerita = json['uid_kategori_berita'];
    statusBerita = json['status_berita'];
    idWilayah = json['id_wilayah'];
    namaWilayah = json['nama_wilayah'];
    statusToko = json['status_toko'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_berita'] = this.idBerita;
    data['nama_berita'] = this.namaBerita;
    data['foto_berita'] = this.fotoBerita;
    data['description_berita'] = this.descriptionBerita;
    data['potongan'] = this.potongan;
    data['uid_kategori_berita'] = this.uidKategoriBerita;
    data['status_berita'] = this.statusBerita;
    data['id_wilayah'] = this.idWilayah;
    data['nama_wilayah'] = this.namaWilayah;
    data['status_toko'] = this.statusToko;
    return data;
  }
}

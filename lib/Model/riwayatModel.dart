class myRiwayat {
  String tanggalMasuk;
  String statusPesanan;
  String namaLayanan;
  String grandTotal;

  myRiwayat(
      {this.tanggalMasuk,
      this.statusPesanan,
      this.namaLayanan,
      this.grandTotal});

  myRiwayat.fromJson(Map<String, dynamic> json) {
    tanggalMasuk = json['tanggal_masuk'];
    statusPesanan = json['status_pesanan'];
    namaLayanan = json['nama_layanan'];
    grandTotal = json['grand_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tanggal_masuk'] = this.tanggalMasuk;
    data['status_pesanan'] = this.statusPesanan;
    data['nama_layanan'] = this.namaLayanan;
    data['grand_total'] = this.grandTotal;
    return data;
  }
}

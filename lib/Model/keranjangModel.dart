class myKeranjang {
  String idKeranjang;
  String uidAkunUser;
  String uidLayanan;
  int qty;
  String subTotal;
  String namaLayanan;
  int hargaLayanan;
  String fotoLayanan;

  myKeranjang(
      {this.idKeranjang,
      this.uidAkunUser,
      this.uidLayanan,
      this.qty,
      this.subTotal,
      this.namaLayanan,
      this.hargaLayanan,
      this.fotoLayanan});

  myKeranjang.fromJson(Map<String, dynamic> json) {
    idKeranjang = json['id_keranjang'];
    uidAkunUser = json['uid_akun_user'];
    uidLayanan = json['uid_layanan'];
    qty = int.parse(json['qty']);
    subTotal = json['sub_total'];
    namaLayanan = json['nama_layanan'];
    hargaLayanan = int.parse(json['harga_layanan']);
    fotoLayanan = json['foto_layanan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_keranjang'] = this.idKeranjang;
    data['uid_akun_user'] = this.uidAkunUser;
    data['uid_layanan'] = this.uidLayanan;
    data['qty'] = this.qty;
    data['sub_total'] = this.subTotal;
    data['nama_layanan'] = this.namaLayanan;
    data['harga_layanan'] = this.hargaLayanan;
    data['foto_layanan'] = this.fotoLayanan;
    return data;
  }
}

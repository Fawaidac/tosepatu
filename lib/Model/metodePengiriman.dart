class myPengiriman {
  String idPengiriman;
  String namaPengiriman;
  String descriptionPengiriman;
  String createdAtPengiriman;
  String updatedAtPengiriman;

  myPengiriman(
      {this.idPengiriman,
      this.namaPengiriman,
      this.descriptionPengiriman,
      this.createdAtPengiriman,
      this.updatedAtPengiriman});

  myPengiriman.fromJson(Map<String, dynamic> json) {
    idPengiriman = json['id_pengiriman'];
    namaPengiriman = json['nama_pengiriman'];
    descriptionPengiriman = json['description_pengiriman'];
    createdAtPengiriman = json['created_at_pengiriman'];
    updatedAtPengiriman = json['updated_at_pengiriman'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pengiriman'] = this.idPengiriman;
    data['nama_pengiriman'] = this.namaPengiriman;
    data['description_pengiriman'] = this.descriptionPengiriman;
    data['created_at_pengiriman'] = this.createdAtPengiriman;
    data['updated_at_pengiriman'] = this.updatedAtPengiriman;
    return data;
  }
}

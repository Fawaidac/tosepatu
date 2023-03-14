import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tosepatu/Api/Api_connect.dart';
import 'package:tosepatu/CurrentUser/CurrentUser.dart';
import 'package:tosepatu/Model/beritaModel.dart';
import 'package:tosepatu/Model/jadwalModel.dart';
import 'package:tosepatu/Model/jamOperasionalModel.dart';
import 'package:tosepatu/Model/keranjangModel.dart';
import 'package:tosepatu/Model/layananModel.dart';
import 'package:tosepatu/Model/metodePengiriman.dart';
import 'package:tosepatu/Model/productModel.dart';
import 'package:tosepatu/Model/riwayatModel.dart';

class ApiServices {
  CurrentUser currentUser = CurrentUser();

  Future<List<myJadwal>> getJamOperasional(String idWilayah) async {
    final response = await http.post(Uri.parse(Api.jamoperasional), body: {
      "id_wilayah": idWilayah,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myJadwal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myLayanan>> getLayanan(String idWilayah) async {
    final response = await http.post(Uri.parse(Api.product), body: {
      "id_wilayah": idWilayah,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myLayanan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myBerita>> getPromo(String idWilayah) async {
    final response = await http.post(Uri.parse(Api.berita),
        body: {"id_wilayah": idWilayah, "uid_kategori_berita": "BRT220921001"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myBerita.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myBerita>> getBerita(String wilayah) async {
    final response = await http.post(Uri.parse(Api.berita),
        body: {"id_wilayah": wilayah, "uid_kategori_berita": "BRT220921002"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myBerita.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myKeranjang>> getKeranjang() async {
    final response = await http.post(Uri.parse(Api.readkeranjang), body: {
      "uid_akun_user": currentUser.user.idUser,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myKeranjang.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myRiwayat>> getRiwayat() async {
    final response = await http.post(Uri.parse(Api.riwayat), body: {
      "uid_user": currentUser.user.idUser,
    });
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myRiwayat.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myRiwayat>> getRiwayatStatus(String status) async {
    final response = await http.post(Uri.parse(Api.riwayatstatus),
        body: {"uid_user": currentUser.user.idUser, "status_pesanan": status});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myRiwayat.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<myPengiriman>> getPengiriman() async {
    final response = await http.get(Uri.parse(Api.pengiriman));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => myPengiriman.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

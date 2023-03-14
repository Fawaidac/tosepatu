import 'package:get/get.dart';
import 'package:tosepatu/CurrentUser/RememberUser.dart';
import 'package:tosepatu/Model/userModel.dart';

class CurrentUser extends GetxController {
  static final CurrentUser _instance = CurrentUser._internal();

  CurrentUser._internal();

  factory CurrentUser() => _instance;

  final Rx<User> _currentUser = User(
          idUser: '',
          usernameUser: '',
          emailUser: '',
          passwordUser: '',
          noTelpUser: '',
          codeUser: '',
          codeExpireUser: '',
          createdAtUser: '',
          verifiedUser: '',
          idWilayah: '',
          namaWilayah: '')
      .obs;

  User get user => _currentUser.value;

  Future<User> getUserInfo() async {
    User getUserLocalStorage = await RememberUser.readUser();
    _currentUser.value = getUserLocalStorage;
    return Future.value(getUserLocalStorage);
  }
}

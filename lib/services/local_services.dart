import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';

class LocalServices {
  static const _localStorage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyQForm = 'qForm';
  static const _keyUser = 'user';
  static const _keyCountryList = 'countryList';

  //write token
  static Future storeToken(String token) async {
    await _localStorage.write(
      key: _keyToken,
      value: token,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

//read token
  static Future<String?> getToken() async {
    return await _localStorage.read(key: _keyToken,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
  }




  //write token
  static Future storeQForm(String qForm) async {
    await _localStorage.write(
      key: _keyQForm,
      value: qForm,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }
//read token
  static Future<String?> getQForm() async {
    return await _localStorage.read(key: _keyQForm,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
  }




  //store user
  Future storeUser(UserDataModel user) async {
    final value = json.encode(user);
    await _localStorage.write(key: _keyUser, value: value,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
  }

  //read user
  static Future<UserDataModel?> getUser() async {
    final value = await _localStorage.read(key: _keyUser,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
    return value == null ? null : UserDataModel.fromJson(json.decode(value));
  }

  //store user
  Future storeCountryList(CountryListModel user) async {
    final value = json.encode(user);
    await _localStorage.write(key: _keyCountryList, value: value,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
  }

  //read user
  static Future<CountryListModel?> getCountryList() async {
    final value = await _localStorage.read(key: _keyCountryList,iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),);
    return value == null ? null : CountryListModel.fromJson(json.decode(value));
  }

  static Future deleteData() async => await _localStorage.deleteAll(iOptions: _getIOSOptions(),
    aOptions: _getAndroidOptions(),);

 static IOSOptions _getIOSOptions() => const IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      );

 static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
}

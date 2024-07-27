
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iecc/app/data/my_drawer_controller.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/services/remote_services.dart';

import '../../../../constraints/api_end_points.dart';


class EditProfilePageController extends GetxController {
  var userData = UserDataModel().obs;

  var isLoading = false.obs;
  var disableOffice=true.obs;

  //office dropdown
  final officeList = <SingleOffice>[].obs;
  final selectedOffice = SingleOffice().obs;

  //country dropdown
  final countryList = <SingleCountry>[].obs;
  final selectedCountry = SingleCountry().obs;
  final selectedPhoneCountry = SingleCountry().obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final occupationController = TextEditingController();
  final officeController=TextEditingController();
  final phoneCountryController=TextEditingController();

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }


  @override
  void onClose() {}

  Future<void> getUserData() async {
    await LocalServices.getUser().then((value) {
      if (value != null) {
        userData.value = value;
      }
    });
  }

  void preLoadFormData() {


    nameController.text = userData.value.name ?? "";
    emailController.text = userData.value.email ?? "";
    countryController.text = userData.value.country.toString();
    occupationController.text = userData.value.sourceOccupation??"";
    selectedCountry.value=userData.value.country!=null?countryList[countryList.indexWhere((element) => element.id==userData.value.country)]:countryList[0];
   try{
     selectedOffice.value=userData.value.officeId!=null?officeList[officeList.indexWhere((element) => element.id==userData.value.officeId)]:officeList[0];
   }catch(e){
     selectedOffice.value=SingleOffice();
     disableOffice.value=false;
   }

    if(userData.value.phoneCountryId!=null){
      selectedPhoneCountry.value=countryList[countryList.indexWhere((element) => element.id==userData.value.phoneCountryId)];
      phoneController.text=userData.value.phone!.replaceAll("+${selectedPhoneCountry.value.callingCode}", "");

    }else {
      selectedPhoneCountry.value = countryList[0];
      phoneController.text = userData.value.phone!.replaceAll(
          "+${selectedCountry.value.callingCode}", "");
    }
    phoneCountryController.text=selectedPhoneCountry.value.iso31662??"";
     countryController.text=countryList[countryList.indexWhere((element) => element.id==userData.value.country)].name??"";
    cityController.text=userData.value.city??"";
    officeController.text=selectedOffice.value.name??"";
  }

  void updateUser() async{
    isLoading.value=true;
    var endPoint=APIEndPoints.updateProfile;
    var body={
      "office_id":selectedOffice.value.id.toString(),
      "user_name":nameController.text,
      "phone":"+${selectedPhoneCountry.value.callingCode}${phoneController.text}",
      "country":selectedCountry.value.id.toString(),
      "city":cityController.text,
      "source_occupation":occupationController.text,
      "phone_country_id":selectedPhoneCountry.value.id.toString()
    };


    await RemoteServices.postRequest(endPoint: endPoint,body: body).then((value) {
      if(value!=null){
        isLoading.value=false;
        CustomSnackBar(
            msg: value["msg"],
            isSuccess: true
        ).showSnackBar();
        var drawerController=Get.put(MyDrawerController());
        drawerController.reloadUserData();
      }else{
        CustomSnackBar(
          msg: APIEndPoints.httpErrorMSG.value,
          isSuccess: false
        ).showSnackBar();
        isLoading.value=false;
      }
    });
  }

  Future<void> getCountryList() async {
    await RemoteServices.getCountryList().then((value) {
      if (value != null) {
        countryList.value = value;
        selectedCountry.value=countryList[0];
      }
    });
  }

  Future<void> getOfficeData() async {
    officeList.value = [];
    await RemoteServices.getRequest(endPoint: APIEndPoints.officeList)
        .then((value) {
      var officeListModel = OfficeListModel();
      if (value != null) {
        officeListModel = OfficeListModel.fromJson(value);
        officeList.value = officeListModel.data ?? [];
        selectedOffice.value=officeList[0];
        // officeListModel.data?.forEach((element) {officeDropdownItems.add(element.name??""); });
      }
      isLoading.value = false;
    });
  }

  void fetchData() async {
    isLoading.value=true;
    disableOffice.value=true;
    await getUserData().then((value) async {
      await getCountryList().then((value) async {
        await getOfficeData().then((value) {
          preLoadFormData();
          isLoading.value=false;
        });
      });
    });
  }
}

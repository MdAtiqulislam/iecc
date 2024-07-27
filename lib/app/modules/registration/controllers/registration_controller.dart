import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/otpPage/controllers/otp_page_controller.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/modules/registration/models/office_list_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';

import '../../../../constraints/api_end_points.dart';
import '../../../../services/remote_services.dart';

class RegistrationController extends GetxController {
  final isLoading = true.obs;
  final isEmailExist = false.obs;

  //office dropdown
  final officeList = <SingleOffice>[].obs;
  final selectedOffice = SingleOffice().obs;

  //country dropdown
  final countryList = <SingleCountry>[].obs;
  final selectedCountry = SingleCountry().obs;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final occupationController=TextEditingController();
  final officeController=TextEditingController();

  final selectedPhoneCountry=SingleCountry().obs;

  var phoneCountryController=TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();

  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    countryController.dispose();
    cityController.dispose();
    occupationController.dispose();
  }

  @override
  void onClose() {}

  Future<void> getOfficeData() async {
    officeList.value = [];
    await RemoteServices.getRequest(endPoint: APIEndPoints.officeList)
        .then((value) {
      var officeListModel = OfficeListModel();
      if (value != null) {
        officeListModel = OfficeListModel.fromJson(value);
        officeList.value = officeListModel.data ?? [];
        // officeListModel.data?.forEach((element) {officeDropdownItems.add(element.name??""); });
      }
      isLoading.value = false;
    });
  }

  Future<void> getCountryList() async {
    countryList.value = [];

    await RemoteServices.getCountryList().then((value){
      if(value!=null){
        countryList.value =value;
        selectedCountry.value = countryList[0];
        selectedPhoneCountry.value=countryList[0];
        phoneCountryController.text=selectedPhoneCountry.value.iso31662??"";

      }
    });
/*    await RemoteServices.getRequest(endPoint: APIEndPoints.countryList)
        .then((value) {
      var countryListModel = CountryListModel();
      if (value != null) {
        countryListModel = CountryListModel.fromJson(value);
        countryList.value = countryListModel.data ?? [];
        selectedCountry.value = countryList[0];
      }
    });*/
  }

  void fetchData() {
    getOfficeData().then(
      (value) {
        getCountryList().then((value) {
          isLoading.value = false;
        });
      },
    );
  }

  void getOTP() async {
    isLoading.value = true;
    isEmailExist.value=false;
    var endPoint = APIEndPoints.getOTP;
    var body = {
      "email": emailController.text,
      "source":"sign_up",
      "office_id":selectedOffice.value.id.toString()
    };
    await RemoteServices.postRequest(endPoint: endPoint, body: body)
        .then((value){
          if(value!=null){
            var otpController=Get.put(OtpPageController());
            otpController.resetFields();
            otpController.name.value=nameController.text;
            otpController.phone.value="+${selectedCountry.value.callingCode}${phoneController.text}";
            otpController.email.value=emailController.text;
            otpController.country.value=selectedCountry.value;
            otpController.occupation.value=occupationController.text;
            otpController.city.value=cityController.text;
            otpController.office.value=selectedOffice.value;
            otpController.phoneCountry.value=selectedPhoneCountry.value;
            Get.toNamed(Routes.OTP_PAGE);
            isLoading.value=false;
          }else{
            CustomSnackBar(
              msg: "Seems, you already have an account. Please contact your nearest office.",//APIEndPoints.httpErrorMSG.value,
              isSuccess: false
            ).showSnackBar();
            isLoading.value=false;
            isEmailExist.value=true;
          }
    });
  }
}

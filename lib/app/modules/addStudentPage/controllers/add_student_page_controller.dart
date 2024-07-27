import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:iecc/app/modules/home/controllers/home_controller.dart';
import 'package:iecc/app/modules/home/models/lead_list_model.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/routes/app_pages.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import '../../../../constraints/api_end_points.dart';
import '../../../../services/remote_services.dart';

class AddStudentPageController extends GetxController {
  final isLoading = false.obs;
  final isAccepted = false.obs;
  final isEmailExist = true.obs;
  final isUpdateForm = false.obs;
  final isUpdating = false.obs;

  final genderList = ["Male", "Female"];
  final selectedGender = "Male".obs;
  final selectedCountry = SingleCountry().obs;
  final selectedPhoneCountry = SingleCountry().obs;
  final countryList = <SingleCountry>[].obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final notesController = TextEditingController();
  var lead = SingleLead().obs;


  final countryNameController=TextEditingController();

  final countryCodeController=TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    getCountryList();
    super.onInit();
  }


  @override
  void onClose() {}

  Future<void> getCountryList() async {
    isLoading.value = true;
    countryList.value = [];
    await RemoteServices.getCountryList().then((value) {
      if (value != null) {
        countryList.value = value;
        isLoading.value = false;
        selectedCountry.value = countryList[0];
        selectedPhoneCountry.value = countryList[0];
        countryCodeController.text=selectedPhoneCountry.value.iso31662??"";
       // countryNameController.text=selectedCountry.value.name??"";
       // coun.text=selectedPhoneCountry.value.name??"";
      } else {
        isLoading.value = false;
      }
    });
  }

  void addStudent() async {
    if (isAccepted.value) {
      isUpdating.value = true;
      await checkEmail().then((value) async {
        if (value) {
          submitStudentForm();
        } else {
          isUpdating.value = false;
        }
      });
    } else {
      CustomSnackBar(
              msg: "You have to agree with IECC terms and condition first.",
              isSuccess: false)
          .showSnackBar();
    }
  }

  Future<bool> checkEmail() async {
    isEmailExist.value = true;
    var endPoint = APIEndPoints.checkEmail;
    var body = {"email": emailController.text};
    await RemoteServices.postRequest(endPoint: endPoint, body: body)
        .then((value) {
      value == null
          ? isEmailExist.value = false
          : value["msg"] == "Email not exist."
              ? isEmailExist.value = true
              : isEmailExist.value = false;
    });
    return isEmailExist.value;
  }

  void submitStudentForm() async {
    var endPoint = APIEndPoints.addNewStudent;
    var body = {
      "mobile":
          "+${selectedPhoneCountry.value.callingCode}${phoneController.text}",
      "given_name": firstNameController.text,
      "family_name": lastNameController.text,
      "email": emailController.text,
      "gender": selectedGender.value,
      "nationalities_id": selectedCountry.value.id.toString(),
      "mobile_country_id": selectedPhoneCountry.value.id.toString(),
      "notes": notesController.text
    };
    await RemoteServices.postRequest(endPoint: endPoint, body: body)
        .then((value) {
      if (value != null) {
        Get.offAllNamed(Routes.HOME);
        CustomSnackBar(msg: value["msg"], isSuccess: true).showSnackBar();
        isUpdating.value = false;
      } else {
        CustomSnackBar(msg: APIEndPoints.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
        isUpdating.value = false;
      }
    });
  }

  void preLoadData() async {
    await getCountryList().then((value) {
      firstNameController.text = lead.value.givenName ?? "";
      lastNameController.text = lead.value.familyName ?? "";
      emailController.text = lead.value.email ?? "";
      selectedGender.value = lead.value.gender ?? "";
      notesController.text = lead.value.notes ?? "";
      if (lead.value.nationalitiesId != null) {
        selectedCountry.value = countryList[countryList
            .indexWhere((element) => element.id == lead.value.nationalitiesId)];
        countryNameController.text=selectedCountry.value.name??"";
      } else {
        selectedCountry.value = countryList[0];
        countryNameController.text="";
      }

      if (lead.value.mobileCountryId != null) {
        selectedPhoneCountry.value = countryList[countryList
            .indexWhere((element) => element.id == lead.value.mobileCountryId)];
        phoneController.text = (lead.value.mobile ?? "")
            .replaceAll("+${selectedPhoneCountry.value.callingCode}", "");

      } else {
        selectedPhoneCountry.value = countryList[0];
        phoneController.text = (lead.value.mobile ?? "")
            .replaceAll("+${selectedPhoneCountry.value.callingCode}", "");
      }
      countryCodeController.text=selectedPhoneCountry.value.iso31662??"";
    });
  }

  void updateUserInfo() async {
    if (isAccepted.value) {
      isUpdating.value = true;
      var endPoint = APIEndPoints.updateLead;
      var body = {
        "lead_id": lead.value.id.toString(),
        "given_name": firstNameController.text,
        "family_name": lastNameController.text,
        "gender": selectedGender.value,
        "nationalities_id": selectedCountry.value.id.toString(),
        "mobile_country_id": selectedPhoneCountry.value.id.toString(),
        "notes": notesController.text,
        "email": emailController.text == lead.value.email
            ? ""
            : emailController.text,
        "mobile":
            "+${selectedPhoneCountry.value.callingCode}${phoneController.text}",
      };



      if (emailController.text != lead.value.email) {
        await checkEmail().then((value) async {
          if (value) {
            completeUpdate(endPoint: endPoint, body: body);
          } else {
            isUpdating.value = false;
          }
        });
      } else {
        completeUpdate(endPoint: endPoint, body: body);
      }
    } else {
      CustomSnackBar(
              msg: "You have to agree with IECC terms and condition first.",
              isSuccess: false)
          .showSnackBar();
    }
  }

  void completeUpdate(
      {required String endPoint, required Map<String, dynamic> body}) async {
    await RemoteServices.postRequest(endPoint: endPoint, body: body)
        .then((value) {
      if (value != null) {
        CustomSnackBar(msg: value["msg"], isSuccess: true).showSnackBar();
        isUpdating.value = false;
        // resetFields();
        Get.put(HomeController());
        Get.find<HomeController>().getLeadListData();
      } else {
        CustomSnackBar(msg: APIEndPoints.httpErrorMSG.value, isSuccess: false)
            .showSnackBar();
        isUpdating.value = false;
      }
    });
  }

  void resetFields() {
    isUpdateForm.value = false;
    isLoading.value = false;
    isEmailExist.value = true;
    lead.value = SingleLead();
    firstNameController.text = "";
    lastNameController.text = "";
    phoneController.text = "";
    emailController.text = "";
    countryNameController.text="";
    countryCodeController.text="";
    selectedGender.value = "Male";
    selectedCountry.value =
        countryList.isEmpty ? SingleCountry() : countryList[0];
    selectedPhoneCountry.value =
        countryList.isEmpty ? SingleCountry() : countryList[0];
    notesController.text = "";
  }
}

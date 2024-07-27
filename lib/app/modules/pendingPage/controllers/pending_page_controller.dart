import 'package:get/get.dart';
import 'package:iecc/app/data/user_data_model.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/utils/extensions.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import 'package:iecc/services/local_services.dart';
import 'package:iecc/services/remote_services.dart';

import '../../../routes/app_pages.dart';

class PendingPageController extends GetxController {
  var userData = UserDataModel().obs;
  var selectedCountry = SingleCountry().obs;
  var isLoading=false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  @override
  void onClose() {}

  void fetchData() async {
  //  var endPoint = APIEndPoints.countryList;
    var countryData=<SingleCountry>  [].obs;
    await LocalServices.getUser().then((value) async {
      userData.value = value ?? UserDataModel();
      await RemoteServices.getCountryList().then((value) {
        if(value!=null){
          countryData.value=value;

          selectedCountry.value=countryData[countryData
              .indexWhere((element) => element.id.toString() == userData.value.country.toString())];
        }
      });

    /*  await RemoteServices.getRequest(endPoint: endPoint).then((value) {
        if (value != null) {
          countryData = CountryListModel.fromJson(value);
          selectedCountry.value = countryData.data![countryData.data!
              .indexWhere((element) => element.id == userData.value.country)];
        }
      });*/
    });
  }

 void reloadData() async{
    isLoading.value=true;
    await LocalServices.getUser().then((value) async {
      if (await (value ?? UserDataModel()).userStatus()) {
        Get.offAndToNamed(Routes.HOME);
        isLoading.value=false;
      }else{
        CustomSnackBar(
          msg: "Please wait for your application to be approved.",
          isSuccess: true
        ).showSnackBar();
        isLoading.value=false;
      }
    });
  }
}

import 'package:get/get.dart';
import 'package:iecc/app/modules/registration/models/country_list_model.dart';
import 'package:iecc/app/modules/studentDetailsPage/Models/lead_details_model.dart';
import 'package:iecc/common_widgets/custom_snackbar.dart';
import 'package:iecc/constraints/api_end_points.dart';
import 'package:iecc/services/remote_services.dart';

class StudentDetailsPageController extends GetxController {
  var isLoading = false.obs;
  var leadDetailsModel = LeadDetailsModel().obs;
  var notes="".obs;
  var isAssigned=false.obs;

  var countryList=<SingleCountry>[].obs;


  @override
  void onInit() {
    getCountry();
    super.onInit();
  }

  @override
  void onClose() {}

  void getLeadDetails({required int leadId}) async {
    isLoading.value = true;
    var endPoint = APIEndPoints.getLeadDetails;
    var parameters = {"lead_id": leadId.toString()};

    await RemoteServices.getRequest(endPoint: endPoint, parameters: parameters)
        .then((value) {

          if(value!=null){
            leadDetailsModel.value=LeadDetailsModel.fromJson(value);
            isLoading.value=false;
          }else{
            CustomSnackBar(
              msg: APIEndPoints.httpErrorMSG.value,
              isSuccess: false
            ).showSnackBar();
            isLoading.value=false;
          }
    });
  }

  void getCountry()async {

    try{
      await RemoteServices.getCountryList().then((value) {
        countryList.value=value??[];
      });
    }catch(e){
      countryList.value=[];
    }
  }

 String getCountryFlug(int? country) {

    String countryFlag="";
    try{
      countryFlag=  countryList[countryList.indexWhere((element) => element.id==country)].flagUrl??"";

    }catch(e){
      countryFlag="";
    }

    print(countryFlag);
    return countryFlag;
 }
}

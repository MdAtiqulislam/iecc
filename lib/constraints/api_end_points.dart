import 'package:get/get.dart';

class APIEndPoints{

  //for Dev
  //  static const baseURL = "https://dev.samscrm.co.uk/";
  //for Test
  // static const baseURL = "https://test-469ky9qa.samscrm.co.uk/";
  //for live
  static const baseURL = "https://app.samscrm.co.uk/";
  static var httpErrorMSG = "".obs;
  static const login="api/v2/sub-agent/auth/login";
  static const officeList="api/v2/sub-agent/auth/office_list";
  static const countryList="api/v1/crm-sub-agent/country-code-list";
  static const getOTP="api/v2/sub-agent/auth/email-validation-otp";
  static const verifyOTP="api/v2/sub-agent/auth/verify-email-otp";
  static const signUp="api/v2/sub-agent/auth/sign_up";
  static const resetPassword="api/v2/sub-agent/auth/reset-password";
  static const getHomeData="api/v2/sub-agent/ajax/home_data";
  static const getUserData="api/v2/sub-agent/ajax/logged_in_subagent_info";
  static const checkEmail="api/v2/sub-agent/ajax/check_lead_email";
  static const addNewStudent="api/v2/sub-agent/ajax/create_lead";
  static const getLeadList="api/v2/sub-agent/ajax/lead_list";
  static const uploadProfilePic="api/v2/sub-agent/ajax/user_profile_img";
  static const updateProfile="api/v2/sub-agent/ajax/update_user_profile";
  static const updateLead="api/v2/sub-agent/ajax/update_lead_info";
  static const getLeadDetails="api/v2/sub-agent/ajax/lead_details";
  static const getNotification="api/v2/sub-agent/ajax/notification_list";
  static const changeNotificationReadStatus="api/v2/sub-agent/ajax/notification_marked_as_read";
  static const removeNotification="api/v2/sub-agent/ajax/notification_remove_from_app_list";
  static const estimatedIncome="api/v2/sub-agent/ajax/estimated_income";
  static const removeAccount="api/v2/sub-agent/ajax/remove_account";
}
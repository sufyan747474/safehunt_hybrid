class NetworkStrings {
  NetworkStrings._();

  ///================================= BASE URLS ================================
  static const String API_BASE_URL = "http://109.176.198.34:5050/";
  static const String IMAGE_BASE_URL = "https://safehunt.app/";
  static const String MERCHANT_SUCCESS_URL =
      "https://host2.appsstaging.com:3005/privacy_policy";
  static const String MERCHANT_THANK_YOU_URL =
      "https://server1.appsstaging.com/3672/SafeHunt/public/thankyou";

  /// STRIPE
  static const String PUBLISH_KEY =
      "pk_test_51Q2Xu4CHsLZSnNQo5FV27D4LKbnvWR083g9qnpFD1S8Gsm2rCoykfBTECVSuMaYkiAX8PzXWNLMkEh2U0XuH58bW00asSx3q5R";

  /// ============================== AUTH ENDPOINTS ============================
  static const String LOGIN_ENDPOINT = "auth/login";
  static const String SIGNUP_ENDPOINT = "auth/signup";

  static const String OTP_VERIFICATION_ENDPOINT = "auth/otp-verification";
  static const String RESEND_OTP_ENDPOINT = "auth/regenerate-otp";
  static const String COMPLETE_PROFILE_ENDPOINT = "completeProfile";
  static const String EDIT_PROFILE_ENDPOINT = "auth/update/";
  static const String SOCIAL_LOGIN_ENDPOINT = "social_login";
  static const String LOGOUT_ENDPOINT = "logout";
  static const String CONTENT_ENDPOINT = "content";
  static const String FOLLOW_UNFOLLOW_ENDPOINT = "follow_user";
  static const String MERCHANT_ACCOUNT_SETUP_ENDPOINT = "stripe_url";
  static const String OTHER_USER_PROFILE_ENDPOINT = "other_user_profile";
  static const String NOTIFICATION_END_POINT = 'notifications';
  static const String REQUEST_RESET_PASSWORD_ENDPOINT =
      "auth/request-reset-password";
  static const String CHANGE_PASSWORD_ENDPOINT = "auth/change-password";

  /// ============================ TOAST MESSAGES ==============================
  static const String NETWORK_ERROR = "Network error!";
  static const String NO_INTERNET_CONNECTION = "No Internet Connection!";
  static const String SOMETHING_WENT_WRONG = "Something Went Wrong";

  /// =========================== CODES ========================================
  /// API STATUS CODE
  static const int SUCCESS_CODE = 200;

  static const int CARD_ERROR_CODE = 402;
  static const int BAD_REQUEST_CODE = 400;
  static const int FORBIDDEN_CODE = 403;
  static const int INTERNAL_SERVER_CODE = 500;

  /// API MESSAGES
  static const API_SUCCESS_STATUS = 1;
  static const ACCOUNT_UNVERIFIED = '0';
  static const ACCOUNT_VERIFIED = '1';
  static const PROFILE_IN_COMPLETED = '0';
  static const IS_SOCIAL = '1';
  static const PROFILE_COMPLETED = 1;
  static const UNAUTHORIZED_CODE = 401;

  /// SOCKET RESPONSE KEYS
  static const String GET_MESSAGES_KEY = "get_messages";
  static const String GET_MESSAGE_KEY = "get_message";

  /////// API HEADER TEXT ////////////////////////
  static const String ACCEPT = 'application/json';

  ///-------------------- Shared Preference Keys -------------------- ///
  static const String BEARER_TOKEN = "Bearer Token";
  static const String USER = "User";

  // toast
  static const String INVALID_BANK_ACCOUNT_DETAILS_ERROR =
      "Invalid Bank Account Details.";
  static const String MERCHANT_ACCOUNT_ERROR =
      "Error:Merchant Account can not be created.";
  static const String INVALID_CARD_ERROR = "Invalid Card Details.";
  static const String CHECK_MERCHANT_SETUP = "check_merchant_account";

  ///LOCAL NOTIFICATION CHANNEL ///////////
  static const String LOCAL_NOTIFICATION_ID = "SafeHunt_channel1";
  static const String LOCAL_NOTIFICATION_TITLE = "SafeHunt local Notification.";
  static const String LOCAL_NOTIFICATION_DESCRIPTION =
      "This channel is used for local notifications.";

  ///PUSH NOTIFICATION TYPE ///////////
  static const String FOREGROUND_NOTIFICATION = "foreground";
  static const String BACKGROUND_NOTIFICATION = "background";
  static const String KILLED_NOTIFICATION = "killed";

  // ------------------- Firebase Error Strings -------------------------//
  static const String INVALID_PHONE_NUMBER = "invalid-phone-number";
  static const String INVALID_PHONE_NUMBER_MESSAGE = "Invalid phone number";
  static const String INVALID_VERIFICATION_CODE = "invalid-verification-code";
  static const String INVALID_VERIFICATION_CODE_MESSAGE =
      "Invalid Verification Code";

  // / CARD
  static const String ADD_CARD_ENDPOINT = "card/add";
  static const String DELETE_CARD_ENDPOINT = "card/delete";
  static const String SET_DEFAULT_CARD_ENDPOINT = "card/set-as-default";
  static const String GET_ALL_CARDS_ENDPOINT = "card/list";

  //user listing
  static const String GET_USER_LISTING_ENDPOINT = "user_listing";

  //journalink
  static const String JOURNALING_CREATE_ENDPOINT = "hunting-journal";
  static const String JOURNALING_LISTING_ENDPOINT =
      "hunting-journal/my-journals";
  static const String JOURNALING_DELETE_ENDPOINT = "hunting-journal";

  // / POST
  static const String ADD_POST_ENDPOINT = "post";

  // POST LIKE
  static const String POST_LIKE_ENDPOINT = "likes";

  // COMMENT
  static const String COMMENT_ENDPOINT = "comments";

  // CHILD COMMENT
  static const String CHILD_COMMENT_ENDPOINT = "comments/replies";

  // / POST
  static const String POST_SHARE_ENDPOINT = "shares";

  // / FRIENDS
  static const String FRIENDS_ENDPOINT = "friends";

  // <============ dynamin linking ----------?
  static const String DYNAMIC_URL = "https://sixsigmaSafeHunt.page.link";

  // 'https://toothferri.page.link';
  static const String ProductId = 'ProductId';
  static const String POST_INDEX = 'postIndex';
  static const String APP_PACKAGE_NAME = 'com.sixsigma.SafeHunt';
  static const String APP_BUNDLE_ID = 'com.sixsigma.SafeHunt';
  static const int ANDROID_MINIMUM_VERSION = 1;
  static const String IOS_MINIMUM_VERSION = '1';
  static const String APP_STORE_ID = '696PA32759';
}

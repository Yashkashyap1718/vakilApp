const String baseURL = "http://172.93.54.177:3001";

//////////  Customer ////////

const String signInEndpoint = "/users/signin"; //POST
const String confirmationEndpoint = "/users/confirmation"; //POST
const String resendOTPEndpoint = "/users/resendotp"; //POST
const String getuserProfileEndpoint = "/users/profile/preview"; //GET
const String updateProfileEndpoint = "/users/profile/update"; //PUT
const String sendEmailVerificationCode = "/users/send/email"; //POST
const String verifyEmailCodeEndpoint = "/users/verify/email"; //PUT
const String listOfAllConcernedLandingPageEndpoint = "users/list_of_all_cencerned"; //GET

/////////////  Advocate //////////

const String adminSignInEndpoint = "/advocate/signin"; //POST
const String adminConfirmationEndpoint = "/advocate/confirmation"; //POST
const String adminUserProfileEndpoint = "/advocate/profile/preview"; //GET
const String adminUpdateProfile = "/advocate/profile/update"; //PUT
const String adminAddCategoryEndpoint = "/advocate/category/create"; //POST
const String adminCategoryListEndpoint = "/advocate/categories"; //GET
const String adminAddSubCategoryEndpoint =
    "/advocate/subcategory/create"; //POST
const String adminSubCategoryListEndpoint = "/advocate/profile/update"; //GET

//////////// without Token   /////////////

const String landingPageEndpoint = "/list_of_all_concerned";  //GET

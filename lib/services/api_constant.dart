const String baseURL = "http://172.93.54.177:3001";

//////////  Customer ////////

const String signInEndpoint = "/advocate/signin"; //POST
const String confirmationEndpoint = "/advocate/confirmation"; //POST
const String resendOTPEndpoint = "/advocate/resendotp"; //POST
const String getuserProfileEndpoint = "/advocate/profile/preview"; //GET
const String updateProfileEndpoint = "/advocate/profile/update"; //PUT
const String sendEmailVerificationCode = "/advocate/send/email"; //POST
const String verifyEmailCodeEndpoint = "/advocate/verify/email"; //PUT

/////////////  Admin //////////

const String adminSignInEndpoint = "/admin/signin"; //POST
const String adminConfirmationEndpoint = "/admin/confirmation"; //POST
const String adminUserProfileEndpoint = "/admin/profile/preview"; //GET
const String adminUpdateProfile = "/admin/profile/update"; //PUT
const String adminAddCategoryEndpoint = "/admin/category/create"; //POST
const String adminCategoryListEndpoint = "/admin/categories"; //GET
const String adminAddSubCategoryEndpoint = "/admin/subcategory/create"; //POST
const String adminSubCategoryListEndpoint = "/admin/profile/update"; //GET

//////////// without Token   /////////////

const String landingPageEndpoint = "/admin/subcategories";  //GET

const String baseURL = "http://172.93.54.177:3001";

//////////  Customer ////////

const String signInEndpoint = "/users/signin"; //POST
const String confirmationEndpoint = "/users/confirmation"; //POST
const String resendOTPEndpoint = "/users/resendotp"; //POST
const String getuserProfileEndpoint = "users/profile/preview"; //GET
const String updateProfileEndpoint = "/users/profile/update"; //PUT
const String sendEmailVerificationCode = "/users/profile/update"; //POST
const String verifyEmailCodeEndpoint = "/users/profile/update"; //PUT

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

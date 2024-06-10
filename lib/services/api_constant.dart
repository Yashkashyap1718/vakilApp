const String baseURL = "http://172.93.54.177:3001";
const String baseImageURL = "http://172.93.54.177:3001/uploads/";

//////////  Customer ////////

const String signInEndpoint = "/users/signin"; //POST
const String confirmationEndpoint = "/users/confirmation"; //POST
const String resendOTPEndpoint = "/users/resendotp"; //POST
const String getuserProfileEndpoint = "/users/profile/preview"; //GET
const String updateProfileEndpoint = "/users/profile/update"; //PUT
const String sendEmailVerificationCode = "/users/send/email"; //POST
const String verifyEmailCodeEndpoint = "/users/verify/email"; //PUT
const String listOfAllConcernedLandingPageEndpoint =
    "/users/list_of_all_cencerned"; //GET
const String userAdvocateConcernedLandingPageEndpoint =
    "/users/list_of_cencerned_advocate"; //GET

/////////////  Advocate //////////

const String advocateSignInEndpoint = "/advocate/signin"; //POST
const String advocateConfirmationEndpoint = "/advocate/confirmation"; //POST
const String advocateUserProfileEndpoint = "/advocate/profile/preview"; //GET
const String advocateUpdateProfile = "/advocate/profile/update"; //PUT
const String advocateAddCategoryEndpoint = "/advocate/category/create"; //POST
const String advocateCategoryListEndpoint = "/advocate/categories"; //GET
const String advocateAddSubCategoryEndpoint =
    "/advocate/subcategory/create"; //POST
const String advocateSubCategoryListEndpoint = "/advocate/profile/update"; //GET

const String advocateBarCouncilCertificateEndoint =
    '/advocate/bar_council_certificate'; //PUT

const String advocateClientCaseEndpoint =
    "/advocate/client/client_create"; //POST
const String advocateAllClients = "/advocate/client/client_list"; //GET

//////////// without Token  /////////////

const String landingPageEndpoint = "/list_of_all_concerned";  //GET

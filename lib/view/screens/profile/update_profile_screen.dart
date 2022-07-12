import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/data/model/response/response_model.dart';
import 'package:sixam_mart/data/model/response/userinfo_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/footer_view.dart';
import 'package:sixam_mart/view/base/image_picker_widget.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/my_text_field.dart';
import 'package:sixam_mart/view/base/not_logged_in_screen.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/data/model/response/ImageUploadModel.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoggedIn;
  static String newValue;
  static String dropdownvalue = 'College of Engineering Pune (COEP)';
  var items =  ['College of Engineering Pune (COEP)',
                'Bharathi Vidyapeeth Deemed University',
                'Sinhgad College of Engineering',
                'Vishwakarma Institute of Technology',
                'Symbiosis Institute of Technology',
                'MIT WPU Faculty of Engineering',
                'DY Patil College of Engineering',
                'MKSSS’s Cummins College of Engineering for Women',
                'Army Institute of Technology',
                'AISSMS College of Engineering',
                'Jayawantrao Sawant College of Engineering'
                ];
  List<Object> images = List<Object>();
  Future<XFile> _imageFile;

  XFile _image=null;

  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = XFile(pickedImage.path);
      });
    }
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if(_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    Get.find<UserController>().initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      endDrawer: MenuDrawer(),
      body: GetBuilder<UserController>(builder: (userController) {
        if(userController.userInfoModel != null && _phoneController.text.isEmpty) {
          _firstNameController.text = userController.userInfoModel.fName ?? '';
          _lastNameController.text = userController.userInfoModel.lName ?? '';
          _phoneController.text = userController.userInfoModel.phone ?? '';
          _emailController.text = userController.userInfoModel.email ?? '';
          dropdownvalue = userController.userInfoModel.college_name ?? '';
        }

        return _isLoggedIn ? userController.userInfoModel != null ? ProfileBgWidget(
          backButton: true,
          circularImage: ImagePickerWidget(
            image: '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${userController.userInfoModel.image}',
            onTap: () => userController.pickImage(), rawFile: userController.rawFile,
          ),

          mainWidget: Column(children: [

            Expanded(child: Scrollbar(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Center(child: FooterView(
                minHeight: 0.45,
                child: SizedBox(width: Dimensions.WEB_MAX_WIDTH, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  new Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: buildGridView(),
                        ),
                      ],
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const SizedBox(height: 35),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                            height: 100,
                            color: Colors.grey[300],
                        )
                      ],
                    ),
                  ),
                  new Container(
                    margin: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const SizedBox(height: 35),
                        Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 100,
                          color: Colors.grey[300],
                        )
                      ],
                    ),
                  ),
                  Text(
                    'college_name'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                  DropdownButton(
                    value: dropdownvalue,
                    style: TextStyle(color: Colors.black,fontSize: 12),
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                    }
                    ).toList(),
                    onChanged: (newValue){
                      setState(() {
                        dropdownvalue = newValue;
                        print(dropdownvalue);
                      });
                    },
                  ),
                  Text(
                    'first_name'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  MyTextField(
                    hintText: 'first_name'.tr,
                    controller: _firstNameController,
                    focusNode: _firstNameFocus,
                    nextFocus: _lastNameFocus,
                    inputType: TextInputType.name,
                    capitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Text(
                    'last_name'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  MyTextField(
                    hintText: 'last_name'.tr,
                    controller: _lastNameController,
                    focusNode: _lastNameFocus,
                    nextFocus: _emailFocus,
                    inputType: TextInputType.name,
                    capitalization: TextCapitalization.words,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Text(
                    'email'.tr,
                    style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  MyTextField(
                    hintText: 'email'.tr,
                    controller: _emailController,
                    focusNode: _emailFocus,
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                  Row(children: [
                    Text(
                      'phone'.tr,
                      style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Text('(${'non_changeable'.tr})', style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).errorColor,
                    )),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  MyTextField(
                    hintText: 'phone'.tr,
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    inputType: TextInputType.phone,
                    isEnabled: false,
                  ),
                  //
                  ResponsiveHelper.isDesktop(context) ? Padding(
                    padding: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE),
                    child: UpdateProfileButton(isLoading: userController.isLoading, onPressed: () {
                      return _updateProfile(userController);
                    }),
                  ) : SizedBox.shrink() ,

                ])),
              )),

            ))),

            ResponsiveHelper.isDesktop(context) ? SizedBox.shrink() : UpdateProfileButton(isLoading: userController.isLoading, onPressed: () => _updateProfile(userController)),

          ]),
        ) : Center(child: CircularProgressIndicator()) : NotLoggedInScreen();
      }),
    );
  }
  Widget buildGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 4,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
      if (images[index] is ImageUploadModel) {
        ImageUploadModel uploadModel = images[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: 5,
                child: InkWell(
                  child: Icon(
                    Icons.add_circle,
                    size: 30,
                    color: Colors.green,
                  ),
                  onTap: () {
                    setState(() {
                      images.replaceRange(index, index + 1, ['Add Image']);
                    });
                  },
                ),
              ),
            ],
          ),
        );
      }else {
        return Card(
          child: IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _onAddImageClick(index);
            },
          ),
        );
      }
      }),
    );
  }
  Future _onAddImageClick(int index) async {
      _imageFile = (await ImagePicker().pickImage(source: ImageSource.gallery)) as Future<XFile>;
      getFileImage(index);
  }
  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }
    void _updateProfile(UserController userController) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    String _phoneNumber = _phoneController.text.trim();
    print(dropdownvalue);

   if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else if (_phoneNumber.isEmpty) {
      showCustomSnackBar('enter_phone_number'.tr);
    }else if (_phoneNumber.length < 6) {
      showCustomSnackBar('enter_a_valid_phone_number'.tr);
    } else {
     print(dropdownvalue);

     UserInfoModel _updatedUser = UserInfoModel(fName: _firstName, lName: _lastName, email: _email, phone: _phoneNumber,college_name: dropdownvalue);
      ResponseModel _responseModel = await userController.updateUserInfo(_updatedUser, Get.find<AuthController>().getUserToken());
     print(dropdownvalue);

     if(_responseModel.isSuccess) {
        showCustomSnackBar('profile_updated_successfully'.tr, isError: false);
      }else {
        showCustomSnackBar(_responseModel.message);
      }
    }
  }
}

class UpdateProfileButton extends StatelessWidget {
  final bool isLoading;
  final Function onPressed;
  const UpdateProfileButton({Key key, @required this.isLoading, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !isLoading ? CustomButton(
      onPressed: onPressed,
      margin: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      buttonText: 'update'.tr,
    ) : Center(child: CircularProgressIndicator());
  }
}

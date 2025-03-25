import 'dart:developer';
import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/bloc/auth/edit_profile_bloc.dart';
import 'package:safe_hunt/bloc/auth/get_equipment_images_bloc.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/app_dialogs.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/common/asset_path.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/custom_scafold.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/utils/validators.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:safe_hunt/widgets/app_text_field.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/custom_button.dart';
import 'package:safe_hunt/widgets/custom_container.dart';
import 'package:safe_hunt/widgets/get_back_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmationCodeController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController skilController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  final GlobalKey<FormState> _editProfileFormKey = GlobalKey<FormState>();

  List<String> skilList = [];
  List<String> equipmentImages = [];
  List<String> selectedEquipmentImages = [];

  String? profileImage;
  String? coverImage;

  UserData? user;

  setValues() {
    displayNameController.text = user?.displayname ?? '';
    userNameController.text = user?.username ?? "";
    emailController.text = user?.email ?? '';
    phoneNumberController.text = user?.phonenumber ?? "";
    experienceController.text = user?.huntingExperience ?? '';
    bioController.text = user?.bio ?? '';
    skilList.addAll(user?.skills ?? []);
  }

  @override
  void initState() {
    super.initState();
    user = context.read<UserProvider>().user;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      GetEquipmentImagesBloc().getEquipmentImagesBlocMethod(
          context: context,
          setProgressBar: () {
            AppDialogs.progressAlertDialog(context: context);
          },
          onSuccess: (res) {
            equipmentImages.addAll(res);
            selectedEquipmentImages.addAll(user?.equipmentImages ?? []);
            setState(() {});
          },
          onFailure: () {});
    });

    setValues();
  }

  void toggleSelection(String imageUrl) {
    setState(() {
      if (selectedEquipmentImages.contains(imageUrl)) {
        selectedEquipmentImages.remove(imageUrl);
      } else {
        selectedEquipmentImages.add(imageUrl);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: Transform.translate(
              offset: Offset(10.w, 0),
              child: const GetBackButton(
                width: 10,
                height: 10,
              )),
        ),
        title: BigText(
          text: 'Edit Profile',
          fontWeight: FontWeight.bold,
          size: 20.sp,
          color: appWhiteColor,
        ),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(builder: (context, val, _) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _editProfileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomImageWidget(
                              canSelectImage: true,
                              borderWidth: 1.5.r,
                              imageUrl: user?.profilePhoto,
                              pickedImage: profileImage != null
                                  ? File(profileImage!)
                                  : null,
                              isBorder: true,
                              setFile: (path) {
                                setState(() {
                                  profileImage = path?.path;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                            enabled: false,
                            textController: emailController,
                            hintText: 'Email *',
                            maxLength: 35,
                            validator: (value) {
                              return CommonFieldValidators.emailValidator(
                                  value);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                            // enabled: false,
                            textController: displayNameController,
                            hintText: 'Display Name *',
                            maxLength: 35,
                            validator: (value) {
                              return CommonFieldValidators.validateEmptyOrNull(
                                  label: 'Display Name', value: value);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                            // enabled: false,
                            textController: userNameController,
                            hintText: 'User Name *',
                            maxLength: 35,
                            validator: (value) {
                              return CommonFieldValidators.validateEmptyOrNull(
                                  label: 'User Name', value: value);
                            },
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          AppTextField(
                            textController: phoneNumberController,
                            hintText: 'Phone Number *',
                            validator: (value) {
                              return CommonFieldValidators
                                  .phoneFieldValidatorLogin(
                                value,
                              );
                            },
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              MaskTextInputFormatter(
                                mask: '+1 ### ### ####',
                                filter: {"#": RegExp(r'[0-9]')},
                                type: MaskAutoCompletionType.lazy,
                              ),
                              LengthLimitingTextInputFormatter(16),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          // bio field

                          AppTextField(
                            hintText: 'Hunting Experience',
                            keyboardType: TextInputType.number,
                            textController: experienceController,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              return CommonFieldValidators.validateEmptyOrNull(
                                label: 'Hunting Experience',
                                value: value,
                              );
                            },
                            verticalPadding: 10.w,
                            borderRdius: 8.r,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // skil
                          AppTextField(
                            hintText: 'Skills',
                            textController: skilController,
                            onFieldSubmitted: (value) {
                              if (value.isNotEmpty) {
                                skilList.add(value);
                                setState(() {});
                              }
                              skilController.clear();
                            },
                          ),
                          10.verticalSpace,
                          Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Wrap(
                                runSpacing: 5.h,
                                spacing: 5.w,
                                alignment: WrapAlignment.start,
                                children: [
                                  if (skilList.isNotEmpty)
                                    ...List.generate(
                                      skilList.length,
                                      (index) => Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          color: AppColors.greenColor,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.h, horizontal: 10.w),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                skilList[index],
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.sp,
                                                ),
                                                // maxLines: 2,
                                              ),
                                            ),
                                            8.horizontalSpace,
                                            CustomContainer(
                                              onTap: () {
                                                skilList.removeAt(index);
                                                setState(() {});
                                              },
                                              conatinerColor:
                                                  AppColors.whiteColor,
                                              iconColor: AppColors.greenColor,
                                              width: 14.w,
                                              height: 14.w,
                                              iconData: Icons.close,
                                              iconWidth: 13.w,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                ]),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          // bio field

                          AppTextField(
                            hintText: 'Bio',
                            textController: bioController,
                            maxLines: 5,
                            minLines: 5,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(375)
                            ],
                            validator: (value) {
                              return CommonFieldValidators.validateEmptyOrNull(
                                label: 'Bio',
                                value: value,
                              );
                            },
                            verticalPadding: 10.w,
                            borderRdius: 8.r,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          if (equipmentImages.isNotEmpty) ...[
                            BigText(
                              text: 'Select Equipment',
                              color: AppColors.whiteColor,
                              size: 16.sp,
                            ),
                            10.verticalSpace,
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Wrap(
                                runSpacing: 10.w,
                                spacing: 10.w,
                                alignment: WrapAlignment.start,
                                children: List.generate(equipmentImages.length,
                                    (index) {
                                  String imageUrl = equipmentImages[index];
                                  bool isSelected = selectedEquipmentImages
                                      .contains(imageUrl);

                                  return GestureDetector(
                                    onTap: () => toggleSelection(imageUrl),
                                    child: Stack(
                                      children: [
                                        CustomImageWidget(
                                          isPlaceHolderShow: false,
                                          isBaseUrl: false,
                                          shape: BoxShape.rectangle,
                                          isBorder: false,
                                          fit: BoxFit.cover,
                                          borderRadius: BorderRadius.zero,
                                          imageWidth: .40.sw,
                                          imageHeight: 100.h,
                                          imageUrl: imageUrl,
                                          imageAssets:
                                              AppAssets.postImagePlaceHolder,
                                        ),
                                        if (isSelected)
                                          const Positioned(
                                            top: 8,
                                            right: 8,
                                            child: Icon(
                                              Icons.check_circle,
                                              color: appBrownColor,
                                              size: 24,
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                            20.verticalSpace,
                            20.verticalSpace,
                          ],
                          // upload cover photo
                          CustomContainer(
                            decortionImage: coverImage != null
                                ? DecorationImage(
                                    image: FileImage(File(coverImage!)),
                                    fit: BoxFit.cover)
                                : user?.coverPhoto != null
                                    ? DecorationImage(
                                        image: ExtendedNetworkImageProvider(
                                            NetworkStrings.IMAGE_BASE_URL +
                                                user!.coverPhoto!),
                                        fit: BoxFit.cover)
                                    : null,
                            width: 1.sw,
                            height: 165.h,
                            borderRadius: BorderRadius.circular(5.r),
                            conatinerColor:
                                AppColors.whiteColor.withOpacity(.3),
                            shape: BoxShape.rectangle,
                            iconData: Icons.file_upload_outlined,
                            iconWidth: 30.w,
                            iconColor: AppColors.greenColor,
                            text: "Upload Cover Photo",
                            fontColor: AppColors.whiteColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            onTap: () {
                              Utils.showImageSourceSheet(
                                context: context,
                                setFile: (file) {
                                  coverImage = file.path;
                                  setState(() {});
                                },
                              );
                            },
                          ),

                          SizedBox(
                            height: 50.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              log(phoneNumberController.text);

                              if (_editProfileFormKey.currentState!
                                  .validate()) {
                                if (skilList.isEmpty) {
                                  AppDialogs.showToast(
                                      message: "Skill  field can't be  empty.");
                                } else {
                                  _editProfileFormKey.currentState?.save();
                                  Utils.unFocusKeyboard(context);
                                  EditProfileBloc().editProfileBlocMethod(
                                      context: context,
                                      setProgressBar: () {
                                        AppDialogs.progressAlertDialog(
                                            context: context);
                                      },
                                      displayName: displayNameController.text,
                                      userName: userNameController.text,
                                      bio: bioController.text,
                                      email: emailController.text,
                                      phoneNumber: phoneNumberController.text,
                                      huntingExperience:
                                          experienceController.text,
                                      skills: skilList,
                                      coverPhoto: coverImage,
                                      imageFilePath: profileImage,
                                      equipmentImages: selectedEquipmentImages);
                                }
                              }
                            },
                            child: CustomButton(
                              text: 'Continue',
                              fontWeight: FontWeight.w500,
                              textColor: appBlackColor,
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

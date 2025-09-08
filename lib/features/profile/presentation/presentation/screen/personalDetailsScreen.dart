import 'dart:io';
import 'package:eazy/helper/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:eazy/constants.dart';
import 'package:eazy/features/authscreen/presentation/screens/update_password_screen.dart';
import 'package:eazy/features/authscreen/widgets/custom_buttom.dart';
import 'package:eazy/features/authscreen/widgets/custom_icon_bar.dart';
import 'package:eazy/features/authscreen/widgets/custom_text_field.dart';
import 'package:eazy/features/authscreen/widgets/show_bottom_sheet.dart';

import '../model/user_profile.dart';
import '../profilecubit/profile_cubit.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key});
  static const String routeName = 'personal_screen';

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  File? pickedImage;


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final extension = file.path.split('.').last.toLowerCase();
      final fileSize = await File(file.path).length(); // حجم الصورة بالبايت
      const maxSizeInBytes = 5 * 1024 * 1024; // 5 ميجابايت

      if (!['jpg', 'jpeg', 'png'].contains(extension)) {
        showSnackBar(context, 'الصورة غير مدعومة، استخدم jpg أو png', Colors.red);
      } else if (fileSize > maxSizeInBytes) {
        showSnackBar(context, 'حجم الصورة كبير جدًا، اختر أقل من 5 ميجابايت', Colors.red);
      } else {
        setState(() {
          pickedImage = File(file.path);
        });
      }
    }
  }


  ImageProvider<Object> _getProfileImage(ProfileState state) {
    if (pickedImage != null) return FileImage(pickedImage!);
    if (state is ProfileUpdated && state.profile.image != null) return NetworkImage(state.profile.image!);
    if (state is ProfileLoaded && state.profile.image != null) return NetworkImage(state.profile.image!);
    return const AssetImage("assets/images/Oval.png");
  }

  void _updateControllers(UserProfile profile) {
    nameController.text = profile.name;
    emailController.text = profile.email;
    phoneController.text = profile.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "البيانات الشخصية",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          IconButton(onPressed: () => Navigator.pop(context), icon: CustomIconBar()),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded || state is ProfileUpdated) {
            final profile = state is ProfileLoaded ? state.profile : (state as ProfileUpdated).profile;
            _updateControllers(profile);

            if (state is ProfileUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) return const Center(child: CircularProgressIndicator());

          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: autoValidateMode,
                child: Column(
                  children: [
                    // صورة البروفايل
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(radius: 70, backgroundImage: _getProfileImage(state)),
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(Icons.camera_alt, color: kPrimaryColor, size: 30),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // الاسم
                    CustomTextField(
                      controller: nameController,
                      text: "اسم المستخدم",
                      validator: (value) => value == null || value.isEmpty ? "الاسم مطلوب" : null,
                    ),
                    const SizedBox(height: 25),

                    // رقم الهاتف
                    CustomTextField(
                      controller: phoneController,
                      text: "رقم الهاتف",
                      validator: (value) => value == null || value.isEmpty ? "رقم الهاتف مطلوب" : null,
                    ),
                    const SizedBox(height: 25),

                    // البريد
                    CustomTextField(
                      controller: emailController,
                      text: "البريد الإلكتروني",
                      validator: (value) {
                        if (value == null || value.isEmpty) return "البريد الإلكتروني مطلوب";
                        if (!value.contains("@")) return "بريد غير صالح";
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),

                    // تغيير كلمة المرور
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, UpdatePasswordScreen.routeName),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text("تغيير كلمة المرور", style: TextStyle(color: kSecondaryColor, fontWeight: FontWeight.bold, fontSize: 15)),
                          SizedBox(width: 10),
                          Icon(Icons.lock_outline, size: 25, color: Colors.grey),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),

                    // حفظ التعديلات
                    CustomButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          context.read<ProfileCubit>().updateProfile(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            image: pickedImage,
                          );
                        } else {
                          setState(() => autoValidateMode = AutovalidateMode.always);
                        }
                      },
                      text: 'حفظ التعديلات',
                    ),
                    const SizedBox(height: 24),

                    // حذف الحساب
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => const ShowBottomSheet(
                                title: 'حذف الحساب',
                                firstLine: 'هل انت متأكد من انك تريد حذف الحساب؟ سيتم حذف',
                                secondLine: 'البيانات بشكل كامل',
                              ),
                            );
                          },
                          child: const Text("حذف الحساب", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.delete_outline, color: Colors.red),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

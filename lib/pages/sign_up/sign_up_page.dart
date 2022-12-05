import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_button.dart';
import 'package:shop_app/common_widgets/app_dialog.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_text_field.dart';
import 'package:shop_app/helpers/firebase_helper.dart';
import 'package:shop_app/helpers/validation.dart';
import 'package:shop_app/modals/user_modal.dart';
import 'package:shop_app/pages/home/home_page.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/user_provider.dart';

import '../../constants.dart';

class SignUpPage extends StatefulWidget with ValidateUserSignUp{
  static const routeName = '/sign-up-page';

   SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() == true) {
      return;
    }
    _formKey.currentState!.save();
    try {
      final userCredential = await Provider.of<AuthProvider>(context, listen: false)
          .signUpWithEmailAndPassword(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      );
      //UserModal userData = await FirebaseHelper.getUserData(userId: userCredential.user!.uid);
      //Provider.of<UserProvider>(context).changeCurrentUserValue(userModal: userData);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } on FirebaseAuthException catch (e) {
      showAppDialog(
        context: context,
        appDialogType: AppDialogType.ERROR,
        title: 'An Error Occurred.',
        content: '${e.message}',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('e'),
          backgroundColor: Color(0xFFE57373),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppIconButton(
          iconName: IconName.arrowLeftCircle,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppTextFiled(
                  controller: nameController,
                  prefixIcon: AppIconButton(
                    iconName: IconName.profile,
                    onPressed: null,
                  ),
                  hintText: 'Full Name',
                  validator: (name) {
                    return widget.nameValidator.isValid(name);
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                AppTextFiled(
                  controller: emailController,
                  prefixIcon: AppIconButton(
                    iconName: IconName.message,
                    onPressed: null,
                  ),
                  hintText: 'Email',
                  validator: (email) {
                    return widget.emailValidator.isValid(email);
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                AppTextFiled(
                  controller: phoneController,
                  prefixIcon: AppIconButton(
                    iconName: IconName.profile,
                    onPressed: null,
                  ),
                  hintText: 'Phone',
                  validator: (phone) {
                    return widget.phoneValidator.isValid(phone);
                  },
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                AppTextFiled(
                  controller: passwordController,
                  prefixIcon: AppIconButton(
                    iconName: IconName.lock,
                    onPressed: null,
                  ),
                  hintText: 'Password',
                  validator: (password) {
                    return widget.passwordValidator.isValid(password);
                  },
                  isPasswordTextFiled: true,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_) {},
                  textFiledStyle: TextFiledStyle.UnderlineBorder,
                ),
                const SizedBox(
                  height: KAppPadding / 2,
                ),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return AppButton(
                      onPressed: () => _submit(),
                      text: 'Sign Up',
                      borderRadius: 32,
                      loading: authProvider.loading,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

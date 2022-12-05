import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/common_widgets/app_button.dart';
import 'package:shop_app/common_widgets/app_dialog.dart';
import 'package:shop_app/common_widgets/app_sized_box.dart';
import 'package:shop_app/common_widgets/app_icon.dart';
import 'package:shop_app/common_widgets/app_icon_button.dart';
import 'package:shop_app/common_widgets/app_text_field.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helpers/firebase_helper.dart';
import 'package:shop_app/helpers/validation.dart';
import 'package:shop_app/modals/user_modal.dart';
import 'package:shop_app/pages/home/home_page.dart';
import 'package:shop_app/pages/log_in/social_button.dart';
import 'package:shop_app/pages/sign_up/sign_up_page.dart';
import 'package:shop_app/providers/auth_provider.dart';
import 'package:shop_app/providers/user_provider.dart';
import 'package:sizer/sizer.dart';

class LogInPage extends StatefulWidget with ValidateUserEmailAndPassword {
  static const routeName = '/login-page';
  LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate() == true) {
      return;
    }
    _formKey.currentState!.save();
    print(emailController.text);
    print(passwordController.text);
    try {
       await Provider.of<AuthProvider>(context, listen: false)
          .loginWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // UserModal userData = await FirebaseHelper.getUserData(userId: userCredential.user!.uid);
      // Provider.of<UserProvider>(context,listen: false).changeCurrentUserValue(userModal: userData);
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    } on FirebaseAuthException catch (e) {
      // AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.ERROR,
      //     animType: AnimType.SCALE,
      //     headerAnimationLoop: false,
      //     //autoHide: Duration(seconds: 1),
      //     //btnCancelColor: Colors,
      //     title: 'An error occurred.',
      //     desc: '${e.message}',
      //     btnOkColor: Colors.deepPurpleAccent,
      //     btnOkOnPress: () {})
      //   ..show();
      showAppDialog(
        context: context,
        appDialogType: AppDialogType.ERROR,
        title: 'An Error Occurred.',
        content: '${e.message}',
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
          backgroundColor: Color(0xFFE57373),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //final isKeyboardOpened = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              //physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppHSizedBox(),
                  buildAppLogo(),
                  AppHSizedBox(),
                  Text(
                    'Login to shop app',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  ///Email text filed
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

                  ///password text filed
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
                    onFieldSubmitted: (_) => _submit(),
                    textFiledStyle: TextFiledStyle.UnderlineBorder,
                  ),
                  const SizedBox(
                    height: KAppPadding / 2,
                  ),
                  Consumer<AuthProvider>(
                    builder: (context, authProvider, child) {
                      return AppButton(
                        onPressed: () => _submit(),
                        text: 'LOGIN',
                        borderRadius: 32,
                        loading: authProvider.loading,
                      );
                    },
                  ),
                  AppHSizedBox(),
                  buildOrWidget(),
                  AppHSizedBox(),
                  buildSocialButtons(),
                  AppHSizedBox(),
                  buildDoNotHaveAccount(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildAppLogo() {
    return SizedBox(
      width: 50.w,
      height: 20.h,
      child: SvgPicture.asset(
        'assets/icons/shop.svg',
      ),
    );
  }

  Row buildOrWidget() {
    return Row(
      children: [
        Expanded(child: Divider()),
        Text('  Or  '),
        Expanded(child: Divider()),
      ],
    );
  }

  Row buildSocialButtons() {
    return Row(
      children: [
        AppWSizedBox(),
        Expanded(
          child: SocialButton(
            iconName: IconName.facebook,
            text: 'FaceBook',
            buttonColor: Color(0xFF385C8E),
            onPressed: () {},
          ),
        ),
        AppWSizedBox(),
        Expanded(
          child: SocialButton(
            iconName: IconName.google,
            text: 'Google',
            buttonColor: Color(0xFFf14436),
            onPressed: () {},
          ),
        ),
        AppWSizedBox(),
      ],
    );
  }

  Row buildDoNotHaveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Don\'t have an account?/'),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, SignUpPage.routeName);
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

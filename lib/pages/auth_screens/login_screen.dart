import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/data/session_manager.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/auth_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/validators.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/edit_form_widget.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/pages/home_screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool _showPass = true;
  bool _saveAccount = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SessionManager.instance.lastSession = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      hasAppBar: false,
      body: SafeArea(
        child: Container(
          width: getWidth(context),
          height: getHeight(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: setWidth(20)),
                  child: ListView(
                    children: [

                      SizedBox(height: setHeight(24)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ImageLoader(
                            path: AppAssets.imSmartLogoBig,
                            width: setWidth(200),
                            height: setHeight(100),
                            fit: BoxFit.fitWidth,
                          ),

                          TextView(
                            text: "Login",
                            textAlign: TextAlign.start,
                            textStyle: GoogleFonts.roboto(fontSize: 18.sp, color: Pallet.black, fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),

                      SizedBox(height: setHeight(32)),

                      EditFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        label: "Email address",
                        hint: "Email address",
                        autocorrect: false,
                        onChanged: (text){
                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),

                      SizedBox(height: setHeight(24)),

                      EditFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _showPass,
                        suffixIcon: _showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        onPasswordToggle: (){
                          _showPass = !_showPass;
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        onChanged: (text){
                          if (mounted) {
                            setState(() {});
                          }
                        },
                        label: "Password",
                        hint: "Password",
                      ),

                      SizedBox(height: setHeight(48)),

                    ],
                  ),
                ),
              ),

              SizedBox(height: setHeight(24)),

              CustomButtonWidget(
                buttonText: "Login",
                width: getWidth(context) - setWidth(40),
                height: setHeight(50),
                disabled: Validators.validateEmail2(value: emailController.text) != null || passwordController.text.isEmpty,
                onTap: () async {
                  var result = await context.provideOnce<AuthProvider>().loginUser(context: context, email: emailController.text, password: passwordController.text);
                  if (result.error) return;
                  //PageRouter.gotoWidget(HomeScreen(), context, clearStack: true);
                  AppDialog.showAuthDialog(context, onContinue: (){
                    PageRouter.goBack(context);
                    PageRouter.gotoWidget(HomeScreen(), context, clearStack: true);
                  });
                },
              ),

              SizedBox(height: setHeight(16)),

            ],
          ),
        ),
      ),
    );
  }
}
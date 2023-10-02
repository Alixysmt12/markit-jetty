import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markit_jetty/commonwidget/MyText.dart';
import 'package:markit_jetty/commonwidget/custome_text_widget.dart';
import 'package:markit_jetty/controller/auth_controller.dart';
import 'package:markit_jetty/models/user_decode.dart';
import 'package:markit_jetty/routes/route_helper.dart';
import 'package:markit_jetty/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../commonwidget/custome_btn.dart';
import '../controller/batch_controller.dart';
import '../controller/project_controller.dart';
import '../helper/dependencies.dart';
import '../utils/show_custom_snackbar.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void initState() {
    //await init();

    try {
      ///find the controller and
      ///crush here if it's not initialized
      final authController = Get.find<ProjectController>();

      if(authController.initialized)
        Get.toNamed('/auth');
      else {
        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
        //Get.toNamed('/auth');
      }

    } catch(e) {

      Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
      //Get.toNamed('/auth');
    }

    super.initState();
  }

  int? _adminId;
  int? _marketId;

/*  Future<void> getSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _adminId = prefs.getInt(AppConstants.USER_ID);
    _marketId = prefs.getInt(AppConstants.COMPANY_ID);

    setState(() {
      _controller = new TextEditingController(text: _name);
    });
  }*/

  /*@override
  void initState() {
    super.initState();
    _adminId = 0;
    _marketId = 0;
    getSharedPrefs();
  }*/

  @override
  Widget build(BuildContext context) {

    try {
      ///find the controller and
      ///crush here if it's not initialized
      final authController = Get.find<ProjectController>();

      if(authController.initialized)
        Get.toNamed('/auth');
      else {
        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
        //Get.toNamed('/auth');
      }

    } catch(e) {

      Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
      //Get.toNamed('/auth');
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children:[
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                "assets/images/loginbgsplash.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 30,
              ),
              Transform.scale(
                scale: .8,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset("assets/images/jetty04.png"),
                ),
              ),
              /*  Container(
              padding: EdgeInsets.only(
                bottom: 3, // Space between underline and text
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: AppColors.mainColor2,
                width: 1.0, // Underline thickness
              ))),
              child: MyText(text: "Sign In"),
            ),*/
              SizedBox(
                height: 30,
              ),
              Container(
                width: 310,
                padding: EdgeInsets.all(
                  13,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(-2, 3), // changes position of shadow
                      ),
                    ]),


                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      //Text("Login"),
                      Container(
                        width: 250,
                        height: 70,
                        child: CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                          icon: Icons.mail_outline,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 250,
                        height: 70,
                        child: CustomTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        width: 200,
                        height: 45,
                        child: CustomButton(
                            text: "Sign In",
                            onTap: () async {
                              //await init();
                              if (_signInFormKey.currentState!.validate()) {
                                // signUpUser();
                                //HomePage()
                                var authController = Get.find<AuthController>();
                                authController
                                    .login(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                )
                                    .then((status) async {
                                  if (status.token != null) {
                                    status.token;

                                    //String encoded = base64.encode(utf8.encode(credentials)); // dXNlcm5hbWU6cGFzc3dvcmQ=
                                    //String decoded = utf8.decode(base64.decode(status.token!));
                                    //Map<String, dynamic> myObject ;

                                    var tokenData =
                                        json.decode(json.encode(status.token));

                                    /*    List<String> myObject;
                                  myObject = tokenData.split(".");*/

                                    String myObjectNormalize =
                                        tokenData.split(".")[1];

                                    List<int> myObjectNor = base64.decode(
                                        base64.normalize(myObjectNormalize));
                                    //print(myObject[1]);

                                    String dec = utf8.decode(myObjectNor);

                                    /*   String decoded =
                                      utf8.decode(base64.decode(myObject[1]));*/

                                    Map<String, dynamic> map = jsonDecode(dec);
                                    UserDecode user = UserDecode.fromJson(map);

                                    String userId = user.id.toString();
                                    user.name;
                                    String userCompanyId =
                                        user.companyId.toString();
                                    //Get.find<ProjectController>().getProjectList("51","1");

                                    Get.find<ProjectController>()
                                        .getProjectList(userId, userCompanyId);

                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool("isLoggedIn", true);
                                    prefs.setString("userId", userId);
                                    prefs.setString(
                                        "userCompanyId", userCompanyId);
                                    prefs.setString("name", user.name!);
                                    prefs.setString("userName",  user.userName!);
                                    /*       Get.find<FieldAchievementController>()
                                      .fieldAchievementData();*/
/*
                                  Get.toNamed(RouteHelper.getNavePages(),
                                      arguments: [user.name, user.userName]);*/

                                    try {
                                      ///find the controller and
                                      ///crush here if it's not initialized
                                      final authController = Get.find<ProjectController>();

                                      if(authController.initialized)
                                        Get.toNamed('/auth');
                                      else {
                                        Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
                                        //Get.toNamed('/auth');
                                      }

                                    } catch(e) {

                                      Get.lazyPut(() => ProjectController(projectRepo: Get.find()));
                                      //Get.toNamed('/auth');
                                    }

                                    Get.offNamedUntil(RouteHelper.getNavePages(),
                                        (route) => false,
                                        arguments: [user.name, user.userName]);
                                    /*  if (!mounted) return;
                                  Navigator.pop(context);*/
                                    //sharedPreferences.setString(AppConstants.USER_ID,user.id.toString());

                                    //Get.toNamed(RouteHelper.navPages,parameters: )
                                    //showCustomSnackBar(status.status.toString());
                                  } else {
                                    //Get.find<ProjectController>().getProjectList("51","1");
                                    //Get.toNamed(RouteHelper.getBottomScreen());

                                    showCustomSnackBar(
                                        "Check your Email or Password!");
                                  }
                                });

                                /*await Get.to(HomePage(),
                                    transition: Transition.rightToLeftWithFade);*/
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                width: 300,
                child: Transform.scale(
                  scale: 0.3,
                  child: Image.asset(
                    "assets/images/pb2.png",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

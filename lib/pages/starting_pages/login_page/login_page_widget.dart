import '../../../generated/l10n.dart';
import '../../../manager/userProfileManager.dart';
import '../../../model/userModel.dart';
import '../../../userProfileProvider.dart';

import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'login_page_model.dart';
export 'login_page_model.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({Key? key}) : super(key: key);

  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  late LoginPageModel _model;
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Widget _buildHeader() {
    return Container(
      width: 154,
      height: 59,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Text(
            '${S.of(context).hi}',
            style: TextStyle(
              color: Color(0xFF1D1517),
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0.09,
            ),
          ),
          Positioned(
            top: 29,
            child: Text(
              '${S.of(context).welcome}',
              style: TextStyle(
                color: Color(0xFF1D1517),
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                height: 0.07,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String labelText, IconData iconData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          labelText,
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            obscureText: labelText == '${S.of(context).name}' ? false : true,
            keyboardType: TextInputType.emailAddress,
            controller:
                labelText == '${S.of(context).name}' ? _accountController : _passwordController,
            style: TextStyle(
              color: Colors.black38,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                iconData,
                color: Colors.blueGrey,
              ),
              hintText: labelText == '${S.of(context).name}' ? '${S.of(context).en_account_name}' : '${S.of(context).en_pass}',
              hintStyle: TextStyle(
                color: Color(0xFFADA9BB),
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 60.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.00, 0.08),
          end: Alignment(1, -0.08),
          colors: [Color(0xFFA192FD), Color(0xFF9DCEFF)],
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: FFButtonWidget(
        onPressed: () async {
          final userProfileProvider = context.read<UserProfileProvider>();

          String token = await UserProfileManager()
              .login(_accountController.text, _passwordController.text);
          UserProfile newProfile = await UserProfileManager()
              .getUserProfile(token);
          final updatedProfile =
          newProfile.copyWith(token: token,password: _passwordController.text);
          userProfileProvider.updateUserProfile(updatedProfile);
          print("${userProfileProvider.userProfile!.token}");
          context.pushNamed(
            'HomePage',
            extra: <String, dynamic>{
              kTransitionInfoKey: TransitionInfo(
                hasTransition: true,
                transitionType: PageTransitionType.fade,
              ),
            },
          );
        },
        iconData: Icons.login,
        text: '${S.of(context).login}',
        options: FFButtonOptions(
          width: double.infinity,
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: Colors.transparent,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
          ),
          elevation: 0.0,
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildHeader(),
                    SizedBox(height: 30.0),
                    _buildInputField('${S.of(context).name}', Icons.email),
                    SizedBox(height: 30.0),
                    _buildInputField('${S.of(context).password}', Icons.lock),
                    SizedBox(height: 80.0),
                    _buildLoginButton(),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () async {
                        context.pushNamed(
                          'MobileSignIn',
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${S.of(context).hn_account}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: ' ${S.of(context).reg}',
                              style: TextStyle(
                                color: Color(0xFFC58BF2),
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

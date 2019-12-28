import 'package:bloc_firebase_validation/bloc_Validation/bloc.dart';
import 'package:bloc_firebase_validation/bloc_Validation/firebase_bloc_bloc.dart';
import 'package:bloc_firebase_validation/bloc_Validation/firebase_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class signInForm extends StatefulWidget {
  final double topRight;
  final double bottomRight;

  signInForm(this.topRight, this.bottomRight);

  @override
  _signInFormState createState() => _signInFormState();
}

class _signInFormState extends State<signInForm> {
  var shadowColors;
  String _email = '';
  String _password = '';
  String error = '';
  final _formkey = GlobalKey<FormState>();
  FirebaseBlocBloc _signInBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<FirebaseBlocBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseBlocBloc, FirebaseBlocState>(
        builder: (context, state) {
      if (state is SignInIsEmailValid) {
        return buildListView(context, _signInBloc, isEmailValid: state.isValid);
      }
      if (state is SignInIsPasswordValid) {
        return buildListView(context, _signInBloc,
            isPasswordValid: state.isValid);
      }
      if (state is SigningInError) {
        return buildListView(context, _signInBloc,
            signInErrorMessage: state.message);
      }
      return buildListView(context, _signInBloc,
          isEmailValid: true,
          isPasswordValid: true,
          signInErrorMessage: "App has just Started");
    });
  }

  ListView buildListView(BuildContext context, FirebaseBlocBloc _signInBloc,
      {bool isEmailValid, bool isPasswordValid, String signInErrorMessage}) {
    if(isEmailValid){
      shadowColors[0] = emailSignInDefaultShadowColor;
    }
    else{
      shadowColors[1] = emailSignInErrorShadowColor;
    }
    if(isPasswordValid){
      shadowColors[1] = passwordSignInDefaultShadowColor;
    }
    else{
      shadowColors[1] = passwordSignInErrorShadowColor;
    }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 40, bottom: 30, top: 240),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              height: 264,
              child: Form(
                autovalidate: true,
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 10),
                        child: Text(
                          "Email",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFB300)),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Material(
                        shadowColor: shadowColors[0],
                        elevation: 10,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(widget.bottomRight),
                                topRight: Radius.circular(widget.topRight))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 20, top: 10, bottom: 10),
                          child: Stack(children: <Widget>[
                            TextFormField(
                              controller: _emailController,
                              onTap: () {
                                print("ds");
                              },
                              validator: (val) {
                                if(!isEmailValid && _emailController.text.isNotEmpty){
                                  shadowColors[0] = emailSignInErrorShadowColor;
                                  return "THE EMAIL COMPOSITION IS INVALID";
                                }
                                else{
                                  shadowColors[1] = emailSignInDefaultShadowColor;
                                  return null;
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  _email = value;
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "JohnDoe@example.com",
                                  hintStyle: TextStyle(
                                      color: Color(0xFFE1E1E1), fontSize: 14)),
                            ),
//
                          ]),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.only(left: 40, bottom: 5, top: 10),
                        child: Text(
                          "Password",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFB300)),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Material(
                        shadowColor: shadowColors[1],
                        elevation: 10,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(widget.bottomRight),
                                topRight: Radius.circular(widget.topRight))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 40, right: 20, top: 10, bottom: 10),
                          child: Stack(
                            children: <Widget>[
                              TextFormField(
                                controller: _passwordController,
                                onTap: () {},
                                obscureText: true,
                                validator: (val) {
                                  if (!isPasswordValid && _passwordController.text.isNotEmpty) {
                                    shadowColors[1] = passwordSignInErrorShadowColor;
                                    return "PASSWORD MUST BE LONGER THAN 5 CHARACTERS AND BE COMPOSED OF BOTH LETTERS AND NUMBERS";
                                  } else {
                                    shadowColors[1] = passwordSignInDefaultShadowColor;
                                    return null;
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _password = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                        color: Color(0xFFE1E1E1),
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.loose,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * (2 / 3),
                            10,
                            0.0,
                            0.0),
                        child: GestureDetector(
                          onTap: () {
                            _signInBloc.add(SignIn(
                                email: _emailController.text,
                                password: _passwordController.text));
//                          if (_formkey.currentState.validate()) {
//                            print("Validation Succesfull");
//                          } else {
//                            setState(() {
//                              shadowColors = signinErrorShadowColors;
//                            });
//                          }
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: ShapeDecoration(
                              shape: CircleBorder(),
                              gradient: LinearGradient(
                                  colors: signInGradients,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight),
                            ),
                            child: ImageIcon(
                              AssetImage("assets/ic_forward.png"),
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }

  void _onEmailChanged() {
    _signInBloc.add(SignInEmailChanged(_emailController.text));
  }

  void _onPasswordChanged() {
    _signInBloc.add(SignInPasswordChanged(_passwordController.text));
  }
}

const List<Color> signinDefaultShadowColors = [
  Colors.lightBlue,
  Color(0xFF00E676)
];

Color emailSignInDefaultShadowColor = Colors.lightBlue;
Color passwordSignInDefaultShadowColor = Color(0xFF00E676);
Color emailSignInErrorShadowColor = Color(0xFFFF1744);
Color passwordSignInErrorShadowColor = Color(0xFFFF1744);

const List<Color> signinErrorShadowColors = [
  Color(0xFFFF1744),
  Color(0xFFFF1744)
];

const List<Color> signInGradients = [
  Color(0xFF0EDED2),
  Color(0xFF03A0FE),
];

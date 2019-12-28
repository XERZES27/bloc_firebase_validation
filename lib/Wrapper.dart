import 'package:bloc_firebase_validation/UI/validationUI/signInForm.dart';
import 'package:bloc_firebase_validation/bloc_Validation/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'UI/validationUI/signUpForm.dart';
import 'models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<FirebaseBlocBloc,FirebaseBlocState>(
        // ignore: missing_return
        builder: (context,state){
          if(state is SignedIn){

          }
          if(state is SignOut){
            BlocProvider.of<FirebaseBlocBloc>(context).add(LaunchSignInPage());
          }
          if(state is SignInPage){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_)=>BlocProvider.value(
                value: BlocProvider.of<FirebaseBlocBloc>(context),
                child: signInForm(30,30),

              )
            ));
          }
          if(state is SignUpPage){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_)=> BlocProvider.value(
                value: BlocProvider.of<FirebaseBlocBloc>(context),
                child: signUpForm(),
              )
            ));
          }

        },
      )

    );
  }
}




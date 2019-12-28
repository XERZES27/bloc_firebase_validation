import 'package:bloc_firebase_validation/UI/validationUI/Streams/signInEmailStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signInPasswordStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signUpEmailStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signUpPasswordStream.dart';
import 'package:bloc_firebase_validation/bloc_Validation/bloc.dart';
import 'package:bloc_firebase_validation/bloc_Validation/firebaseBlocDelegate.dart';
import 'package:bloc_firebase_validation/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'Routes/Routes.dart';
import 'Wrapper.dart';
import 'bloc_Validation/firebase_bloc_bloc.dart';
import 'package:sailor/sailor.dart';
void main(){
  Routes.createRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    BlocSupervisor.delegate = firebaseBlocDelegate();

    return MaterialApp(

      title: "Validation Test",
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
      home: BlocProvider(

        create: (context)=>FirebaseBlocBloc(AuthService(),signInEmailStream(),signInPasswordStream(),signUpEmailStream(),signUpPasswordStream())..add(AppStarted()),
        child: Wrapper(),



      ),


    );
  }
}








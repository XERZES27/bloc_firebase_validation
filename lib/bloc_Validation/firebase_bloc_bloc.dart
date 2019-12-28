import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signInEmailStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signInPasswordStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signUpEmailStream.dart';
import 'package:bloc_firebase_validation/UI/validationUI/Streams/signUpPasswordStream.dart';
import 'package:bloc_firebase_validation/services/Validator.dart';
import 'bloc.dart';
import 'package:bloc_firebase_validation/services/auth.dart';

class FirebaseBlocBloc extends Bloc<FirebaseBlocEvent, FirebaseBlocState> {

  @override
  FirebaseBlocState get initialState => InitialFirebaseBlocState();
  final AuthService authService;
  final signInEmailStream _signInEmailStream;
  final signInPasswordStream _signInPasswordStream;
  final signUpEmailStream _signUpEmailStream;
  final signUpPasswordStream _signUpPasswordStream;
  StreamSubscription subscriptionSignInEmail;
  StreamSubscription subscriptionSignInPassword;
  StreamSubscription subscriptionSignUpEmail;
  StreamSubscription subscriptionSignUpPassword;
  FirebaseBlocBloc(this.authService, this._signInEmailStream, this._signInPasswordStream, this._signUpEmailStream, this._signUpPasswordStream);

  @override
  Stream<FirebaseBlocState> mapEventToState(
    FirebaseBlocEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    else if(event is LaunchSignInPage){
      subscriptionSignInEmail?.cancel();
      subscriptionSignInPassword?.cancel();
      subscriptionSignInEmail = _signInEmailStream.get().listen((value){
        add(SignInEmailChanged(value));
      });
      subscriptionSignInPassword = _signInPasswordStream.get().listen((value){
        add(SignInPasswordChanged(value));
      });
      yield SignInPage();
    }
    else if(event is LaunchSignUpPage){
      subscriptionSignUpEmail?.cancel();
      subscriptionSignUpPassword?.cancel();
      subscriptionSignUpEmail = _signUpEmailStream.get().listen((value){
        add(SignUpEmailChanged(value));
      });
      subscriptionSignUpPassword = _signUpPasswordStream.get().listen((value){
        add(SignUpPasswordChanged(value));
      });
      yield SignUpPage();
    }
    else if (event is SignIn) {
      yield SigningInLoading();
      try {
        final user = await authService.signIn(event.email, event.password);
        yield SignedIn(user);
      } catch (exception) {
        yield SigningInError(exception.toString());
      }
    } else if (event is SignUp) {
      yield SigningUpLoading();
      try {
        final user = await authService.signUp(event.email, event.password);
        add(SendEmailVerification());


      } catch (exception) {
        yield SigningUpError(exception.toString());
      }
    }
    else if(event is SendEmailVerification){

      await authService.sendEmailVerification();
      while(await authService.isVerified()==false){
        yield WaitingForEmailVerification();
      }
      yield SignedIn(authService.user);

    }


    else if (event is SignOut) {
      yield SigningOutLoading();
      try {
        await authService.signOut();
        yield SignedOut();
      } catch (exception) {
        yield SigningOutError(exception.toString());
      }
    }
    else if(event is SignInEmailChanged){
        yield SignInIsEmailValid(Validators.isValidEmail(event.email));

    }

    else if(event is SignInPasswordChanged){
      yield SignInIsPasswordValid(Validators.isValidPassword(event.password));
    }
    else if(event is SignInEmailChanged){
      yield SignUpIsEmailValid(Validators.isValidEmail(event.email));

    }

    else if(event is SignInPasswordChanged){
      yield SignUpIsPasswordValid(Validators.isValidPassword(event.password));
    }
  }



  Stream<FirebaseBlocState> _mapAppStartedToState() async* {
    final user = authService.user.listen((user) {
      try {
        if (user.uid == "null") {
          return "null";
        } else {
          return user;
        }
      } catch (exception) {
        return "null";
      }
    });
    void dispose() {
      user.cancel();
    }

    if (user.toString() == "null") {
      yield SignedOut();
    } else {
      yield SignedIn(user);
    }
  }
}

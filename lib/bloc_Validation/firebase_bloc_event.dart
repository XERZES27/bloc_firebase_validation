import 'package:equatable/equatable.dart';

abstract class FirebaseBlocEvent extends Equatable {
  const FirebaseBlocEvent();
}

class AppStarted extends FirebaseBlocEvent{
  @override
  List<Object> get props => null;
}

class LaunchSignInPage extends FirebaseBlocEvent{
  @override
  List<Object> get props => null;
}

class LaunchSignUpPage extends FirebaseBlocEvent{
  @override
  List<Object> get props => null;
}

class SignIn extends FirebaseBlocEvent{
  final String email;
  final String password;
  const SignIn({this.email,this.password});
  @override
  List<Object> get props => [email,password];

}

class SignUp extends FirebaseBlocEvent{
  final String email;
  final String password;
  const SignUp({this.email,this.password});
  @override
  List<Object> get props => [email,password];
}

class SignOut extends FirebaseBlocEvent {
  const SignOut();
  @override
  List<Object> get props => null;
}

class SignInEmailChanged extends FirebaseBlocEvent{
  final String email;
  const SignInEmailChanged(this.email);
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged { email :$email }';
}

class SignInPasswordChanged extends FirebaseBlocEvent{
  final String password;
  const SignInPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class SignUpEmailChanged extends FirebaseBlocEvent{
  final String email;
  const SignUpEmailChanged(this.email);
  @override
  List<Object> get props => [email];
  @override
  String toString() => 'EmailChanged { email :$email }';
}

class SignUpPasswordChanged extends FirebaseBlocEvent{
  final String password;
  const SignUpPasswordChanged(this.password);
  @override
  List<Object> get props => [password];
  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class SendEmailVerification extends FirebaseBlocEvent{
  @override
  List<Object> get props => null;
}
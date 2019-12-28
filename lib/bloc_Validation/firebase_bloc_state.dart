import 'package:equatable/equatable.dart';

abstract class FirebaseBlocState extends Equatable {
  const FirebaseBlocState();
}

class InitialFirebaseBlocState extends FirebaseBlocState {
  @override
  List<Object> get props => [];
}

class SignInPage extends FirebaseBlocState{
  @override
  List<Object> get props => null;
}

class SignUpPage extends FirebaseBlocState{
  @override
  List<Object> get props => null;
}

class SignedOut extends FirebaseBlocState{
  const SignedOut();
  @override
  List<Object> get props => null;

}

class SignedIn extends FirebaseBlocState{
  final result;
  const SignedIn(this.result);
  @override
  List<Object> get props => [result];

}

class SigningInLoading extends FirebaseBlocState{
  const SigningInLoading();
  @override
  List<Object> get props => null;
}

class SigningUpLoading extends FirebaseBlocState{
  const SigningUpLoading();
  @override
  List<Object> get props => null;
}

class SigningOutLoading extends FirebaseBlocState{
  const SigningOutLoading();
  @override
  List<Object> get props => null;
}

class SigningInError extends FirebaseBlocState{
  final String message;
  const SigningInError(this.message);
  @override
  List<Object> get props => [message];
}

class SigningUpError extends FirebaseBlocState{
  final String message;
  const SigningUpError(this.message);

  @override
  List<Object> get props => [message];
}

class SigningOutError extends FirebaseBlocState{
  final String message;
  const SigningOutError(this.message);
  @override
  List<Object> get props => [message];
}

class SignInIsEmailValid extends FirebaseBlocState{
  final bool isValid;
  const SignInIsEmailValid(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class SignInIsPasswordValid extends FirebaseBlocState{
  final bool isValid;
  const SignInIsPasswordValid(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class SignUpIsEmailValid extends FirebaseBlocState{
  final bool isValid;
  const SignUpIsEmailValid(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class SignUpIsPasswordValid extends FirebaseBlocState{
  final bool isValid;
  const SignUpIsPasswordValid(this.isValid);
  @override
  List<Object> get props => [isValid];
}

class WaitingForEmailVerification extends FirebaseBlocState{
  @override
  List<Object> get props => null;
}

class EmailIsVerified extends FirebaseBlocState{
  @override
  List<Object> get props => null;
}


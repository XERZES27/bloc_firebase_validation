import 'dart:async';

class signUpEmailStream{
  StreamController<String> controller = StreamController();
  Stream stream;
  emailStream(){
    stream = controller.stream;
  }
  set(String email){
    controller.add(email);
  }
  Stream get(){
    return stream;
  }

}
import 'dart:async';

class signInPasswordStream{
  StreamController<String> controller = StreamController();
  Stream stream;
  passwordStream(){
    stream = controller.stream;
  }
  set(String password){
    controller.add(password);
  }
  Stream get(){
    return stream;
  }

}
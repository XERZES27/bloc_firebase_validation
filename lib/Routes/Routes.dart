import 'package:bloc_firebase_validation/UI/HomePage.dart';
import 'package:sailor/sailor.dart';

class Routes{
  static final sailor = Sailor();

  static void createRoutes(){
    sailor.addRoutes([
      SailorRoute(
        name: '/HomePage',
        builder: (context,args,params){
          return HomePage();
        }
      )

    ]);




  }


}
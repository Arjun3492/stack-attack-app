import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/auth/firebase_auth.dart';
import 'package:flutter_architecture/modules/home/screen/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'core/environment/environment.dart';
import 'modules/login/screen/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await dotenv.load(fileName: Environment.fileName);
  // } catch (EmptyEnvFileError) {
  //   rethrow;
  // }
  // await Firebase.initializeApp().then((value) {
  //   Get.put(FireAuthController());
  // });
  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        //Routes for the app
        GetPage(name: '/', page: () => Home()),
        GetPage(name: '/login', page: () => LoginPage()),
      ],
      title: "Flutter Architecture",
      // initialRoute: '/',
    );
  }
}

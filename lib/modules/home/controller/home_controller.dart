import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    // Called immediately after the widget is allocated in memory.
    // You might use this to initialize something for the controller.
    super.onInit();
  }

  @override
  void onReady() {
// Called 1 frame after onInit().
//It is the perfect place to enter navigation events, like snackbar, dialogs, or a new route, or async request.    // super.onReady();
  }

  @override
  void onClose() {
    // user for disposing objects that can potentially create some memory leaks,
    //like TextEditingControllers, AnimationControllers.
    super.onClose();
  }
}
